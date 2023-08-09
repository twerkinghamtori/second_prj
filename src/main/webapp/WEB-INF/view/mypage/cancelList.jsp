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
		console.log(order_id)
		$.ajax({
			url : "${path}/ajax/orderDetail",
			method : "POST",
			data : {order_id : order_id}, 
			success : function(result) {
				var html = ""
				html+="<tr style='background-color:pink; color:white;'><th>상품명</th><th>옵션명</th><th>상품가격</th><th>주문수량</th><th>상품총액</th></tr>"              	
				$.each(result, function(index, o) {
					html += "<tr>";
					html += "<td>" + o.product_name + "</td>";
					html += "<td>" + o.opt_name + "</td>";
					html += "<td>" + o.product_price + "원 </td>";
					html += "<td>" + o.opt_count + "개 </td>";
					html += "<td>" + o.product_price * o.opt_count + "원 </td>";
					html += "</tr>";
				})
				console.log(html);
				$("#orderDetail"+order_id).html(html);
			}, error : function(e) {
				alert("주문 상세정보 불러오기 오류 : " + e.status)
			}
		})
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
      <h1 class="mb-3">주문 취소 내역</h1>
      <c:if test="${empty map }">
      		<h2 class="text-secondary text-center" style="margin-top:50px;">주문 취소 내역이 없습니다.</h2>
      </c:if>
      <c:if test="${!empty map }">      
      <div class="row">
        <div class="col-7">
          <h5>총 <span style="color: red;">${map.size() }</span>건</h5>
        </div>
        <div class="col-5 text-end">
        	<div class="btn-group mb-3">
	  </div>
        </div>
      </div>
      
      <div class="row" id="oinfo" class="info">
      
      
        <table class="table table-hover">
          <tr style="text-align:center; background-color:#D1180B; color: white;">
            <th>취소일자</th>
            <th>주문번호</th>
            <th>취소사유</th>
            <th>취소금액</th>
            <th>처리현황</th>
          </tr>
        <c:forEach items="${map }" var="entry" varStatus="st">
          <tr style="text-align:center;">
            <td><fmt:formatDate value="${entry.value.get(0).refund_date}" pattern="yyyy-MM-dd" /></td>
            <td><a href="javascript:list_disp('${entry.key }')">${entry.key }</a></td>
            <td>${entry.value.get(0).refund_reason}</td>           
            <td><fmt:formatNumber value="${entry.value.get(0).refund_price }" pattern="###,###"/>원</td>
            <td>${entry.value.get(0).refund_type }</td>
          </tr>          
          <!-- 주문 상세정보 -->
          <tr style="text-align:center; display:none;" class="saleLine" id="saleLine${entry.key }">
            <td colspan="7">
            <table id="orderDetail${entry.key }" class="table table-borderless">       
                   
            </table>
            </td>
          </tr>
          </c:forEach>
        </table>
      </div>
      </c:if>
      
    </div>
			</div>
		</div>
</body>
</html>