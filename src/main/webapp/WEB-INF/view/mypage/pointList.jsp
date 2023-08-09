<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<script>
</script>
</head>
<body>
	<div class="container">
		<div style="display: flex; justify-content: space-between;">
			<div style="flex-basis: 20%;">
				<%@ include file="mypageSideBar2.jsp"%>
			</div>
			<div style="flex-basis: 80%;">
      <h1 class="mb-3">포인트 내역</h1>
      <div class="row">
        <div class="col-7">
          <h5>총 <span style="color: red;">${pointCnt}</span>건</h5>
        </div>
        <div class="col-5 text-end">
        	<div class="btn-group mb-3">
			<button type="button" onclick="location.href='pointList?mem_id=${sessionScope.loginMem.mem_id}'" class="btn btn-outline-danger ${empty param.point_type ? 'active' : '' }">전체</button>
			<button type="button" onclick="location.href='pointList?mem_id=${sessionScope.loginMem.mem_id}&point_type=else'" class="btn btn-outline-danger  ${param.point_type == 'else' ? 'active' : '' }">받은 포인트</button>
			<button type="button" onclick="location.href='pointList?mem_id=${sessionScope.loginMem.mem_id}&point_type=used'" class="btn btn-outline-danger  ${param.point_type == 'used' ? 'active' : '' }">사용한 포인트</button>
	  </div>
        </div>
      </div>
      
      <c:if test="${empty pointList }">
      	<h4 class="text-center">등록된 포인트 내역이 없습니다.</h4>
      </c:if>
      
      <c:if test="${!empty pointList }">
	      <div class="row" id="oinfo" class="info">
	      
	      
	        <table class="table table-hover">
	          <tr style="text-align:center; background-color:#D1180B; color: white;">
	            <th>일자</th>
	            <th>포인트 내용</th>
	            <th>포인트</th>
	          </tr>
	        <c:forEach items="${pointList }" var="p" varStatus="st">
	          <tr style="text-align:center;">
	            <td><fmt:formatDate value="${p.point_regdate}" pattern="yyyy-MM-dd" /></td>
	            <td>${p.point_type }</td>
	            <td><fmt:formatNumber value="${p.point_value}" pattern="###,###"/>P</td> 
	          </tr>          
	          </c:forEach>
	        </table>
	      </div>
      </c:if>
      
      <div class="w3-center w3-padding-32">
		    <div class="w3-bar">
			    <c:if test="${pageNum<= 1}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
					</c:if>
					<c:if test="${pageNum > 1}">
						<a class="w3-bar-item w3-button w3-hover-black" href="pointList?pageNum=${pageNum-1}&mem_id=${sessionScope.loginMem.mem_id}&point_type=${param.point_type }">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="pointList?pageNum=${a}&mem_id=${sessionScope.loginMem.mem_id}&point_type=${param.point_type }">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="pointList?pageNum=${startPage+5}&mem_id=${sessionScope.loginMem.mem_id}&point_type=${param.point_type }">&raquo;</a>
					</c:if>
		    </div>
		  </div>
      
    </div>
			</div>
		</div>
</body>
</html>