<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
<title><sitemesh:write property="title"/></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${path }/css/style_admin.css">
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<style>
  .nav-item.dropdown-item a{
    text-decoration: none;
  }
</style>
<script type="text/javascript">
function topFunction() {
  document.body.scrollTop = 0; 
  document.documentElement.scrollTop = 0;
}
</script>
<sitemesh:write property="head"/>
</head>
<body class="w3-light-grey" style="position : relative">
<button class="w3-btn w3-black" onclick="topFunction()" id="myBtn123"><i class="fa fa-chevron-up"></i></button>
  
  <!-- 상단 Nav -->
  <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top" id="topNav">
    <div class="container-fluid">
      <a class="navbar-brand ms-5" href="${path }/admin/main"><span class="text-danger">호미짐</span> 관리자</a>
      <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
        <ul class="navbar-nav ml-auto mr-4">
	       	<c:if test="${sessionScope.loginManager.manager_grant eq '총괄'}">
	        	 <li class="nav-item dropdown">
	        	 	<a class="nav-link" href="${path }/admin/manager/managerList"><i class="fa fa-users" aria-hidden="true"></i> 매니저 관리</a>
	          </li>
	         </c:if>
          <li class="nav-item">
            <a class="nav-link" href="${path }/admin/mem/memList"><i class="fa fa-users" aria-hidden="true"></i> 회원 관리</a>
          </li>
          <li class="nav-item dropdown" style="margin-right: 100px;">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"><i class="fa fa-question-circle" aria-hidden="true"></i> 고객센터</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="${path }/admin/qna">자주 묻는 질문</a></li>
              <li><a class="dropdown-item" href="${path }/admin/cs/csList">1:1 문의</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${path }/admin/logout"><i class="fa fa-sign-out" aria-hidden="true"></i> 로그아웃</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
	
  <!-- 왼쪽 사이드 바 -->
  <nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:250px;" id="mySidebar"><br>
    <div class="container">
      <h3 class="text-center">쇼핑몰 관리</h3>
      <br>
      접속자 : <span class="text-success fw-bold">${sessionScope.loginManager.manager_name}</span>(${sessionScope.loginManager.manager_grant})
    </div>
    <hr>
    <div class="w3-bar-block">
      <ul class="navbar-nav ml-auto mr-4">
        <li class="nav-item dropdown-item <c:if test='${url eq "product"}'>w3-blue</c:if>">
          <h4><a href="${path }/admin/product/prodList"><i class="fa fa-shopping-bag" aria-hidden="true"></i> 제품 관리</a></h4>
        </li>
        <li class="nav-item dropdown-item <c:if test='${url eq "opt"}'>w3-blue</c:if>">
          <h4><a href="${path }/admin/opt/optList"><i class="fa fa-cog" aria-hidden="true"></i> 제품 옵션/재고 관리</a></h4>
        </li>
        <li class="nav-item dropdown-item <c:if test='${url eq "stock"}'>w3-blue</c:if>">
          <h4><a href="${path }/admin/stock/stockList"><i class="fa fa-cube" aria-hidden="true"></i> 재고 등록 내역</a></h4>
        </li>
        <li class="nav-item dropdown-item <c:if test='${url eq "order"}'>w3-blue</c:if>">
          <h4><a href="${path }/admin/order/orderList" ><i class="fa fa-paper-plane-o" aria-hidden="true"></i> 주문 관리</a></h4>
        </li>
        <li class="nav-item dropdown-item <c:if test='${url eq "refund"}'>w3-blue</c:if>">
          <h4><a href="${path }/admin/refund/refundList" ><i class="fa fa-reply" aria-hidden="true"></i> 환불 관리</a></h4>
        </li>
        <li class="nav-item dropdown-item <c:if test='${url eq "review"}'>w3-blue</c:if>">
          <h4><a href="${path }/admin/review/reviewList" ><i class="fa fa-comment-o" aria-hidden="true"></i> 리뷰 관리</a></h4>
        </li>
        <li class="nav-item dropdown-item <c:if test='${url eq "stat"}'>w3-blue</c:if>">
          <h4><a href="${path }/admin/stat/sale" ><i class="fa fa-line-chart" aria-hidden="true"></i> 매출 분석</a></h4>
        </li>
        <li class="nav-item dropdown-item <c:if test='${url eq "point"}'>w3-blue</c:if>">
          <h4><a href="${path}/admin/point/pointList"><i class="fa fa-product-hunt" aria-hidden="true"></i> 포인트 관리</a></h4>
        </li>
        <li class="nav-item dropdown-item <c:if test='${url eq "chall"}'>w3-blue</c:if>">
          <h4><a href="${path}/admin/chall/challList">💪이벤트 관리</a></h4>
        </li>
      </ul>
    </div>
  </nav>
  
  <div style="margin-left:270px;margin-top:43px;margin-right: 50px ;min-height: 100vh;">
    <!-- 사이트매시 바디 시작-->
    <sitemesh:write property="body"/>
    <!-- 사이트매시 바디 끝 -->
  </div>

  <hr>

  <!-- 푸터 -->
  <footer class="w3-container w3-padding-16 w3-center">  
    <div class="w3-xlarge w3-padding-32 fw-bold">
      <h5><i class="fa fa-map-marker"></i> 구디아카데미 GDJ62기 두리두리차두리 (정진규, 강수빈)</h5>
      <h5><i class="fa fa-envelope"></i> rritjy@naver.com | zxc2289@naver.com</h5>
      <h5><i class="fa fa-instagram"></i> @jeongjingyu63 | @sub__b.in</h5>
    </div>
    
    <a class="btn btn-outline-dark" href="${path }/">호미짐 바로가기</a>
  </footer>

</body>
</html>
