<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<style type="text/css">
	.brown, .btn-outline-custom-brown:hover {
		background-color: brown !important;
		color : white;
	}
</style>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1" style="width:40%">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 리뷰 상세</h3>
      <p class="mb-3">리뷰 상세 페이지 입니다.</p>

      <form action="reviewDel" method="post">
      	<input type="hidden" name="review_number" value="${review.review_number }">
				<table class="table table-bordered align-middle">
          <tr class="text-center">
          	<td class="brown text-center" width="30%">회원 아이디</td>
            <td>${review.mem_id}</td>
          </tr>
           <tr class="text-center">
          	<td class="brown text-center">구매 제품</td>
            <td>
            	<img src="${path }/img/thumb/${review.product_thumb }" width="200">
	          	<br>
	          	${review.product_name}
            </td>
          </tr>
          <tr class="text-center">
          	<td class="brown text-center" width="30%">리뷰 점수</td>
            <td>${review.review_value }/5</td>
          </tr>
          <tr class="text-center">
          	<td class="brown text-center" width="30%">리뷰 내용</td>
            <td>${review.review_content}</td>
          </tr>
          <tr class="text-center">
          	<td class="brown text-center" width="30%">리뷰 등록일</td>
            <td><fmt:formatDate value="${review.review_date }" pattern="yyyy-MM-dd" /></td>
          </tr>
          <tr class="text-center">
          	<td class="brown text-center" width="30%">리뷰 상태</td>
            <td>
            	${review.review_state } <br>
            	<c:if test="${review.review_state eq '지급대기'}">
            		<a type="button" class="btn btn-dark btn-sm" data-bs-toggle="modal" data-bs-target="#staticBackdrop1${review.review_number }">포인트 지급</a>
													
								<%-- Modal --%>
								<div class="modal fade" id="staticBackdrop1${review.review_number }" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div> 
								      <div class="modal-body">해당 회원에게 포인트를 지급 하시겠습니까?</div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
								        <a class="btn btn-dark" href="reviewStateChg?review_number=${review.review_number}">지급</a>
								      </div>
								    </div>
								  </div>
								</div>
            	</c:if>
            </td>
          </tr>
        </table>
        	
        <div class="text-center mt-3">
        	<c:if test="${sessionScope.loginManager.manager_grant eq '총괄'}">
       			<a type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop${review.review_number }">삭제</a>
													
						<%-- Modal --%>
						<div class="modal fade" id="staticBackdrop${review.review_number }" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div> 
						      <div class="modal-body">해당 리뷰를 삭제 하시겠습니까?</div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						        <button type="submit" class="btn btn-dark">삭제</button>
						      </div>
						    </div>
						  </div>
						</div>
					</c:if>
          <a class="btn btn-dark" href="reviewList">목록</a>
        </div>

      </form>
      <br>
    </div>
</body>
</html>