<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"	 %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<!-- 배송지 직접 입력 -->
<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
    const shippingMsg = document.getElementById('shippingMsg');
    const selfType = document.getElementById('selfType');
  
    shippingMsg.addEventListener('change', function() {
      if (shippingMsg.value === '직접입력') {
        selfType.style.display = 'inline-block';
      } else {
        selfType.style.display = 'none';
      }
    });
  });
  </script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>   
  $(function() {
	  //배송지 라디오버튼
      $('input[name="flexRadioDefault"]').change(function() {
        if ($(this).attr('id') === 'flexRadioDefault2') {
          $('#existingAddressContainer').slideDown();
          $('#saveBtn').hide();
          $("#nickName").hide();
        } else {
          $('#existingAddressContainer').slideUp();
          $('#saveBtn').show();
          $("#nickName").show();
        }
      });
	  $("#saveBtn").click(function() {
		  var delivery_receiver = $("#receiver").val();
		  var delivery_postcode = $("#sample6_postcode").val();
		  var delivery_nickName = $("#delivery_nickName").val();
		  var delivery_address = $("#sample6_address").val();
		  var delivery_detailAddress = $("#sample6_detailAddress").val();
		  var delivery_phoneNo = $("#receiver_phoneNo1").val() + $("#receiver_phoneNo2").val() + $("#receiver_phoneNo3").val();
		  $.ajax({
			  url : "${path}/ajax/deliverySave",
			  method : "POST",
			  contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			  data : {
				  delivery_receiver : delivery_receiver,
				  delivery_postcode : delivery_postcode,
				  delivery_nickName : delivery_nickName,
				  delivery_address : delivery_address,
				  delivery_detailAddress : delivery_detailAddress,
				  delivery_phoneNo : delivery_phoneNo
			  }, success : function(result) {
				  alert(result)
			  }, error : function(e) {
				  alert("배송지 저장 에러: " + e.status)
			  }
		  })
	  })
	  $("#searchPostcode").click(function() {
		  sample6_execDaumPostcode();
	  })
	  $("#existingAddressSelect").change(function() {
		  var selectedOption = $(this).val();
		  $.ajax({
			  url : "${path}/ajax/deliverySelect",
			  method : "POST",
			  contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			  data : {
				  selectedOption : selectedOption
			  }, success : function(result) {
				  $("#receiver").val(result.delivery_receiver);
				  $("#sample6_postcode").val(result.delivery_postcode);
				  $("#delivery_nickName").val(result.delivery_nickName);
				  $("#sample6_address").val(result.delivery_address);
				  $("#sample6_detailAddress").val(result.delivery_detailAddress);
				  $("#receiver_phoneNo1").val(result.delivery_phoneNo.substr(0,3));
				  $("#receiver_phoneNo2").val(result.delivery_phoneNo.substr(3,4));
				  $("#receiver_phoneNo3").val(result.delivery_phoneNo.substr(7,4));
				  console.log(result.delivery_receiver);
				  console.log(result.delivery_phoneNo.substr(3,4));
				  console.log(result.delivery_phoneNo.substr(7,4));
			  }, error : function(e) {
				  alert("배송지 불러오기 에러: " + e.status)
			  }
		  })
	  })
	  //포인트 사용
	  $("#order_point").keyup(function() {
		  $("#pointMsg").text("")
		  var regex = /^\d+$/;
		  var msg = "";		  
		  var point = parseInt($("#order_point").val());
		  if($("#order_point").val() == "") point = 0;		  
		  var mem_point = parseInt($("#mem_point").val());
		  var final_amount = parseInt($("#final_amount").val());
		  if($("#order_point").val().includes(" ")) {
			  msg = "유효하지 않은 포인트 값입니다.";
			  $("#pointMsg").text(msg)
		  } else if($("#order_point").val() != 0 && !regex.test($("#order_point").val())) {
			  msg = "유효하지 않은 포인트 값입니다.";
			  $("#pointMsg").text(msg)
		  } else if(point > mem_point) {
			  msg = "보유포인트 보다 많은 포인트를 사용할 수 없습니다.";
			  $("#pointMsg").text(msg)
		  } else if (point > final_amount) {
			  msg = "결제하려는 금액보다 사용하려는 포인트가 많습니다."
			  $("#pointMsg").text(msg)
		  } else if(point <0 ) {
			  msg = "유효하지 않은 포인트값입니다."
		  }	else {
			  $("#pointMsg").text("")
			  $("#total").text(final_amount - point)
			  $("#Total").text(final_amount - point)
		  }
	  })
    });
  function sample6_execDaumPostcode() {
      new daum.Postcode({
          oncomplete: function(data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

              // 각 주소의 노출 규칙에 따라 주소를 조합한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var addr = ''; // 주소 변수
              var extraAddr = ''; // 참고항목 변수

              //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
              if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                  addr = data.roadAddress;
              } else { // 사용자가 지번 주소를 선택했을 경우(J)
                  addr = data.jibunAddress;
              }

              // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
              if(data.userSelectedType === 'R'){
                  // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                  // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                  if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                      extraAddr += data.bname;
                  }
                  // 건물명이 있고, 공동주택일 경우 추가한다.
                  if(data.buildingName !== '' && data.apartment === 'Y'){
                      extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                  }
                  // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                  if(extraAddr !== ''){
                      extraAddr = ' (' + extraAddr + ')';
                  }
              
              } else {
//                  document.getElementById("sample6_extraAddress").value = '';
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('sample6_postcode').value = data.zonecode;
              document.getElementById("sample6_address").value = addr;
              // 커서를 상세주소 필드로 이동한다.
              document.getElementById("sample6_detailAddress").focus();
          }
      }).open();
  }
  </script>
