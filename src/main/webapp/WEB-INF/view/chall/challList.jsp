<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<style type="text/css">
#jumbo {
	position: relative;
	display: inline-block;
}

#jumbo img {
	display: block;
	width: 100%;
	height: 400px;
	filter: drop-shadow(2px 2px 4px rgba(0, 0, 0, 0.5)); /* 그림자 효과 */
}

#jumbo h1, #jumbo h3 {
	position: absolute;
	transform: translate(-50%, -50%);
	left: 50%;
	color: white;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* 그림자 효과 */
	z-index: 1;
}

#jumbo h1 {
	top: 40%;
}

#jumbo h3 {
	top: 60%;
}

.w3-quarter h2 {
	font-weight: bold;
}

.w3-quarter {
	height: 500px;
	width: 23%;
	margin: 10px;
	box-shadow: 0px 4px 8.5px 0 rgba(0, 0, 0, 0.4);
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	transition: transform 0.2s ease;
}
span.flip {
  display: inline-block;
  transform: scaleX(-1);
}
.progress {
  height: 30px; /* 원하는 높이로 조정 */
}
</style>

</head>
<body>
<div class="container">
	<div class="container" id="jumbo">
    <img src="${path}/images/test3.jpg">
    <h1 style="font-size:4em">💪 오운완 챌린지</h1>
    <h3>매일매일 📷인증샷을 남겨 포인트를 받아가세요! </h3>
  </div>

		<div class="mt-3 mb-3" style="display: flex; align-items: center;">
			<div>
				<a class="btn btn-danger ms-3" href="challReg">📷 참여하기</a>
			</div>
			<c:if test="${! empty sessionScope.loginMem }">
				<div class="progress" style="flex-grow: 0.8; margin-left: 5%;">
					<div class="progress-bar progress-bar-striped bg-danger"
						role="progressbar" style="width: ${chall_cnt*100}%"
						aria-valuenow="${chall_cnt}" aria-valuemin="0" aria-valuemax="365">
					</div>
					<span class="progress-text flip" style="font-size: 25px;">🏃🏻</span>
				</div>
				<p>
					<span class="ms-3">(<fmt:formatNumber
							value="${chall_cnt*100}" pattern="#,##0.##" /> % )
					</span> <span class="ms-3" style="color: Red;">${myChall.chall_cnt }
					</span> 일 째 / 365일
				</p>		
			</c:if>
		</div>


		<c:if test="${empty challList }">
		<h2 class="text-center">등록된 챌린지가 없습니다.</h2>
	</c:if>
	
	<c:if test="${!empty challList }">
	
	  <div class="w3-row-padding w3-padding-16 w3-center">
	  	<c:forEach var="chall" items="${challList }" begin="0" end="3" varStatus="st">
		    <div class="w3-quarter">
		      <h2>💪 ${chall.chall_cnt}일차 챌린지 중</h2>
		      <img src="${path }/img/chall/${chall.chall_pic }" style="width:100%; height: 300px;">
		      <h3>${chall.mem_name } 님</h3>
		      
		      <div><span class="fw-bold"><i class="fa fa-calendar"></i><fmt:formatDate value="${chall.chall_regdate }" pattern="yyyy-MM-dd" /></span></div>
		    </div>
	    </c:forEach>
	  </div>
  
	  <div class="w3-row-padding w3-padding-16 w3-center">
	  	<c:forEach var="chall" items="${challList }" begin="4" end="7" varStatus="st">
		    <div class="w3-quarter">
		      <h2>💪 ${chall.chall_cnt}일차 챌린지 중</h2>
		      <img src="${path }/img/chall/${chall.chall_pic }" style="width:100%; height: 300px;">
		      <h3>${chall.mem_name } 님</h3>
		      
		      <div><span class="fw-bold"><i class="fa fa-calendar"></i><fmt:formatDate value="${chall.chall_regdate }" pattern="yyyy-MM-dd" /></span></div>
		    </div>
	    </c:forEach>
	  </div>
	  
  </c:if>
  
  
  <div class="w3-center w3-padding-32">
    <div class="w3-bar">
	    <c:if test="${pageNum<= 1}">
				<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
			</c:if>
			<c:if test="${pageNum > 1}">
				<a class="w3-bar-item w3-button w3-hover-black" href="challList?pageNum=${pageNum-1}">&laquo;</a>
			</c:if>
			
			<c:forEach var="a" begin="${startPage}" end="${endPage}">
				<c:if test="${a <= maxPage}">
					<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="challList?pageNum=${a}">${a}</a>
				</c:if>
			</c:forEach>
				
			<c:if test="${startPage+4 >= maxPage}">
				<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
			</c:if>
			<c:if test="${startPage+4 < maxPage}">
				<a class="w3-bar-item w3-button w3-hover-black" href="challList?pageNum=${startPage+5}">&raquo;</a>
			</c:if>
    </div>
  </div>
</div>
</body>
</html>