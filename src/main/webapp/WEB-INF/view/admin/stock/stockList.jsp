<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 재고 등록 내역</h3>
      <p class="mb-3">재고 등록 내역을 보여주는 페이지 입니다.</p>
      
      <div class="container">
      	<form action="stockList">
	        <div style="display: flex;justify-content: space-between;border-bottom: 2px solid black;margin-bottom: 10px;">
	          <h4 style="margin-top: 25px;">총 <span class="text-danger">${stockCnt }</span>개</h4>
	          <div class="input-group p-3" style="width: 70%;">
						  <input type="date" name="sd" value="${sd}" class="form-control mr-3">
						  <div class="input-group-prepend">
						    <span class="input-group-text">부터</span>
						  </div>
						  <input type="date" name="ed" value="${ed}" class="form-control">
						  <div class="input-group-prepend">
						    <span class="input-group-text">까지</span>
						  </div>
						  <input type="text" class="form-control ms-3" name="query" placeholder="제품명" value="${param.query}">
						  <div class="input-group-append">
						    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">
						      <i class="fa fa-search"></i>
						    </button>
						  </div>
						</div>
	        </div>
        </form>
        
        <c:if test="${empty stockList }">
        	<h4 class="text-center">등록된 재고 등록 내역이 없습니다.</h4>
        </c:if>
        
        <c:if test="${!empty stockList }">
        	<form action="stockDel" method="post">
		        <table class="table table-hover table-bordered text-center align-middle">
		          <tr class="table-danger">
		            <th width="10%">재고 등록 번호</th>
		            <th width="10%">제품 이미지</th>
		            <th width="40%">제품명(옵션명)</th>
		            <th width="10%">입고 수량</th>
		            <th width="15%">입고 날짜</th>
		            <th width="15%">&nbsp;</th>
		          </tr>
		          <c:forEach var="stock" items="${stockList }">
			          <tr>
			            <td>${stock.stock_number }</td>
			            <td><img src="${path }/img/thumb/${stock.stock_prodThumb }" width="100"></td>
			            <td>${stock.stock_prodName}</td>
			            <td>${stock.stock_quantity}</td>
			            <td><fmt:formatDate value="${stock.stock_regdate }" pattern="yyyy-MM-dd" /></td>
			            <td>
			            	<input type="hidden" name="stock_number" value="${stock.stock_number }">
			            	<a class="btn btn-sm btn-dark" href="stockChg?stock_number=${stock.stock_number}">수정</a>
			            </td>
			          </tr>
		          </c:forEach>
		        </table>
	        </form>
        </c:if>

         <div class="w3-center w3-padding-32">
		    <div class="w3-bar">
			    <c:if test="${pageNum<= 1}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
					</c:if>
					<c:if test="${pageNum > 1}">
						<a class="w3-bar-item w3-button w3-hover-black" href="stockList?pageNum=${pageNum-1}&query=${param.query}&sd=${sd}&ed=${ed}">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="stockList?pageNum=${a}&query=${param.query}&sd=${sd}&ed=${ed}">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="stockList?pageNum=${startPage+5}&query=${param.query}&sd=${sd}&ed=${ed}">&raquo;</a>
					</c:if>
		    </div>
		  </div>

      </div>
    </div>
</body>
</html>