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
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 1:1 문의 답변</h3>
      <p class="mb-3">1:1 문의를 답변하는 페이지 입니다.</p>

      <form action="csRe" method="post">
      	<input type="hidden" name="cs_number" value="${cs.cs_number }">

        <div class="form-group">
          <label class="mb-1">회원 아이디</label>
          <div class="mb-4">
            <input name="mem_id" type="text" class="form-control" value="${cs.mem_id }" readonly>
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
						
	         	<label class="mb-1">담당자<span class="text-danger">*</span></label>
	          <div class="mb-4">
	            <input name="manager_name" type="text" class="form-control" value="${sessionScope.loginManager.manager_name }" readonly>
	          </div>
	          
          	<label class="mb-1" >답변 내용<span class="text-danger">*</span></label>
	          <div class="mb-4">
	            <textarea  class="form-control" name="cs_aContent" required="required"></textarea>
	          </div>
        	</div>
        	
        <div class="text-center mt-3">
          <button type="submit" class="btn btn-dark">등록</button>
          <a class="btn btn-dark" href="csList">목록</a>
        </div>

      </form>
      <br>
    </div>
</body>
</html>