<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<style type="text/css">
	#tr, .orange, .btn-outline-custom-orange:hover {
		background-color: orange;
		color : white;
	}
	.btn-outline-custom-orange {
	  color: orange;
	  border-color: orange;
	}
	
	.active-orange{
		color: white;
	  background-color: orange;
	}
</style>
<script type="text/javascript">
	function orderDetail(order_id, idx){
		$.ajax({
			url : "orderDetail?order_id=" + order_id,
			success : function(data){
				console.log(data);
				let html = "";
	      html += "<div class='form-group'>";
	      html += "<label class='mb-1'>주문 번호</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 주문 번호 정보 추가
	      html += data.order.order_id;
	      html += "</div>";

	      html += "<label class='mb-1'>회원 아이디</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 회원 아이디 정보 추가
	      html += data.order.mem_id;
	      html += "</div>";

	      html += "<label class='mb-1'>구매자명</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 구매자명 정보 추가
	      html += data.order.order_receiver;
	      html += "</div>";

	      html += "<label class='mb-1'>구매 제품</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 구매 제품 정보 추가
	      $.each(data.orderItem, function(idx, item){
		      html += item.product_name + " | " + item.opt_name + " | " 
		      	+ item.opt_count + "개 | " + (item.product_price*item.opt_count) +"원<br>";
	      })
	      html += "</div>";
	      
	      html += "<label class='mb-1'>배송비</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 배송비 정보 추가
	      html += data.order.delivery_cost;
	      html += "원</div>";

	      html += "<label class='mb-1'>사용 포인트</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 사용 포인트 정보 추가
	      html += data.order.order_point;
	      html += "P</div>";

	      html += "<label class='mb-1'>총 결제금액</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 총 금액 정보 추가
	      html += data.order.order_totalPay;
	      html += "원</div>";

	      html += "<label class='mb-1'>배송지</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 배송지 정보 추가
	      html += "(" + data.order.delivery_postcode + ") " + data.order.delivery_address + " " + data.order.delivery_detailAddress;
	      html += "</div>";

	      html += "<label class='mb-1'>배송 메세지</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 배송 메세지 정보 추가
	      html += data.order.order_msg;
	      html += "</div>";

	      html += "</div>";
	      
	      $("#detail"+idx).html(html);
			},
			error : function(e){
				alert(e.status);
			}
		})
	}
	
	$(()=>{
		getStateList();
	})
	
	function getStateList(){
		const pageNum = ${pageNum};
		const sd = '${param.sd}';
		const ed = '${param.ed}';
		const f = '${param.f}';
		const query = '${param.query}';
		const order_state = '${param.order_state}';
		
		$.ajax({
			url : 'orderStateList?pageNum=' + pageNum + '&sd=' + sd + '&ed=' + ed + '&f=' + f + '&query=' + query + '&order_state=' + order_state,
			success : chgState,
			error : function(e) { alert(e.status); }
		})
	}
	
	function chgState(data){
		$.each(data, function(i, order){
			let html = order.order_state;
			let btnName = "";
			let modalContent = "";
			html += "<br>";
			if (order.order_state === '결제완료') {
			  btnName = "주문승인";
			  btnColor = "success";
			  modalContent = "주문 상태를 변경 하시겠습니까?";
			}else if(order.order_state === '상품준비'){
				btnName = "준비완료";
				btnColor = "info";
				modalContent = "해당 주문을 배송준비로 변경 하시겠습니까?";
			}else if(order.order_state === '배송준비'){
				btnName = "배송중";
				btnColor = "warning";
				modalContent = "해당 주문을 배송중으로 변경 하시겠습니까?";
			}else if(order.order_state === '배송중'){
				btnName = "배송완료";
				btnColor = "outline-dark";
				modalContent = "해당 주문을 배송완료로 변경 하시겠습니까?";
			}
			
			if(order.order_state === '결제완료' || order.order_state === '상품준비' || order.order_state === '배송준비' || order.order_state === '배송중'){
			  html += '<input type="hidden"id="i' + i + '" name="order_id" value="' + order.order_id + '">';
			  html += '<input type="hidden" id="s' + i + '" name="order_state" value="' + order.order_state + '">';
			  html += '<a type="button" class="btn btn-sm btn-' + btnColor +'" data-bs-toggle="modal" data-bs-target="#staticBackdrop' + i + '">'+ btnName+'</a>';
			  html += '<div class="modal fade" id="staticBackdrop' + i + '" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">';
			  html += '<div class="modal-dialog">';
			  html += '<div class="modal-content">';
			  html += '<div class="modal-header">';
			  html += '<h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>';
			  html += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';
			  html += '</div>';
			  html += '<div class="modal-body">' + modalContent + '</div>';
			  html += '<div class="modal-footer">';
			  html += '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>';
			  html += '<button type="button" onclick="orderStateChg('+i+')" class="btn btn-dark">네</button>';
			  html += '</div>';
			  html += '</div>';
			  html += '</div>';
			  html += '</div>';
			}
		  
			$("#state"+i).html(html);
		})
	}
	
	function orderStateChg(i) {

	  const orderId = $("#i"+i).val();
	  const orderState = $("#s"+i).val();

	  console.log(orderId);
	  console.log(orderState);
	  
	  $.ajax({
	    url: 'orderStateChg',
	    type: 'POST',
	    data: {
	      order_id: orderId,
	      order_state: orderState
	    },
	    success: getStateList,
	    error: function(error) {
	      alert(error);
	    }
	  });

	  closeModal(i);
	  location.reload();
	}
	function closeModal(i) {
	  $('#staticBackdrop' + i).modal('hide');
	}
