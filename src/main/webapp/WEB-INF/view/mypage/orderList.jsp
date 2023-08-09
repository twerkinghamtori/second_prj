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
	function list_disp(order_id) {
		$("#saleLine"+order_id).toggle();
		console.log(order_id);
		$.ajax({
			url : "${path}/ajax/orderDetail",
			method : "POST",
			data : {order_id : order_id}, 
			success : function(result) {
				var html = ""
				html+="<tr style='background-color:pink; color:white;'><th>상품명</th><th>옵션명</th><th>상품가격</th><th>주문수량</th><th>상품총액</th><th>리뷰쓰기</th><th>환불신청</th></tr>"              	
				$.each(result, function(index, o) {
					html += "<tr>";
					html += "<td>" + o.product_name + "</td>";
					html += "<td>" + o.opt_name + "</td>";
					html += "<td>" + o.product_price + "원 </td>";					
					html += "<td>" + o.opt_count + "개 </td>";
					html += "<td>" + (o.product_price * (100-o.product_discountRate)/100) * o.opt_count + "원 </td>";				
					if(o.order_state == '구매확정') {
						html += "<td>";
						html += "<button type='button' class='btn btn-outline-danger btn-sm' onclick=\"location.href='reviewReg?mem_id=${sessionScope.loginMem.mem_id}&order_itemId=" + o.order_itemId + "'\">";
						html += "리뷰쓰기</button>";
						html += "</td>";
					} else {
						html += "<td></td>"
					}
					if(o.order_state == '배송완료') {
						html += "<td>";
						html += "<button type='button' class='btn btn-outline-danger btn-sm' onclick=\"location.href='refundReq?mem_id=${sessionScope.loginMem.mem_id}&order_itemId=" + o.order_itemId + "'\">";
						html += "환불신청</button>";
						html += "</td>";
					} else {
						html += "<td></td>"
					}
					html += "</tr>";
				})
				$("#orderDetail"+order_id).html(html);
			}, error : function(e) {
				alert("주문 상세정보 불러오기 오류 : " + e.status)
			}
		})
	}
	function cancel(order_id) {
		  $.ajax({
		    url: "${path}/ajax/cancelOrder",
		    method: "POST",
		    data: { order_id: order_id },
		    success: function(result) {
		      alert(result);
		      location.reload();
		    },
		    error: function(e) {
		      alert("[ajax] 주문취소 오류: " + e.status);
		    }
		  });
		}
	function orderConfig(order_id) {
		$.ajax({
			url : "${path}/ajax/orderConfig",
			method : "POST",
			data : { order_id: order_id },
			success : function(result) {
				alert(result);
				location.reload();
			}, 
			error : function(e) {
				alert("[ajax] 주문취소 오류 : " + e.status);
			}
		});
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
      <h1 class="mb-3">주문조회</h1>
      <p class="mb-3 text-secondary">
      	·<span class="text-danger"> 주문 번호</span>를 누르시면 <span class="text-danger">주문 상세보기</span>가 가능합니다. <br>
      	·<span class="text-danger"> 리뷰 작성</span>은 <span class="text-danger">구매확정</span>이 된 주문 건만 작성 가능합니다. <br>
      	·<span class="text-danger"> 환불 내역</span>이 있는 주문은 <span class="text-danger">구매확정</span>할 수 없습니다. <br>
      	·<span class="text-danger"> 주문 취소</span>는 <span class="text-danger">상품 준비 중 이전</span>(결제완료)의 상품만 가능합니다. <br>
      </p>
      <c:if test="${empty map }">
      		<h2 class="text-secondary text-center" style="margin-top:50px;">주문 내역이 없습니다.</h2>
      </c:if>
      <c:if test="${!empty map }">
      <div class="row">      	
        <div class="col-2">
          <h5>총 <span style="color: red;">${map.size() }</span>건</h5>
        </div>
      </div>
      <div class="row" id="oinfo" class="info">
      
      
        <table class="table table-hover">
          <tr style="text-align:center; background-color:#D1180B; color: white;">
            <th>주문일자</th>
            <th>주문번호</th>
            <th>제품명</th>
            <th>결제금액</th>
            <th>배송비</th>
            <th>사용 포인트</th>
            <th>처리현황</th>
            <th>취소</th>
            <th>구매확정</th>
          </tr>
        <c:forEach items="${map }" var="map" varStatus="st">
          <tr style="text-align:center;">
            <td><fmt:formatDate value="${map.value.get(0).order_date }" pattern="yyyy년 MM월 dd일" /></td>
            <td><a href="javascript:list_disp('${map.key }')">${map.key }</a></td>
            <c:if test="${map.value.size() ==1 }">
            	<td style="white-space: pre-line; max-width: 250px; overflow: hidden; text-overflow: ellipsis;">${map.value.get(0).product_name }</td>
            </c:if>
            <c:if test="${map.value.size() !=1 }">
            	<td style="white-space: pre-line; max-width: 250px; overflow: hidden; text-overflow: ellipsis;">${map.value.get(0).product_name } 외 ${map.value.size() -1 } 개</td>
            </c:if>            
            <td><fmt:formatNumber value="${map.value.get(0).order_totalPay }" pattern="###,###"/>원</td>
            <td><fmt:formatNumber value="${map.value.get(0).delivery_cost }" pattern="###,###"/>원</td>
            <td><fmt:formatNumber value="${map.value.get(0).order_point }" pattern="###,###"/>P</td>
            <td>${map.value.get(0).order_state }</td>
            <td>
            	<c:if test="${map.value.get(0).order_state=='결제완료' }">
            		<button type="button" class="btn btn-outline-danger btn-sm" onclick="cancel('${map.key}')">주문취소</button>
            	</c:if>            	           
            </td>
            <td>
            	<c:if test="${map.value.get(0).order_state=='배송완료' }">
            		<button type="button" class="btn btn-outline-danger btn-sm" onclick="orderConfig('${map.key}')">구매확정</button>
            	</c:if>             	           
            </td>
          </tr>
                    
          <!-- 주문 상세정보 -->
          <tr style="text-align:center;display:none;" class="saleLine" id="saleLine${map.key }">
            <td colspan="9" >
            <table id="orderDetail${map.key }" class="table table-borderless">     
                           
            </table>
            </td>
          </tr>
          </c:forEach>
        </table>
      </div>
      
       <div class="w3-center w3-padding-32">
		    <div class="w3-bar">
			    <c:if test="${pageNum<= 1}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
					</c:if>
					<c:if test="${pageNum > 1}">
						<a class="w3-bar-item w3-button w3-hover-black" href="orderList?mem_id=${sessionScope.loginMem.mem_id }&pageNum=${pageNum-1}">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="orderList?mem_id=${sessionScope.loginMem.mem_id }&pageNum=${a}">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="orderList?mem_id=${sessionScope.loginMem.mem_id }&pageNum=${startPage+5}">&raquo;</a>
					</c:if>
		    </div>
		  </div>
      </c:if>
    </div>
			</div>
		</div>
</body>
</html>