<!-- 전화번호 자르기.. -->
<script>
	$(function() {
		const phoneNumber = "${mem.mem_phoneno}";
		const phone1 = phoneNumber.substr(0, 3);
		const phone2 = phoneNumber.substr(3, 4);
		const phone3 = phoneNumber.substr(7, 4);
		$("#phone1").val(phone1);
		$("#phone2").val(phone2);
		$("#phone3").val(phone3);
	})
</script>
<!-- 결제 정보 이동 -->
<style>
  .sticky-card {
    position: fixed;
    top: 250px; /* 고정된 위치의 상단 여백 조정 */
    right: 150px; /* 고정된 위치의 우측 여백 조정 */
  }
</style>
</head>
<body>

	<div class="container">
	<form action="../order/orderConfiguration" method="POST" name="f" onsubmit="return input_check(this)">
		<input type="hidden" name="order_id" value="${order_id }">
	  <h1>주문정보</h1>      
      <div class="row">
        <div class="col-lg-6">
          <hr>
          <table class="table text-center">
            <tr>
              <th class="align-middle"></th>
              <th class="align-middle">상품명</th>
              <th class="align-middle">옵션명</th>
              <th class="align-middle">수량</th>
            </tr>            
            <c:if test="${from == 'cart' }">
            <c:forEach items="${map }" var="map">
            <input type="hidden" name="opt_number" value="${map.value.opt_number }">
            <input type="hidden" name="product_number" value="${map.value.product_number }">
            <input type="hidden" name="opt_count" value="${map.key.opt_count }">
            <input type="hidden" name="product_name" class="product_name" value="${map.value.product_name }">
            <tr>
              <td class="align-middle">
                <div class="d-flex justify-content-center">
                  <img src="${path }/img/thumb/${map.value.product_thumb }" style="width:100px;height:100px;">
                </div>
              </td>
              <td class="align-middle">${map.value.product_name }</td>
              <td class="align-middle">${map.value.opt_name }</td>
              <td class="align-middle">${map.key.opt_count }개</td>
            </tr>
            </c:forEach>
            </c:if>
            <c:if test="${from != 'cart' }">
            <c:forEach items="${povList }" var="pov">
            <input type="hidden" name="opt_number" value="${pov.key.opt_number }">
            <input type="hidden" name="product_number" value="${pov.key.product_number }">
            <input type="hidden" name="opt_count" value="${pov.value }">
            <input type="hidden" name="product_name" class="product_name" value="${pov.key.product_name }">
            <tr>
              <td class="align-middle">
                <div class="d-flex justify-content-center">
                  <img src="${path }/img/thumb/${pov.key.product_thumb }" style="width:100px;height:100px;">
                </div>
              </td>
              <td class="align-middle">${pov.key.product_name }</td>
              <td class="align-middle">${pov.key.opt_name }</td>
              <td class="align-middle">${pov.value }</td>
            </tr>
            </c:forEach>
            </c:if>
          </table>
        </div>
      </div>
      <h1 class="mt-5">주문/배송정보</h1>
      <div class="row mt-4">
        <div class="col-lg-6">
          <hr>
            <div class="mb-3 row">
              <label for="namex" class="col-sm-2 col-form-label">주문자</label>
              <div class="col-sm-3">
                <input type="text" class="form-control" id="name" name="mem_name" value="${mem.mem_name }" readonly> 
              </div>
            </div>

            <div class="mb-3 row">
              <label for="phone1" class="col-sm-2 col-form-label">연락처</label>
              <input type="hidden" name="mem_phoneno" value="${mem.mem_phoneno }">
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-3">
                    <input type="text" class="form-control" id="phone1" maxlength="3" readonly>
                  </div>
                  <div class="col-sm-1 text-center">-</div>
                  <div class="col-sm-3">
                    <input type="text" class="form-control" id="phone2" maxlength="4" readonly>
                  </div>
                  <div class="col-sm-1 text-center">-</div>
                  <div class="col-sm-3">
                    <input type="text" class="form-control" id="phone3" maxlength="4" readonly>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="mb-3 row">
              <label for="name" class="col-sm-2 col-form-label">이메일</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="email" value="${mem.mem_id }" name="mem_id" readonly>
              </div>
            </div>

					<div class="mb-3 row">
              <label for="name" class="col-sm-2 col-form-label">배송지 작성</label>
              <div class="col-sm-10">
                <div class="mb-1">
                  <div class="d-flex">
                    <div class="form-check me-3">
                      <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" value="new">
                      <label class="form-check-label" for="flexRadioDefault1">
                        신규 배송지 입력
                      </label>
                    </div>
                    <div class="form-check">
                      <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" value="og">
                      <label class="form-check-label" for="flexRadioDefault2">
                        기존 배송지 선택
                      </label>
                    </div>

                  </div>
                  <br>
                  <div class="form-group" id="existingAddressContainer" style="display: none;">
                    <select class="form-select" id="existingAddressSelect" name="existingAddressSelect">
                    	<option value="optionNotSelected" disabled selected>배송지를 선택하세요.</option>
                      <c:forEach items="${deliveryList }" var="d">
                      	<option value="${d.delivery_number }" class="deliverySelect">${d.delivery_nickName }</option>
                      </c:forEach>                      
                    </select>
                  </div>
                  <div style="display: none;" id="nickName">
                  	<label for="name" class="form-label mb-0">배송지 별명</label> 
                  	<input type="text" class="form-control" id="delivery_nickName" name="delivery_nickName">
                  </div>

                </div>
              </div>
            </div>
					<div class="mb-3 row">
						<label for="name" class="col-sm-2 col-form-label"></label>
						<div class="col-sm-10">
							<div class="mb-1">
								<label for="name" class="form-label mb-0">받으실 분</label> 
								<input type="text" class="form-control" id="receiver" name="deliver_receiver">
							</div>
						</div>
					</div>
					<div class="mb-3 row">
              <label for="name" class="col-sm-2 col-form-label"></label>
              <div class="col-sm-3">
                <div class="mb-1">
                  <label for="name" class="form-label">주소 &nbsp;&nbsp;</label>
                  <div class="input-group">
                    <input type="text" class="form-control" name="delivery_postcode" id="sample6_postcode" placeholder="우편번호" readonly>
                    <input type="button" class="btn btn-light " id="searchPostcode" value="우편번호 찾기"><br>                  
                  </div>
                </div>                
              </div>
            </div>
            <div class="mb-1 row">
              <label for="name" class="col-sm-2 col-form-label"></label>
              <div class="col-sm-10">
                <div class="mb-1">
                  <input type="text" class="form-control" name="delivery_address" id="sample6_address" placeholder="주소" readonly><br>
                </div>
              </div>
            </div>
            <div class="mb-3 row">
              <label for="name" class="col-sm-2 col-form-label"></label>
              <div class="col-sm-10">
                <div class="mb-1">
                  <input type="text" class="form-control" name="delivery_detailAddress" id="sample6_detailAddress" placeholder="상세주소">
                </div>
              </div>
            </div>
            <div class="mb-1 row">
              <label for="name" class="col-sm-2 col-form-label"></label>
              <label for="phone1" class="col-sm-2 col-form-label">연락처</label>
            </div>
            <div class="mb-3 row">
              <label for="name" class="col-sm-2 col-form-label"></label>
              <div class="col-sm-10">
                <div class="row">
                  <div class="col-sm-3">
                    <input type="text" class="form-control" id="receiver_phoneNo1" name="receiver_phoneNo1" maxlength="3">
                  </div>
                  <div class="col-sm-1 text-center">-</div>
                  <div class="col-sm-3">
                    <input type="text" class="form-control" id="receiver_phoneNo2" name="receiver_phoneNo2" maxlength="4">
                  </div>
                  <div class="col-sm-1 text-center">-</div>
                  <div class="col-sm-3">
                    <input type="text" class="form-control" id="receiver_phoneNo3" name="receiver_phoneNo3" maxlength="4">
                  </div>
                </div>
              </div>
            </div>
            <div class="mb-3 row">
              <label for="name" class="col-sm-2 col-form-label"></label>
              <div class="col-sm-10">
                <div class="mb-1">
                  <button type="button" class="btn btn-primary" id="saveBtn" style="display:none;">배송지 정보 저장하기</button>
                </div>
              </div>
            </div>
            
            <div class="mb-3 row">
              <label for="shippingMsg" class="col-sm-2 col-form-label" >배송요청사항 </label>
              <div class="col-sm-10">
                <select id="shippingMsg" name="order_msg" class="form-select" required="required">
                  <option value="optionNotSelected" disabled selected>배송요청사항을 선택해주세요.</option>
                  <option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
                  <option value="배송 전, 연락주세요.">배송 전, 연락주세요.</option>
                  <option value="부재 시, 휴대폰으로 연락주세요.">부재 시, 휴대폰으로 연락주세요.</option>
                  <option value="부재 시, 경비실에 맡겨주세요.">부재 시, 경비실에 맡겨주세요.</option>
                  <option value="경비실이 없습니다. 배송 전, 연락주세요.">경비실이 없습니다. 배송 전, 연락주세요.</option>
                  <option value="직접입력">직접입력</option>
                </select>
                <input type="text" name="order_msgSelf" id="selfType" class="form-control mt-2" style="display: none;" placeholder="배송요청사항 직접 입력">
              </div>
            </div>        
        </div>

        <div class="col-lg-4 sticky-card">
          <div>
            <div class="card">
              <div class="card-body">
                <h5 class="card-title">결제 예정 금액</h5>
                <hr>
                <p class="card-text">주문금액: <fmt:formatNumber value="${total}" pattern=",###"/>원</p>
                <p class="card-text">할인: - <fmt:formatNumber value="${discounted }" pattern=",###"/>원</p>
                <p class="card-text">배송비: + <fmt:formatNumber value="${delivery_cost }" pattern=",###"/>원</p>
                <p class="card-text"> 포인트 사용 : 
                	<input type="text" name="order_point" id="order_point"> p <br><span style="color:grey;">(회원님의 보유 포인트 : <fmt:formatNumber value="${mem.mem_point }" pattern=",###"/> P)</span>
                	<br>
                	<span id="pointMsg" style="color:red;font-size:10px;"></span>
                </p>
                
                <p class="card-text" id="final-payment-amount">최종 결제 금액: <span id="total"><fmt:formatNumber value="${total - discounted + delivery_cost }" pattern=",###"/></span>원</p>   
                <input type="hidden" value="${mem.mem_point }" id="mem_point"> 
                <input type="hidden" value="${delivery_cost }" name="delivery_cost">           
                <input type="hidden" value="${total - discounted + delivery_cost }" name="order_totalPay" id="final_amount">
              </div>
            </div>
          </div>
          <div class="mt-3">
            <button type="button" class="btn-danger btn-lg" id="payBtn" style="width:100%" onclick="javascript:payment()"><span id="Total"><fmt:formatNumber value="${total - discounted + delivery_cost }" pattern=",###"/></span>원 결제하기</button>
          </div>
        </div>
      </div>
      </form>	
      </div>
      <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
      <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
      <script>
      function input_check(f) {
    	  if(f.flexRadioDefault.value.trim() == "") {
    		  alert("배송지 입력방법을 선택해주세요.")
		      return false;
    	  }
    	  var newDelivery = document.getElementById("flexRadioDefault1");
    	  var og = document.getElementById("flexRadioDefault2");
    	  if(newDelivery.checked && f.delivery_nickName.value.trim() == "") {
    		  alert("배송지 별명을 입력하세요.")
		      f.delivery_nickName.focus();
		      return false;
    	  } 
    	  if(f.deliver_receiver.value.trim() == "" ){
    		    alert("받으실 분을 입력하세요")
    		    f.deliver_receiver.focus();
    		    return false;
    	  }
    	  if(f.delivery_postcode.value.trim() == "" ){
    		    alert("주소를 입력하세요")
    		    f.delivery_postcode.focus();
    		    return false;
    	  }
    	  if(f.delivery_address.value.trim() == "" ){
    		    alert("주소를 입력하세요")
    		    f.delivery_address.focus();
    		    return false;
    	  }
    	  if(f.delivery_detailAddress.value.trim() == "" ){
    		    alert("상세주소를 입력하세요")
    		    f.delivery_detailAddress.focus();
    		    return false;
    	  }
    	  if(f.receiver_phoneNo1.value.trim() == "" ){
    		    alert("전화번호를 입력하세요")
    		    f.receiver_phoneNo1.focus();
    		    return false;
    	  }
    	  if(f.receiver_phoneNo2.value.trim() == "" ){
    		    alert("전화번호를 입력하세요")
    		    f.receiver_phoneNo2.focus();
    		    return false;
    	  }
    	  if(f.receiver_phoneNo3.value.trim() == "" ){
    		    alert("전화번호를 입력하세요")
    		    f.receiver_phoneNo3.focus();
    		    return false;
    	  }
    	  var regex = /^\d+$/;
    	  if(!regex.test(f.receiver_phoneNo1.value.trim()) || f.receiver_phoneNo1.value.length <3){
  		    alert("유효하지 않은 전화번호 입니다.")
  		    f.receiver_phoneNo1.focus();
  		    return false;
  	  	  }
    	  if(!regex.test(f.receiver_phoneNo2.value.trim()) || f.receiver_phoneNo2.value.length <4){
    		  alert("유효하지 않은 전화번호 입니다.")
  		    f.receiver_phoneNo2.focus();
  		    return false;
  	      }
    	  if(!regex.test(f.receiver_phoneNo3.value.trim()) || f.receiver_phoneNo3.value.length <4){
    		  alert("유효하지 않은 전화번호 입니다.")
  		    f.receiver_phoneNo3.focus();
  		    return false;
  	  	  }
    	  if(f.order_msg.value.trim() == "optionNotSelected") {
    		  alert("배송 메세지를 선택 혹은 입력하세요.")
  		    	f.order_msg.focus();
  		    	return false;
    	  }
    	  if(f.order_msg.value.trim() == "직접입력" && f.order_msgSelf.value.trim() == "") {
    		  alert("배송 메세지를 입력하세요.")
  		    	f.order_msgSelf.focus();
  		    	return false;
    	  } 
    	  var og = document.getElementById("pointMsg");
    	  if(og.innerText !== "") {
    		  alert("포인트 메세지를 확인하세요.")
    		  f.order_point.focus();
    		  return false;
    	  }
    	  return true;
      }
      
      //결제
      			let IMP = window.IMP
      		  	IMP.init("imp03400706");
      			
      			function payment() {
      			  if (input_check(f)) {
      			    var productNames = $("input[name='product_name']").map(function() {
      			      return $(this).val();
      			    }).get();
					console.log(productNames)
      			    $.ajax({
      			      url: "payment",
      			      data: {
      			        'product_name[]': productNames,
      			        final_amount: $("#final_amount").val() - $("#order_point").val()
      			      },
      			      success: function(json) {
      			        iamPay(json);
      			      }
      			    });
      			  }
      			}
      			
      			function iamPay(json) {
      				IMP.request_pay({
      					pg : "html5_inicis",  
      					pay_method : "card", 
      					merchant_uid : json.merchant_uid, //주문번호 : 주문별로 유일한 값이 필요. userid-session id 값으로 설정(내맘대로 설정)
      					name : json.name, //주문상품명. 사과 외 n개
      					amount : json.amount, //주문금액(합계)
      					buyer_email : json.buyer_email, //결제내역 메일 전송(주문자 이메일)
      				    buyer_name : json.buyer_name,
      				    buyer_tel : json.buyer_tel
      				}, function(rsp) {
      					if(rsp.success) { 
/*      						var msg = '결제가 완료되었습니다.';
  					        msg += '고유ID : ' + rsp.imp_uid;
  					        msg += '상점 거래ID : ' + rsp.merchant_uid;
  					        msg += '결제 금액 : ' + rsp.paid_amount;
  					        msg += '카드 승인번호 : ' + rsp.apply_num;
      						alert(msg); */
      						document.f.submit();
      					} else {
      						alert(rsp.error_msg)
      					}
      				}) 
      			}
      </script>
<!--       <h1 class="mt-5">환불정보</h1>
        <div class="row mt-4">
          <div class="col-lg-6">
          <hr>
          <form>
            <div class="mb-3 row">
              <label for="refundName" class="col-sm-2 col-form-label">입금은행</label>
                <div class="col-sm-10">
                  <select id="shippingMsg" class="form-select">
                    <option value="optionNotSelected" disabled selected>환불받을 계좌를 선택해주세요.</option>
                    <option value="1">국민은행</option>
                    <option value="2">신한은행</option>
                  </select>
                </div>
              </div>

            <div class="mb-3 row">
              <label for="refundBank" class="col-sm-2 col-form-label">계좌번호</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="refundBank" required>
                </div>
            </div>

            <div class="mb-3 row">
              <label for="refundAccount" class="col-sm-2 col-form-label">예금주명</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="refundAccount" required>
                </div>
            </div>
              --> 
        
</body>
</html>