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
	function deleteD(delivery_number) {
		$.ajax({
			url : "${path}/ajax/deleteD",
			data : {delivery_number : delivery_number},
			success : function(result) {
				console.log(result)
				location.reload();
			}, error : function(e) {
				alert("배송지 정보 삭제 오류. " + e.status)
			}
		})
	}
	function win_open(page){		
    	let op = "width=500, height=700, left=50, top=150";
    	open(page,"",op);
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
      			<h1 class="mb-3">배송지 관리</h1>      			     			
      			<div class="row">
        			<div class="col-9">
          				<h5>총 <span style="color: red;">${deliveryList.size() }</span>건</h5>
        			</div>
        			<div class="col-3 text-end">
        				<button type="button" class="btn btn-danger btn-sm" onclick="javascript:win_open('newD')">배송지 추가</button>
        			</div>
      			</div>
      			<c:if test="${empty deliveryList }">
      				<h2 class="text-secondary text-center">저장된 배송지 내역이 없습니다.</h2>
      			</c:if>
      			<c:if test="${!empty deliveryList }"> 
      <div class="row" id="oinfo" class="info"> 
        <table class="table table-hover">
          <tr style="text-align:center; background-color:#D1180B; color: white;">
            <th>배송지 별명</th>
            <th>배송지 수령인</th>
            <th>배송지 주소</th>
            <th>전화번호</th>
            <th>삭제</th>
          </tr>
        <c:forEach items="${deliveryList }" var="d" varStatus="st">
          <input type="hidden" value="${d.delivery_number }">
          <tr style="text-align:center;">
            <td>${d.delivery_nickName }</td>
            <td>${d.delivery_receiver }</td>
            <td>[${d.delivery_postcode }] ${d.delivery_address } ${d.delivery_detailAddress }</td>
            <td>${d.delivery_phoneNo }</td>
            <td>
            	<button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#exampleModal${d.delivery_number }">배송지 정보 삭제</button>         
            </td>
          </tr>  
          <!-- Modal -->
					<div class="modal fade" id="exampleModal${d.delivery_number }" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">배송지 삭제</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">[${d.delivery_nickName }] 배송지 정보를 삭제하시겠습니까?</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-danger" onclick="javascript:deleteD('${d.delivery_number}')">삭제</button>
								</div>
							</div>
						</div>
					</div>        
          </c:forEach>
        </table>
					
				</div>
				</c:if>
    </div>
    
			</div>
		</div>
</body>
</html>