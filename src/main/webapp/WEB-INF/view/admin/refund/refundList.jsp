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
	#tr, .red, .btn-outline-custom-red:hover {
		background-color: red;
		color : white;
	}
	.btn-outline-custom-red {
	  color: red;
	  border-color: red;
	}
	
	.active-red{
		color: white;
	  background-color: red;
	}
</style>
<script type="text/javascript">
	function refundDetail(refund_number, idx){
		$.ajax({
			url : "refundDetail?refund_number=" + refund_number,
			success : function(data){
				console.log(data);
				let html = "";
	      html += "<div class='form-group'>";
	      html += "<label class='mb-1'>주문 번호</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 주문 번호 정보 추가
	      html += data.refund.refund_orderId;
	      html += "</div>";

	      html += "<label class='mb-1'>회원 아이디</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 회원 아이디 정보 추가
	      html += data.refund.refund_memId;
	      html += "</div>";

	      html += "<label class='mb-1'>구매 제품</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 구매 제품 정보 추가
	      html += data.refund.product_name + "(" + data.refund.opt_name + ") " + data.refund.refund_optCount +"개";
	      html += "</div>";
	      
	      html += "<label class='mb-1'>환불 금액</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 환불금액 정보 추가
	      html += data.refund.refund_price;
	      html += "원</div>";
	      
	      html += "<label class='mb-1'>환불 신청일</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      
	      const refundDate = new Date(data.refund.refund_date);
	      const year = refundDate.getFullYear();
	      const month = refundDate.getMonth() + 1;
	      const day = refundDate.getDate();
	      const formattedDate = year + "년 " + month + "월 " + day + "일";
	      
	      // 환불 신청일 정보 추가
	      html += formattedDate;
	      html += "</div>";

	      html += "<label class='mb-1'>환불 사유</label><span class='text-danger'>*</span>";
	      html += "<div class='mb-4'>";
	      // 환불 사유 정보 추가
	      html += data.refund.refund_reason;
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
		getTypeList();
	})
	
	function getTypeList(){
		const pageNum = ${pageNum};
		const sd = '${param.sd}';
		const ed = '${param.ed}';
		const f = '${param.f}';
		const query = '${param.query}';
		const refund_type = '${param.refund_type}';
		
		$.ajax({
			url : 'refundTypeList?pageNum=' + pageNum + '&sd=' + sd + '&ed=' + ed + '&f=' + f + '&query=' + query + '&refund_type=' + refund_type,
			success : chgType,
			error : function(e) { alert(e.status); }
		})
	}
	
	function chgType(data){
		$.each(data, function(i, refund){
			let html = refund.refund_type;
			let btnName1 = "";
			let modalContent1 = "";
			let btnName2 = "";
			let modalContent2 = "";
			html += "<br>";
			if (refund.refund_type === '환불대기') {
			  btnName1 = "환불완료";
			  btnColor1 = "success";
			  btnName2 = "환불반려";
			  btnColor2 = "warning";
			  modalContent = "환불 상태를 변경 하시겠습니까?";
			  
			  html += '<input type="hidden"id="i' + i + '" name="refund_number" value="' + refund.refund_number + '">';
			  html += '<input type="hidden" id="t' + i + '" name="refund_type" value="' + refund.refund_type + '">';
			  html += '<input type="hidden" id="oi' + i + '"  value="' + refund.refund_orderId + '">';
			  html += '<input type="hidden" id="p' + i + '"  value="' + refund.refund_price + '">';
			  html += '<a type="button" class="btn btn-sm btn-' + btnColor1 +'" data-bs-toggle="modal" data-bs-target="#staticBackdrop' + i + '">'+ btnName1+'</a>';
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
			  html += '<button type="button" onclick="refundComp('+i+')" class="btn btn-dark">네</button>';
			  html += '</div>';
			  html += '</div>';
			  html += '</div>';
			  html += '</div>';
			  
			  html += ' <a type="button" class="btn btn-sm btn-' + btnColor2 +'" data-bs-toggle="modal" data-bs-target="#staticBackdrop' + ((i*100)+1) + '">'+ btnName2+'</a>';
			  html += '<div class="modal fade" id="staticBackdrop' + ((i*100)+1) + '" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">';
			  html += '<div class="modal-dialog">';
			  html += '<div class="modal-content">';
			  html += '<div class="modal-header">';
			  html += '<h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>';
			  html += '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';
			  html += '</div>';
			  html += '<div class="modal-body">' + modalContent + '</div>';
			  html += '<div class="modal-footer">';
			  html += '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>';
			  html += '<button type="button" onclick="refundBack('+i+')" class="btn btn-dark">네</button>';
			  html += '</div>';
			  html += '</div>';
			  html += '</div>';
			  html += '</div>';
			}
		  
			$("#type"+i).html(html);
		})
	}
	
	function refundComp(i) {

	  const refundNumber = $("#i"+i).val();
	  const refundType = $("#t"+i).val();
	  const refundOrderId = $("#oi"+i).val();
	  const refundPrice = $("#p"+i).val();
	  
	  $.ajax({
	    url: 'refundComp',
	    type: 'POST',
	    data: {
	      refund_number : refundNumber,
	      refund_type : refundType,
	      refund_orderId : refundOrderId,
	      refund_price : refundPrice
	    },
	    success: function () {
	        getTypeList();
	        location.reload();
	    },
	    error: function(error) {
	      alert(error);
	    }
	  });	  
	  
	  closeModal(i);
	}
	
	function refundBack(i) {

	  const refundNumber = $("#i"+i).val();
	  const refundType = $("#t"+i).val();

	  console.log(refundNumber);
	  console.log(refundType);
	  
	  $.ajax({
	    url: 'refundBack',
	    type: 'POST',
	    data: {
	      refund_number : refundNumber,
	      refund_type : refundType
	    },
	    success: getTypeList,
	    error: function(error) {
	      alert(error);
	    }
	  });

	  closeModal((i*100)+1);
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
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 환불 내역</h3>
      <p class="mb-3">환불 내역을 보여주는 페이지 입니다.</p>
      
      <div class="container">
      	<form action="refundList">
	        <div style="display: flex;justify-content: space-between;border-bottom: 2px solid black;margin-bottom: 10px;">
	          <h4 style="margin-top: 25px;">총 <span class="text-danger">${refundCnt }</span>개</h4>
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
			          <option ${param.f eq 'refund_orderId'? 'selected' : '' } value="refund_orderId">주문 번호</option>
			          <option ${param.f eq 'refund_memId'? 'selected' : '' } value="refund_memId">회원 아이디</option>
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
				  <button type="button" onclick="location.href='refundList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}'" class="btn btn-outline-custom-red btn-sm ${empty refund_type ? 'active-red' : '' }">전체</button>
				  <button type="button" onclick="location.href='refundList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&refund_type=환불대기'" class="btn btn-outline-custom-red btn-sm ${refund_type eq '환불대기' ? 'active-red' : '' }">환불대기</button>
				  <button type="button" onclick="location.href='refundList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&refund_type=환불완료'" class="btn btn-outline-custom-red btn-sm ${refund_type eq '환불완료' ? 'active-red' : '' }">환불완료</button>
				  <button type="button" onclick="location.href='refundList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&refund_type=환불반려'" class="btn btn-outline-custom-red btn-sm ${refund_type eq '환불반려' ? 'active-red' : '' }">환불반려</button>
				</div>
        
        <c:if test="${empty refundList }">
        	<h4 class="text-center">등록된 환불 내역이 없습니다.</h4>
        </c:if>
        
        <c:if test="${!empty refundList }">
	        <table class="table table-hover table-bordered text-center align-middle">
	          <tr id="tr">
	            <th width="10%">환불 번호</th>
	            <th width="10%">주문 번호</th>
	            <th width="20%">회원 아이디</th>
	            <th width="30%">환불 아이템(수량)</th>
	            <th width="15%">환불 신청/완료일</th>
	            <th width="15%">환불 상태</th>
	          </tr>
	          <c:forEach var="refund" items="${refundList }" varStatus="st">
		          <tr>
		            <td>
		            	${refund.refund_number} <br>
		            	<a type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop${refund.refund_number}" onclick="javascript:refundDetail('${refund.refund_number}','${st.index }')">상세보기</a>
																	
									<%-- Modal --%>
									<div class="modal fade" id="staticBackdrop${refund.refund_number}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
									  <div class="modal-dialog">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h2 class="modal-title text-center" id="staticBackdropLabel">환불 내역 상세<br><span class="fw-bold">(${refund.refund_type})</span></h2>
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
		            <td>${refund.refund_orderId}</td>
		            <td>${refund.refund_memId}</td>
		            <td>${refund.product_name}(${refund.opt_name}) ${refund.refund_optCount}개</td>
		            <td>
		            	신청일 : <fmt:formatDate value="${refund.refund_date}" pattern="yyyy-MM-dd" /> <br>
		            	완료일 :
		            	<c:if test="${!empty refund.refund_compdate}">
		            		<fmt:formatDate value="${refund.refund_compdate}" pattern="yyyy-MM-dd" />
		            	</c:if>
		            	<c:if test="${empty refund.refund_compdate}">미정</c:if>
		            </td>
		            <td id="type${st.index}">
		            	 
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
							<a class="w3-bar-item w3-button w3-hover-black" href="refundList?pageNum=${pageNum-1}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=${param.order_state}">&laquo;</a>
						</c:if>
						
						<c:forEach var="a" begin="${startPage}" end="${endPage}">
							<c:if test="${a <= maxPage}">
								<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="refundList?pageNum=${a}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=${param.order_state}">${a}</a>
							</c:if>
						</c:forEach>
							
						<c:if test="${startPage+4 >= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
						</c:if>
						<c:if test="${startPage+4 < maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black" href="refundList?pageNum=${startPage+5}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&order_state=${param.order_state}">&raquo;</a>
						</c:if>
			    </div>
			  </div>

      </div>
    </div>
</body>
</html>