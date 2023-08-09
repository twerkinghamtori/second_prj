<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
</head>
<body>
<br><br>
    <div class="container w3-white pt-1">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 제품 상세</h3>
      <p class="mb-3">제품 상세정보를 확인하는 페이지 입니다.</p>
      <form action="prodDel" method="post">
        <input type="hidden" name="product_number" value="${product.product_number }">
        <table class="table align-middle text-center">
          <tr>
            <td width="15%" class="table-secondary">제품명</td>
            <td width="35%">${product.product_name }</td>
            <td width="15%" class="table-secondary">카테고리</td>
            <td width="35%">${product.product_type }</td>
          </tr>
          <tr>
            <td class="table-secondary">가격</td>
            <td>
            	<c:if test="${product.product_discountRate > 0}">
	            	<span style="text-decoration: line-through;"><fmt:formatNumber value="${product.product_price }" pattern="#,###"/></span>&nbsp;&nbsp;
	            	<span class="text-primary"><b><fmt:formatNumber value="${product.product_price - product.product_price * (product.product_discountRate/100) }" pattern="#,###" /></b></span>
	           	</c:if>
	           	<c:if test="${product.product_discountRate eq 0}"><fmt:formatNumber value="${product.product_price }" pattern="#,###"/></c:if>
            </td>
            <td class="table-secondary">할인율</td>
            <td>
            	<c:if test="${product.product_discountRate > 0}">${product.product_discountRate}%</c:if>
            	<c:if test="${product.product_discountRate eq 0}">할인 없음</c:if>
            </td>
          </tr>
          <tr>
            <td class="table-secondary">제품 썸네일</td>
            <td colspan="3"><img src="${path }/img/thumb/${product.product_thumb }" style="max-width: 300px;"></td>
          </tr>
          <tr>
            <td class="table-secondary">제품 사진</td>
            <td colspan="3" >
              <c:if test="${empty prodPics}">제품 사진 없음</c:if>
              <c:if test="${!empty prodPics}">
              	<c:forEach var="pic" items="${prodPics}">
              		<img src="${path }/img/product/${pic}" style="max-width: 100px;">&nbsp;&nbsp;
              	</c:forEach>
              </c:if>
            </td>
          </tr>
          <tr>
            <td class="table-secondary">제품 설명</td>
            <td colspan="3">${product.product_desc}</td>
          </tr>
        </table>

        <div class="text-center">
          <a class="btn btn-sm btn-dark" href="prodChg?product_number=${product.product_number}">수정</a>
          <a type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop${product.product_number }">삭제</a>
												
					<%-- Modal --%>
					<div class="modal fade" id="staticBackdrop${product.product_number }" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div> 
					      <div class="modal-body">해당 제품을 삭제 하시겠습니까?</div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					        <button type="submit" class="btn btn-dark">삭제</button>
					      </div>
					    </div>
					  </div>
					</div>
					
          <a href="prodList" class="btn btn-dark btn-sm">목록</a>
        </div>
      </form>
      <br>
    </div>
</body>
</html>