<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
</head>
<body>
	<div class="container">
      <div class="row">
        <div class="col-12" style="background-color: #E2E2E2; display: flex; justify-content: center; align-items: center; height: 500px;">
          <span style="text-align: center;">            
            <h2 style="margin-bottom: 30px;">호미짐을 이용해주셔서 감사합니다.</h2>
            <div style="background-color: lightgray;">
              <h1 style="margin-bottom: 30px;">주문이 <span style="color: red;">완료</span>되었습니다.</h1>
            </div>
            <h4 style="margin-bottom: 30px;" >${sessionScope.loginMem.mem_name } 님의 주문번호는 <a href="${path }/mypage/orderList?mem_id=${sessionScope.loginMem.mem_id}">${order_id }</a>입니다.</h4>
            <h6 style="text-decoration-color: grey;">주문내역 확인은 마이페이지의 "주문내역"에서 하실 수 있습니다.</h6>
          </span> 
        </div>
      </div>
      <div>
        <div class="container mt-5" align="center">
          <button type="submit" class="btn btn-danger btn-lg" id="join" onclick="location.href='/second_prj/'">홈으로</button>
          <button type="reset" class="btn btn-danger btn-lg ms-2" onclick="location.href='/second_prj/mypage/orderList?mem_id=${sessionScope.loginUser.mem_id}'">마이페이지</button>
        </div>  
      </div>
    </div>
</body>
</html>