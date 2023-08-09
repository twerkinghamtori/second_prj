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
</script>
</head>
<body>
	<div class="container">
		<div style="display: flex; justify-content: space-between;">
			<div style="flex-basis: 20%;">
				<%@ include file="mypageSideBar2.jsp"%>
			</div>
			<div style="flex-basis: 80%;">
      <h1 class="mb-3">리뷰관리</h1>
      <p class="mb-3 text-secondary">
      	· 이미 <span class="text-danger"> 포인트가 지급된 건</span> 에 대해서는 <span class="text-danger">리뷰 삭제가 불가</span>합니다. <br>
      	· 포인트 지급내역은 <span class="text-danger">마이페이지 > 포인트 내역</span> 에서 확인 가능합니다.<br>
      </p>
      <c:if test="${empty map }">
      		<h2 class="text-secondary text-center" style="margin-top:50px;">리뷰 내역이 없습니다.</h2>
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
            <th>등록일자</th>
            <th>별점</th>
            <th>리뷰내용</th>
            <th>주문상품</th>
            <th>수정</th>
            <th>삭제</th>
          </tr>
        <c:forEach items="${map }" var="m" varStatus="st">
          <tr style="text-align:center;">          	
            <td><fmt:formatDate value="${m.key.review_date}" pattern="yyyy-MM-dd" /></td>
            <td>
            	<c:if test="${m.key.review_value== '1' }">
            		<i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
            	</c:if>
            	<c:if test="${m.key.review_value== '2' }">
            		<i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
            	</c:if>
            	<c:if test="${m.key.review_value== '3' }">
            		<i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
            	</c:if>
            	<c:if test="${m.key.review_value== '4' }">
            		<i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
            	</c:if>
            	<c:if test="${m.key.review_value== '5' }">
            		<i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i><i class="fa fa-star text-danger" aria-hidden="true"></i>
            	</c:if>
            </td>
            <td>${m.key.review_content }</td>           
            <td><a href="../product/productDetail?product_number=${m.value.product_number}">${m.value.product_name }</a></td>
            <td><button type="button" class="btn btn-outline-danger btn-sm" onclick="location.href='reviewUpdate?mem_id=${sessionScope.loginMem.mem_id}&review_number=${m.key.review_number }'">리뷰수정</button></td>
            <td><button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteReview">리뷰삭제</button></td>
          </tr> 
          <!-- Modal -->
<div class="modal fade" id="deleteReview" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">호미짐</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        '${m.value.product_name }' 에 대한 리뷰를 삭제하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-danger" onclick="location.href='reviewDelete?mem_id=${sessionScope.loginMem.mem_id}&review_number=${m.key.review_number }'">삭제하기</button>
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