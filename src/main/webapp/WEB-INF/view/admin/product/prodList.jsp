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
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 제품 목록</h3>
      <p class="mb-3">제품 목록을 보여주는 페이지 입니다.</p>
      
      <div class="container">
      	<form action="prodList">
	        <div style="display: flex;justify-content: space-between;border-bottom: 2px solid black;margin-bottom: 10px;">
	          <h4 style="margin-top: 25px;">총 <span class="text-danger">${prodCnt }</span>개</h4>
	          <div class="input-group p-3" style="width: 30%;">
	            <input type="text" class="form-control" name="query" placeholder="제품명 검색" value="${param.query}">
	            <button class="btn btn-outline-secondary" type="submit" id="button-addon2"><i class="fa fa-search"></i></button>
	          </div>
	        </div>
        </form>
        
        <c:if test="${empty prodList }">
        	<h4 class="text-center">등록된 제품이 없습니다.</h4>
        </c:if>
        
        <c:if test="${!empty prodList }">
	        <table class="table table-hover table-bordered text-center align-middle">
	          <tr class="table-secondary">
	            <th width="10%">제품 번호</th>
	            <th width="10%">제품 이미지</th>
	            <th width="20%">제품명</th>
	            <th width="10%">카테고리</th>
	            <th width="15%">가격(할인율)</th>
	            <th width="15%">등록일</th>
	            <th width="10%">&nbsp;</th>
	          </tr>
	          <c:forEach var="prod" items="${prodList }">
		          <tr>
		            <td>${prod.product_number }</td>
		            <td><img src="${path }/img/thumb/${prod.product_thumb }" width="100"></td>
		            <td>
		            	${prod.product_name }
		            	<br>
		            	<a class="btn btn-sm btn-dark" href="prodDetail?product_number=${prod.product_number }">상세보기</a></td>
		            <td>${prod.product_type }</td>
		            <td>
		            	<c:if test="${prod.product_discountRate > 0}">
			            	<span style="text-decoration: line-through;"><fmt:formatNumber value="${prod.product_price }" pattern="#,###"/></span>(${prod.product_discountRate }%)
			            	<br>
			            	&#10551; <span class="text-primary"><fmt:formatNumber value="${prod.product_price - prod.product_price * (prod.product_discountRate/100) }" pattern="#,###" /></span>
		            	</c:if>
		            	<c:if test="${prod.product_discountRate eq 0}"><fmt:formatNumber value="${prod.product_price }" pattern="#,###"/></c:if>
		            </td>
		            <td><fmt:formatDate value="${prod.product_regdate }" pattern="yyyy-MM-dd" /></td>
		            <td>
									<a class="btn btn-sm btn-secondary mt-1" href="${path}/admin/opt/optReg?product_number=${prod.product_number }">옵션등록</a>
		            </td>
		          </tr>
	          </c:forEach>
	        </table>
        </c:if>

        <div class="text-end"><a class="btn btn-primary" href="prodReg">제품 등록</a></div>

        <div class="w3-center w3-padding-32">
			    <div class="w3-bar">
				    <c:if test="${pageNum<= 1}">
							<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
						</c:if>
						<c:if test="${pageNum > 1}">
							<a class="w3-bar-item w3-button w3-hover-black" href="prodList?pageNum=${pageNum-1}&query=${param.query}">&laquo;</a>
						</c:if>
						
						<c:forEach var="a" begin="${startPage}" end="${endPage}">
							<c:if test="${a <= maxPage}">
								<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="prodList?pageNum=${a}&query=${param.query}">${a}</a>
							</c:if>
						</c:forEach>
							
						<c:if test="${startPage+4 >= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
						</c:if>
						<c:if test="${startPage+4 < maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black" href="prodList?pageNum=${startPage+5}&query=${param.query}">&raquo;</a>
						</c:if>
			    </div>
			  </div>

      </div>
    </div>
</body>
</html>