<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<style>
  .nav-item.dropdown-item a{
    text-decoration: none;
  }
  #customer .btn {
    border-bottom: 2px solid transparent;
    transition: all 0.3s;
    position: relative;
  }

  #customer .btn::after {
    content: "";
    position: absolute;
    bottom: -2px;
    left: 50%;
    width: 0;
    height: 5px;
    background-color: white;
    transition: all 0.3s;
    transform: translateX(-50%);
  }

  #customer .btn.active::after,
  #customer .btn:hover::after {
    width: 100%;
    transform: translateX(-50%);
  }
  
  .red-border {
    border-bottom: 3px solid red;
  }
  
  .w3-bar-block {
    border-radius: 8px; /* 꼭짓점을 둥글게 설정 */
    box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* 그림자 효과 설정 */
  }
  
  .content{
  	min-height: 100px;
  	padding: 10px;
  	background-color: rgba(0,0,0,0.1);
  	text-align: left;
  	margin-left: 70px;
  	margin-right: 50px;
  }
  .cc{
  	color : white;
  	font-size : 16px;
  }
</style>
<script type="text/javascript">
$(()=>{
	$("#c").addClass("active");
});
</script>
</head>
<body>
	<br><br>
    <div class="container-sm pt-1">
      <div style="display:flex;">
        <div style="flex-basis: 20%; margin-top : 100px;">
          <nav class="w3-bar-block w3-red p-3">
            <div id="customer" class="w3-large w3-center" style="font-weight:bold">
              <h2><i class="fa fa-question-circle" aria-hidden="true"></i> 고객센터</h2><br>
              <p>
              <a href="${path }/qna" class="btn cc">· 자주 묻는 질문</a><br>
              <a href="${path }/cs" class="btn cc active">· 1:1 문의</a>
            </div>
          </nav>
        </div>
        <div style="flex-basis: 5%">&nbsp;</div>
        <div style="flex-basis: 75%; margin-right: 100px">
          <h2 class="mb-3"><i class="fa fa-caret-square-o-right text-danger" aria-hidden="true"></i> 1:1 문의</h2>
          <p class="mb-3">
            <span class="text-danger">· 제품 사용, 오염, 전용 박스 손상, 라벨 제거, 사은품 및 부속 사용/분실 시, 교환/환불이 불가능 합니다.</span> <br>
            <span class="text-danger">· 교환을 원하시는 상품(사이즈)의 재고가 부족 시, 교환이 불가합니다.</span> <br>
            · 주문취소/환불은 마이페이지>주문내역에서 신청하실 수 있습니다. <br>
            · 1:1문의 처리 내역은 마이페이지>1:1문의를 통해 확인하실 수 있습니다. <br>
          </p>
          <div class="mt-1 mb-1"><a class="btn btn-sm btn-danger" href="${path}/mypage/cs?mem_id=${sessionScope.loginMem.mem_id}">내 문의</a></div>
          <div class="w3-light-grey w3-padding-large w3-margin-top" id="contact">
            <form action="csQ" method="post">
              <div class="w3-section">
                <label>이메일</label>
                <input class="w3-input w3-border" type="text" value="${loginMem.mem_id} "  readonly required name="mem_id">
              </div>
              <div class="w3-section">
                <label>문의내용</label>
                <textarea class="w3-input w3-border" name="cs_qContent" cols="30" rows="10" required="required"></textarea>
              </div>
              <button type="submit" class="w3-button w3-block w3-dark-grey">전송</button>
            </form><br>
          </div>
        </div>
      </div>
    </div>
</body>
</html>