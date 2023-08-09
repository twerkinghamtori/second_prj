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
<style>
  .carousel-item img {
    min-width: 500px;
    width: 100vw;
    height: 80vh; /* 이미지 높이 고정 */
    object-fit: cover; /* 이미지 비율 유지 */
  }
  .jumbo {
	  position: absolute;
	  top: 40%;
	  left: 30%;
	  transform: translate(-50%, -50%);
	  text-align: center;
	  z-index: 1;
	}
	.jumbo h3, .jumbo h5 {
	  color: white;
	  text-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
	  margin: 0;
	}
  .carousel-control-prev,
  .carousel-control-next {
    background-color: rgba(255, 255, 255, 0.5); /* 버튼의 배경색을 투명 검은색으로 설정합니다 */
    border: none; 
    opacity: 0.7; 
    width: 60px; 
    height: 60px; 
    position: absolute; 
    top: 50%; 
    transform: translateY(-50%); 
    z-index: 1;
  }
  .carousel-control-prev {left : 2.5%}
  .carousel-control-next {right : 2.5%}
  .carousel-control-prev:hover,
  .carousel-control-next:hover {opacity: 1;}
  .w3-quarter h2 {font-weight : bold;}
	.w3-quarter {
		height:450px;
		width : 22%;
		margin : 10px;
		box-shadow: 0px 4px 8.5px 0 rgba(0,0,0,0.4);
		display : flex;
		flex-direction: column;
		transition: transform 0.2s ease;
	   text-align: left;
	}
  .w3-quarter:hover {
    transform: scale(1.1);
    z-index: 9;
  }
  a{text-decoration: none;}
  a:hover{color: red;}
</style>
</head>
<body>
	<!-- 사이트매시 바디 시작-->
    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style="margin-top: -30px;">
      <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
      </div>
      <div class="carousel-inner">
      
        <div class="carousel-item active">
          <div class="jumbo">
            <h3 class="display-4 fw-bold mb-4">덤벨 가격 실화?</h3>
            <h5 class="mb-4">
              호미짐 오픈기념 덤벨 10% 할인!!
              <br>
              <br>
              <a class="btn btn-danger btn-lg" href="${path }/product/productList?product_type=1" role="button">바로가기</a>
            </h5>
          </div>
          <img src="images/item.jpg" class="d-block w-100" alt="...">
        </div>
        
        <div class="carousel-item">
          <div class="jumbo">
            <h3 class="display-4 fw-bold mb-4">오운완 챌린지</h3>
            <h5 class="mb-4">
              매일매일 📷인증샷을 남겨 포인트를 받아가세요! 
              <br>
              <br> 
              <a class="btn btn-danger btn-lg" href="${path }/chall/challList" role="button">바로가기</a>
            </h5>
          </div>
          <img src="images/event.jpg" class="d-block w-100" alt="...">
        </div>
        
        <div class="carousel-item">
          <div class="jumbo">
            <h3 class="display-4 fw-bold mb-4">회원가입 이벤트</h3>
            <h5 class="mb-4">
              🎁신규 회원가입 시 2000포인트 증정! 
              <br>
              <br> 
              <a class="btn btn-danger btn-lg" href="${path }/mem/join" role="button">바로가기</a>
            </h5>
          </div>
          <img src="images/joinPoint4.jpg" class="d-block w-100" alt="...">
        </div>
        
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>

    <div class="container">
      <h3 class="fw-bold mt-5">👍 호미짐 BEST4 상품</h3>
      <div class="w3-row-padding w3-padding-16 w3-center">
      	<c:forEach items="${top4Products }" var="p" varStatus="st">
      		<div class="w3-quarter">
          		<h2>Best ${st.index+1 }</h2>
          		<a href="product/productDetail?product_number=${p.product_number }"><img src="${path }/img/thumb/${p.product_thumb}" style="width:100%">
          		<h4 class="ms-3">${p.product_name }</h4></a>
          		<div class="ms-3" style="display: flex; justify-content: space-between;">
          			<c:if test="${p.product_discountRate != 0 }">
          				<div class="text-primary">${p.product_discountRate }%</div>          				
          				<div style="margin-right: 20px">
	          				<span class="text-secondary" style="text-decoration:line-through;"><fmt:formatNumber value="${p.product_price}" pattern=",###" />원</span>          				
	          				<fmt:formatNumber value="${p.product_price * (100-p.product_discountRate)/100 }" pattern=",###" />원
          				</div>
          			</c:if>
          			<c:if test="${p.product_discountRate == 0 }">
          				<span><fmt:formatNumber value="${p.product_price * (100-p.product_discountRate)/100 }" pattern=",###" />원</span>
          			</c:if>
          		</div>
        	</div>
      	</c:forEach>
      </div>
    </div>
</body>
</html>