<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%-- 이거는 비밀번호 찾기에서 들어오는 이메일인증폼임 --%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>이메일 인증</title>
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
   <script>
	function inchk(f){
		let email1 = document.f.email1.value;
		let email2 = document.f.email2.value;
		let email = email1 + "@" + email2;
		document.f.email.value = email;
		
		if(f.email1.value.trim() === ""){
			alert("이메일을 입력하세요");
	      	f.email1.focus();
	      return false;
			}

      	if(f.email2.value.trim() === ""){
				alert("이메일을 입력하세요");
	      f.email2.focus();
	      return false;
			}
      	
      	window.location.href="emailPwForm?email="+email;
      	f.submit();
	  }
</script>
</head>
<body>
   <form action="emailPwForm" method="POST" name="f" id="f" onsubmit="return inchk(this)">
     <div class="container">
     <input type="hidden" name="email" id="email">
     <input type="hidden" name="pwchg" id="pwchg" value="pwchgUnable">
       <h2>이메일 인증</h2>
       
       <div class="form-group">
         <label class="mb-1" for="pwd">이메일</label>
         <div class="input-group mb-3">
           <input type="text" class="form-control" name="email1" aria-label="Username">
           <span class="input-group-text">@</span>
           <select class="form-select" name="email2">
            	<option value="naver.com">naver.com</option>
            	<option value="nate.com">nate.com</option>
            	<option value="gmail.com">gmail.com</option>
            	<option value="hanmail.net">hanmail.net</option>
            	<option value="daum.net">daum.net</option>
            </select>
<!--          <input type="text" class="form-control" name="email2" placeholder="Example.com" aria-label="Server"> -->   
         </div>
       </div>
       <div class="form-group">
         <button type="submit" class="btn btn-dark" id="btn">이메일인증</button>
       </div>
     </div>
   </form>
</body>
</html>