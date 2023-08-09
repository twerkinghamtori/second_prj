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
	#tr, .brown, .btn-outline-custom-brown:hover {
		background-color: brown;
		color : white;
	}
	.btn-outline-custom-brown {
	  color: brown;
	  border-color: brown;
	}
	
	.active-brown{
		color: white;
	  background-color: brown;
	}
</style>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 리뷰 내역</h3>
      <p class="mb-3">리뷰 내역을 보여주는 페이지 입니다.</p>
      
      <div class="container">
      	<form action="reviewList">
	        <div style="display: flex;justify-content: space-between;border-bottom: 2px solid black;margin-bottom: 10px;">
	          <h4 style="margin-top: 25px;">총 <span class="text-danger">${reviewCnt }</span>개</h4>
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
			          <option ${param.f eq 'product_name'? 'selected' : '' } value="product_name">제품명</option>
			          <option ${param.f eq 'mem_id'? 'selected' : '' } value="mem_id">회원 아이디</option>
			        </select>
						  <input type="text" class="form-control ms-3" name="query" placeholder="검색어" value="${param.query}">
						  <div class="input-group-append">
						    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">
						      <i class="fa fa-search"></i>
						    </button>
						  </div>
						</div>
	        </div>
        </form>
        
       <div class="btn-group mb-3">
				  <button type="button" onclick="location.href='reviewList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}'" class="btn btn-outline-custom-brown btn-sm ${empty review_state ? 'active-brown' : '' }">전체</button>
				  <button type="button" onclick="location.href='reviewList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&review_state=지급대기'" class="btn btn-outline-custom-brown btn-sm ${review_state eq '지급대기' ? 'active-brown' : '' }">지급대기</button>
				  <button type="button" onclick="location.href='reviewList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&review_state=지급완료'" class="btn btn-outline-custom-brown btn-sm ${review_state eq '지급완료' ? 'active-brown' : '' }">지급완료</button>
				</div>
        
        <c:if test="${empty reviewList }">
        	<h4 class="text-center">등록된 리뷰 내역이 없습니다.</h4>
        </c:if>
        
        <c:if test="${!empty reviewList }">
	        <table class="table table-hover table-bordered text-center align-middle">
	          <tr id="tr">
	            <th width="10%">리뷰 번호</th>
	            <th width="10%">제품 이미지</th>
	            <th width="25%">리뷰 제품명</th>
	            <th width="20%">회원 아이디</th>
	            <th width="10%">리뷰 점수</th>
	            <th width="15%">리뷰 등록일</th>
	            <th width="10%">리뷰 상태</th>
	          </tr>
	          <c:forEach var="review" items="${reviewList }">
		          <tr>
		            <td>${review.review_number }</td>
		            <td><img src="${path }/img/thumb/${review.product_thumb }" width="100"></td>
		            <td>${review.product_name}</td>
		            <td>${review.mem_id }</td>
		            <td>
		            	${review.review_value }/5<br>
		            	<a class="btn btn-dark btn-sm" href="reviewDetail?review_number=${review.review_number }">상세보기</a>
		            </td>
		            <td><fmt:formatDate value="${review.review_date }" pattern="yyyy-MM-dd" /></td>
		            <td>${review.review_state}</td>
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
						<a class="w3-bar-item w3-button w3-hover-black" href="reviewList?pageNum=${pageNum-1}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&review_state=${param.review_state}">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="reviewList?pageNum=${a}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&review_state=${param.review_state}">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="reviewList?pageNum=${startPage+5}&sd=${sd}&ed=${ed}&f=${param.f}&query=${param.query}&review_state=${param.cs_state}">&raquo;</a>
					</c:if>
		    </div>
		  </div>

      </div>
    </div>
</body>
</html>