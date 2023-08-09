<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<nav style="width:200px;" id="mySidebar">
  <div class="w3-container w3-row">
    <div class="w3-col s8 w3-bar">
      <h3>마이페이지</h3>
    </div>	
  </div>
  <hr>
  <div class="w3-bar-block">
    <a href="${path}/mypage/orderList?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="orderList" }'>w3-red</c:if>">
    &nbsp; · 주문목록</a>
    <a href="${path}/mypage/refundList?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="refundList" }'>w3-red </c:if>">
    &nbsp; · 환불 내역</a>
    <a href="${path}/mypage/cancelList?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="cancelList" }'>w3-red </c:if>">
    &nbsp; · 주문 취소 내역</a>    
    <a href="${path}/mypage/reviewList?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="reviewList" }'>w3-red</c:if>">
    &nbsp; · 리뷰관리</a>
    <a href="${path}/mypage/pointList?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="pointList" }'>w3-red</c:if>">
    &nbsp; · 포인트 내역</a>
    <hr>
    <a href="${path}/mypage/challList?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="chall"}'>w3-red </c:if>">
    &nbsp; · 챌린지 참여 내역</a>
    <hr>
    <a href="${path}/mypage/cs?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url=="cs"}'>w3-red </c:if>">
    &nbsp; · 1:1문의</a>
    <hr>
    <a href="${path }/mypage/myInfo?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url ==  "myInfo"}'>w3-red</c:if>">
    &nbsp; · 회원정보</a>
    <a href="${path }/mypage/deliveryList?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url ==  "deliveryList"}'>w3-red</c:if>">
    &nbsp; · 배송지 관리</a>
    <a href="${path }/mypage/memDelete?mem_id=${sessionScope.loginMem.mem_id}" 
    class="w3-bar-item w3-button w3-padding <c:if test='${url ==  "memDelete"}'>w3-red</c:if>">
    &nbsp; · 회원 탈퇴</a>
  </div>
  <br>    

</nav>