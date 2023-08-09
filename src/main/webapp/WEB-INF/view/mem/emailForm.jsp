<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${path }/css/style.css">
<style>
    .container{margin: 30px auto; padding: 0 50px;}
    h2{margin-bottom: 30px;}
</style>
</head>
<body>
	<form action="emailFormchk" name="f">
	<input type="hidden" name="emailchkchk" value="emailunchecked">
	<input type="hidden" name="email1" value="${email1 }">
	<input type="hidden" name="email2" value="${email2 }">
    <div class="container">
      <h2>이메일 인증</h2>
      <!-- 인증번호-->
      <div class="form-group">
        <label class="mb-1" for="authNum">인증번호</label>
        <input type="text" class="form-control mb-4" id="authNum" name="authNum" placeholder="인증번호를 입력해주세요.">
      </div>
      <div class="form-group">
      	<button type="submit" class="btn btn-dark">확인</button>
      		<c:if test="${able }">
      			<script>
        			opener.document.f.emailchkchk.value="emailchecked";        		
        			self.close();
        			//opener.document.getElementById("authMsg").innerHTML="인증 되었습니다.";
         			opener.document.f.email1.classList.add("is-valid");
       				opener.document.getElementById("emailBtn").style.display="none";  
        		</script>
      		</c:if>        
      </div>
    </div>
</form>
</body>
</html>