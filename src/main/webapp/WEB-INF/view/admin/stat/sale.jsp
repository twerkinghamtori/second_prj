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
	#tr, .green, .btn-outline-custom-green:hover {
		background-color: green;
		color : white;
	}
	.btn-outline-custom-green {
	  color: green;
	  border-color: green;
	}
	
	.active-green{
		color: white;
	  background-color: green;
	}
</style>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1" style="width:70%">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 통계</h3>
      <p class="mb-3">쇼핑몰 통계를 보여주는 페이지 입니다.</p>
      
      <div class="container">
      
      	<form action="sale">
	        <div style="border-bottom: 2px solid black;margin-bottom: 10px;">
	          <div class="input-group p-3">
						  <input type="date" name="sd" value="${sd}" class="form-control mr-3" required="required">
						  <div class="input-group-prepend">
						    <span class="input-group-text">부터</span>
						  </div>
						  <input type="date" name="ed" value="${ed}" class="form-control">
						  <div class="input-group-prepend">
						    <span class="input-group-text">까지</span>
						  </div>
						  <div class="input-group-append">
						    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">
						      <i class="fa fa-search"></i>
						    </button>
						  </div>
						</div>
	        </div>
        </form>
        
        <div class="mb-3">
        	<span class="text-danger">*</span>검색 결과 : <span class="text-danger">${statCnt}</span>건 <br>
        	<c:if test="${!empty sd and !empty ed }">
	        	<span class="text-danger">*</span>매출 합계 : <span class="text-danger"><fmt:formatNumber value="${sumSale }" pattern="#,###"/></span>원 &nbsp;|&nbsp;
	        	<span class="text-danger">*</span>매출 일일 평균 : <span class="text-danger"><fmt:formatNumber value="${avgSale }" pattern="#,###"/></span>원 &nbsp;|&nbsp;
	        	<span class="text-danger">*</span>취소 합계 : <span class="text-danger"><fmt:formatNumber value="${sumCancel }" pattern="#,###"/></span>원 &nbsp;|&nbsp;
	        	<span class="text-danger">*</span>취소 일일 평균 : <span class="text-danger"><fmt:formatNumber value="${avgCancel }" pattern="#,###"/></span>원 &nbsp;|&nbsp;
	        	<span class="text-danger">*</span>환불 합계 : <span class="text-danger"><fmt:formatNumber value="${sumRefund }" pattern="#,###"/></span>원 &nbsp;|&nbsp;
	        	<span class="text-danger">*</span>환불 일일 평균 : <span class="text-danger"><fmt:formatNumber value="${avgRefund }" pattern="#,###"/></span>원 
        	</c:if>
        </div>
      	
     	 	<c:if test="${empty statSaleList }">
       		<h4 class="text-center">해당 일자에는 데이터가 존재하지 않습니다.</h4>
        </c:if>
        
        <c:if test="${!empty statSaleList }">
	        <table class="table table-hover table-bordered align-middle">
	          <tr id="tr" class="text-center">
	            <th width="25%">날짜</th>
	            <th width="25%">주문</th>
	            <th width="25%">환불</th>
	            <th width="25%">취소</th>
	          </tr>
	          <c:forEach var="sale" items="${statSaleList}" varStatus="st">
	          	<c:if test="${!empty sale.date }">
			          <tr>
			            <td class="text-center"><fmt:formatDate value="${sale.date }" pattern="yyyy-MM-dd"/></td>
			            <td class="text-end">
			            	<fmt:formatNumber value="${sale.order_pay}" pattern="#,###"/>원
			            	<br>
			            	(${sale.order_cnt })건
			            </td>
			            <td class="text-end">
			            	<fmt:formatNumber value="${sale.refund_pay}" pattern="#,###"/>원
			            	<br>
			            	(${sale.refund_cnt })건
			            </td>
			            <td class="text-end">
			            	<fmt:formatNumber value="${sale.orderCancel_pay}" pattern="#,###"/>원
			            	<br>
			            	(${sale.orderCancel_cnt })건
			            </td>
			          </tr>
			         </c:if>
	          </c:forEach>
	        </table>
        </c:if>

        <div class="w3-center w3-padding-32">
			    <div class="w3-bar">
				    <c:if test="${pageNum<= 1}">
							<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
						</c:if>
						<c:if test="${pageNum > 1}">
							<a class="w3-bar-item w3-button w3-hover-black" href="sale?pageNum=${pageNum-1}&sd=${sd}&ed=${ed}">&laquo;</a>
						</c:if>
						
						<c:forEach var="a" begin="${startPage}" end="${endPage}">
							<c:if test="${a <= maxPage}">
								<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="sale?pageNum=${a}&sd=${sd}&ed=${ed}">${a}</a>
							</c:if>
						</c:forEach>
							
						<c:if test="${startPage+4 >= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
						</c:if>
						<c:if test="${startPage+4 < maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black" href="sale?pageNum=${startPage+5}&sd=${sd}&ed=${ed}">&raquo;</a>
						</c:if>
			    </div>
			  </div>
      </div>
    </div>
</body>
</html>