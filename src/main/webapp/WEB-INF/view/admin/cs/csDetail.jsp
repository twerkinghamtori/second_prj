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
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1" style="width:50%">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 1:1 문의 상세</h3>
      <p class="mb-3">1:1 문의 상세 페이지 입니다.</p>

      <form action="csDel" method="post">
      	<input type="hidden" name="cs_number" value="${cs.cs_number }">

        <div class="form-group">
          <label class="mb-1">회원 아이디</label>
          <div class="mb-4">
            <input name="manager_id" type="text" class="form-control" value="${cs.mem_id }" readonly>
          </div>

          <label class="mb-1" >문의 날짜</label>
          <div class="mb-4">
          	<fmt:formatDate value="${cs.cs_qdate }" pattern="yyyy-MM-dd" />
          </div>

          <label class="mb-1" >문의 내용</label>
          <div class="mb-4">
            <textarea  class="form-control" readonly>${cs.cs_qContent }</textarea>
          </div>
						<hr>
					
	         	<label class="mb-1">담당자</label>
	          <div class="mb-4">
	            <input type="text" class="form-control" value="${cs.manager_name }" readonly>
	          </div>
	          
	           <label class="mb-1" >답변 날짜</label>
		          <div class="mb-4">
		          	<fmt:formatDate value="${cs.cs_adate }" pattern="yyyy-MM-dd" />
		          </div>
	          
          	<label class="mb-1" >답변 내용</label>
	          <div class="mb-4">
	            <textarea  class="form-control" required="required" readonly rows="7">${cs.cs_aContent }</textarea>
	          </div>
        	</div>
        	
        <div class="text-center mt-3">
        	<c:if test="${sessionScope.loginManager.manager_grant eq '총괄'}">
       		<a type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop${cs.cs_number }">삭제</a>
													
						<%-- Modal --%>
						<div class="modal fade" id="staticBackdrop${cs.cs_number }" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div> 
						      <div class="modal-body">해당 문의를 삭제 처리 하시겠습니까?</div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						        <button type="submit" class="btn btn-dark">삭제</button>
						      </div>
						    </div>
						  </div>
						</div>
					</c:if>
          <a class="btn btn-dark" href="csList">목록</a>
        </div>

      </form>
      <br>
    </div>
</body>
</html>