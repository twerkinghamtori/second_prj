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
	function input_chk(f) {
	  if(f.refund_reason.value.trim() == "optionNotSelected") {
		  alert("환불사유를 입력해주세요.");
		  f.refund_reason.focus();
		  return false;
	  }
	  if(f.refund_optCount.value.trim() == "optionNotSelected") {
		  alert("환불수량을 선택해주세요.")
		  f.refund_optCount.focus();
		  return false;
	  }

	  return true;
	}
</script>
</head>
<body>
	<div class="container">
		<div style="display: flex; justify-content: space-between;">
			<div style="flex-basis: 20%;">
				<%@ include file="mypageSideBar2.jsp"%>
			</div>
			<div style="flex-basis: 80%;">
      			<h1 class="mb-3">환불 신청</h1>
      			<p class="mb-3 text-secondary">
      				· 구매 후<span class="text-danger"> 2주가 지난 상품</span> 및 <span class="text-danger">배송완료 되지 않은 상품</span>은 환불이 불가합니다. <br>
      				· 포인트를 사용하여 결제금액보다 환불금액이 큰 경우 <span class="text-danger"> 포인트 우선 환불</span> 됩니다. <br>
      			</p>
      			<div class="row">
      				<c:if test="${empty ov }">
      					<div class="text-secondary mt-5">
      						환불 가능한 상품이 없습니다. 
      					</div>
      				</c:if>
      				<c:if test="${!empty ov }">
						<form class="form-control" action="refundReq?mem_id=${sessionScope.loginMem.mem_id }" method="post" name="f" onsubmit="return input_chk(this)">
							<input type="hidden" name="order_id" id="order_id" value="${ov.order_id }">
							<input type="hidden" name="order_itemId" id="order_itemId" value="${ov.order_itemId }">
							<input type="hidden" name="opt_number" id="opt_number" value="${ov.opt_number }">
							<div>
								<div class="form-group mb-3">
									<label class="mb-1" for="order_itemId">구매정보</label>
									<div class="input-group mb-3">
										상품명 : &nbsp;&nbsp;&nbsp;<input type="text" class="form-control" name="product_name" id="product_name" readonly value="${ov.product_name }">
									</div>
									<div class="input-group mb-3">
										옵션명 : &nbsp;&nbsp;&nbsp;<input type="text" class="form-control" name="opt_name" id="opt_name" readonly value="${ov.opt_name }">
									</div>
									<div class="input-group mb-3">
										주문개수 : &nbsp;&nbsp;&nbsp;<input type="text" class="form-control" name="opt_count" id="opt_count" readonly value="${ov.opt_count }">
									</div>
								</div>

								<div class="mb-3">
									<select class="form-select" id="refund_reason" name="refund_reason">
										<option value="optionNotSelected" disabled selected>환불사유를 선택하세요.</option>
										<option>고객 단순 변심</option>
										<option>실수로 구매함</option>
										<option>구매한 상품을 더 이상 원하지 않음</option>
										<option>상품 정보 상이</option>
										<option>제품 결함</option>
									</select>
								</div>
								
								<div class="mb-3">
									<select class="form-select" id="refund_optCount" name="refund_optCount">
										<option value="optionNotSelected" disabled selected>수량을 선택하세요.</option>
										<c:forEach begin="1" end="${ov.opt_count}" var="i">
        									<option value="${i}">${i}개</option>
    									</c:forEach>
									</select>
								</div>							
								<button type="submit" class="btn btn-danger">환불신청</button>
							</div>												
						</form>
      				</c:if>				
				</div>
			</div>
		</div>
	</div>
</body>
</html>