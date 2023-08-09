<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"	 %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<style>
  .sticky-card {
    position: fixed;
    top: 250px; /* 고정된 위치의 상단 여백 조정 */
    right: 50px; /* 고정된 위치의 우측 여백 조정 */
  }
</style>
<script>
	$(function() {
		//수량 1일 때, - 버튼 비활성화		
	    $(".quantity").each(function() {
			var quantity = parseInt($(this).val());
			var minusBtn = $(this).siblings(".minusBtn");

			if (quantity <= 1) {
				minusBtn.prop("disabled", true);
			} else {
				minusBtn.prop("disabled", false);
			}
		});
		//수량계산	
		$("input[type='checkbox']").change(function() {
    		var optNumbers = [];
    		$("input[type='checkbox']:checked").each(function() {
        		optNumbers.push($(this).val());
    		});
    		console.log(optNumbers);
    
    		$.ajax({
        		url: "${path}/ajax/cartCalculate",
        		type: "POST",
        		contentType: "application/json",
        		data: JSON.stringify(optNumbers),
        		success: function(result) {
            		var total = result.total;
            		var discounted = result.discounted;
            		var discountedTotal = total - discounted;
            		$(".card-text").eq(0).text("주문금액: " + total.toLocaleString() + "원");
            		$(".card-text").eq(1).text("할인: " + discounted.toLocaleString() + "원");
            		$(".card-text").eq(2).text("결제예정금액: " + discountedTotal.toLocaleString() + "원");
        		},
        		error: function(e) {
            		alert("장바구니 계산 오류: " + e.status);
        		}
    		});
		}) 
		//x버튼 눌렀을 때
		$(".removeBtn").click(function() {
			var tableIndex = $(this).attr("id").split("_")[1]; // 삭제 버튼의 인덱스 추출
			var selectedTable = $(".table").eq(tableIndex); // 해당 인덱스의 테이블 선택
			var optNumber = selectedTable.find("input[name='opt_number']").val();
			console.log(optNumber)
			$.ajax({
				url : "${path}/ajax/cartDelete",
				type : "POST",
				data : {
					opt_number : optNumber
				},
				success : function(result) {
					// 삭제 성공 시 테이블 제거
					selectedTable.remove();
					location.reload();
				},
				error : function(e) {
					alert("장바구니 삭제 오류: " + e.status);
				}
			});
		})
		//-버튼 눌렀을 때
		$(".minusBtn").click(function() {
			var tableIndex = $(this).attr("id").split("_")[1];
			var selectedTable = $(".table").eq(tableIndex);
			var optNumber = selectedTable.find("input[name='opt_number']").val();
			var quantity = parseInt(selectedTable.find("#quantity").val());
			$.ajax({
				url : "${path}/ajax/cartMinus",
				type : "POST",
				data : {
					opt_number : optNumber
				},
				success : function(result) {
					location.reload();
				},
				error : function(e) {
					alert("장바구니 수량 수정 오류: " + e.status);
				}
			});
		})
		$(".plusBtn").click(function() {
			var tableIndex = $(this).attr("id").split("_")[1];
			var selectedTable = $(".table").eq(tableIndex);
			var optNumber = selectedTable.find("input[name='opt_number']").val();
			var quantityInput = selectedTable.find("input[name='quantity']");
			
			$.ajax({
				url : "${path}/ajax/cartPlus",
				type : "POST",
				data : {
					opt_number : optNumber, opt_count : quantityInput.val()
				},
				success : function(result) {
					if (quantityInput.val() >= parseInt(result)) {
		        	   alert("상품 재고보다 많이 주문할 수 없습니다.");
		        	   quantityInput.val(result);		        	   
		        	   return;
		        	} else {
		        		location.reload();
		        	}					
				},
				error : function(e) {
					alert("장바구니 수량 수정 오류: " + e.status);
				}
			});
		})
	})
	function submit() {
		document.f.submit();
	}
</script>
</head>
<body>
<form action="checkout" method="post" name="f" id="f">
	<div class="container">
      <h1 class="mt-5">장바구니</h1>
      <div class="row mt-4">
        <div class="col-lg-8">
          <hr>                         
          <c:if test="${! empty cartList}">
          <c:forEach items="${map}" var="map" varStatus="st">        
          <input type="hidden" name="opt_number" id="opt_number" value="${map.value.opt_number }">                
          <table class="table">                	
          	<tr>
          		<td rowspan="5" width="5%">
          			<input type="hidden" name="opt_number" id="opt_number" value="${map.value.opt_number }"> 
          			<input class="form-check-input" type="checkbox" value="${map.value.opt_number}" name="opt_numberChecked">
          		</td>
          	</tr>
            <tr>
              <td rowspan="4" width="20%"><img src="${path }/img/thumb/${map.value.product_thumb }" style="width:100px;height:100px;"></td>
              <th width="20%">상품명</th>
              <td width="50%">${map.value.product_name }</td>
            </tr>
            <tr>
              <th>선택 옵션 명</th>
              <td>${map.value.opt_name }</td>
              <td rowspan="4"><button type="button" id="removeBtn_${st.index }" class="btn-close removeBtn" aria-label="Close"></button></td>
            </tr>
            <tr>
              <th>구입수량</th>
              <td>
                <div class="btn-group">
                  <button type="button" class="btn btn-secondary minusBtn" id="minusBtn_${st.index }">-</button>
                  <input type="number" name="quantity" class="quantity" id="quantity" style="width:50px;" value="${map.key.opt_count }" readonly>
                  <button type="button" class="btn btn-secondary plusBtn" id="plusBtn_${st.index }">+</button>
                </div>
              </td>
            </tr>
            <tr>
              <th>가격</th>
              <td><fmt:formatNumber value="${(map.value.product_price * (100-map.value.product_discountRate)/100) * map.key.opt_count }" pattern=",###"/>원</td>
              
            </tr>
          </table>
          </c:forEach>
          </c:if> 
          <c:if test="${empty cartList }">
          	<div class="row">
        		<div class="col-12" style="display: flex; justify-content: center; align-items: center; height: 300px;">          
            		<h2 style="margin-bottom: 30px;">장바구니에 상품이 없습니다.</h2> 
        		</div>
      		</div>
      		<div class="row">
        		<div class="col-12" style="display: flex; justify-content: center; align-items: center;">
          			<button type="button" class="btn btn-danger btn-lg" id="join"><a href="${path }/index" style="text-decoration:none;">홈으로</a></button>
          			<button type="button" class="btn btn-danger btn-lg ms-2"><a href="${path }/product/productList" style="text-decoration:none;">쇼핑하기</a></button>
        		</div>
      		</div>
          </c:if>
        </div>

	        <div class="col-lg-4 sticky-card">
	          <div class="card">
	            <div class="card-body">
	              <h5 class="card-title">결제정보</h5>
	              <hr>
	              <p class="card-text">주문금액: 0원</p>
	              <p class="card-text">할인: 0원</p>
	              <p class="card-text">결제예정금액: 0원</p>
	            </div>
	          </div>
	          <div class="mt-3">
	            <button type="submit" class="btn-danger btn-lg"  style="width:100%" onclick="javascript:submit()">구매하기</button>
	          </div>
	        </div>	     
      </div>
    </div>
 </form>
</body>
</html>