</script>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 주문 내역</h3>
      <p class="mb-3">주문 내역을 보여주는 페이지 입니다.</p>
      
      <div class="container">
      	<form action="orderList">
	        <div style="display: flex;justify-content: space-between;border-bottom: 2px solid black;margin-bottom: 10px;">
	          <h4 style="margin-top: 25px;">총 <span class="text-danger">${orderCnt }</span>개</h4>
	          <div class="input-group p-3" style="width: 75%;">
						  <input type="date" name="sd" value="${sd}" class="form-control mr-3">
						  <div class="input-group-prepend">
						    <span class="input-group-text">부터</span>
						  </div>
						  <input type="date" name="ed" value="${ed}" class="form-control">
						  <div class="input-group-prepend">
						    <span class="input-group-text">까지</span>
						  </div>
						  <select id="sel" class="form-select ms-3" name="f">
			          <option ${param.f eq 'order_id'? 'selected' : '' } value="order_id">주문 번호</option>
			          <option ${param.f eq 'order_receiver'? 'selected' : '' } value="order_receiver">이름</option>
			        </select>
						  <input type="text" class="form-control" name="query" placeholder="검색어" value="${param.query}">
						  <div class="input-group-append">
						    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">
						      <i class="fa fa-search"></i>
						    </button>
						  </div>
						</div>
	        </div>
        </form>
        
       <div class="btn-group mb-3">
				  <button type="button" onclick="location.href='orderList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}'" class="btn btn-outline-custom-orange btn-sm ${empty order_state ? 'active-orange' : '' }">전체</button>
				  <button type="button" onclick="location.href='orderList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=결제완료'" class="btn btn-outline-custom-orange btn-sm ${order_state eq '결제완료' ? 'active-orange' : '' }">결제완료</button>
				  <button type="button" onclick="location.href='orderList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=상품준비'" class="btn btn-outline-custom-orange btn-sm ${order_state eq '상품준비' ? 'active-orange' : '' }">상품준비</button>
				  <button type="button" onclick="location.href='orderList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=배송준비'" class="btn btn-outline-custom-orange btn-sm ${order_state eq '배송준비' ? 'active-orange' : '' }">배송준비</button>
				  <button type="button" onclick="location.href='orderList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=배송중'" class="btn btn-outline-custom-orange btn-sm ${order_state eq '배송중' ? 'active-orange' : '' }">배송중</button>
				  <button type="button" onclick="location.href='orderList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=배송완료'" class="btn btn-outline-custom-orange btn-sm ${order_state eq '배송완료' ? 'active-orange' : '' }">배송완료</button>
				  <button type="button" onclick="location.href='orderList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=주문취소'" class="btn btn-outline-custom-orange btn-sm ${order_state eq '주문취소' ? 'active-orange' : '' }">주문취소</button>
				  <button type="button" onclick="location.href='orderList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=구매확정'" class="btn btn-outline-custom-orange btn-sm ${order_state eq '구매확정' ? 'active-orange' : '' }">구매확정</button>
				</div>
        
        <c:if test="${empty orderList }">
        	<h4 class="text-center">등록된 주문 내역이 없습니다.</h4>
        </c:if>
        
        <c:if test="${!empty orderList }">
	        <table class="table table-hover table-bordered text-center align-middle">
	          <tr id="tr">
	            <th width="20%">주문 번호</th>
	            <th width="20%">회원 아이디</th>
	            <th width="15%">구매자명</th>
	            <th width="15%">주문 금액</th>
	            <th width="15%">주문 날짜</th>
	            <th width="15%">주문 상태</th>
	          </tr>
	          <c:forEach var="order" items="${orderList }" varStatus="st">
		          <tr>
		            <td>
		            	${order.order_id} <br>
		            	<a type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop${order.order_id}" onclick="javascript:orderDetail('${order.order_id}','${st.index }')">주문 상세보기</a>
																	
									<%-- Modal --%>
									<div class="modal fade" id="staticBackdrop${order.order_id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
									  <div class="modal-dialog">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h2 class="modal-title text-center" id="staticBackdropLabel">주문 상세<br><span class="fw-bold">(${order.order_state})</span></h2>
									        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									      </div> 
									      <div class="modal-body" id="detail${st.index }"></div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
									      </div>
									    </div>
									  </div>
									</div>
		            </td>
		            <td>${order.mem_id}</td>
		            <td>${order.order_receiver}</td>
		            <td><fmt:formatNumber value="${order.order_totalPay}" pattern="#,###"/></td>
		            <td><fmt:formatDate value="${order.order_date }" pattern="yyyy-MM-dd" /></td>
		            <td id="state${st.index}">
		            	 
		           	</td>
		          </tr>
	          </c:forEach>
	        </table>
        </c:if>

         <div class="w3-center w3-padding-32">
		    <div class="w3-bar">
			    <c:if test="${pageNum<= 1}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
					</c:if>
					<c:if test="${pageNum > 1}">
						<a class="w3-bar-item w3-button w3-hover-black" href="orderList?pageNum=${pageNum-1}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=${param.order_state}">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="orderList?pageNum=${a}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=${param.order_state}">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="orderList?pageNum=${startPage+5}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=${param.order_state}">&raquo;</a>
					</c:if>
		    </div>
		  </div>

      </div>
    </div>
</body>
</html>