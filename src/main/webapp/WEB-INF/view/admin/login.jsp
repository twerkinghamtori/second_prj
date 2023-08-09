<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html lang="en">
<head>
<title>호미짐 관리자</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${path}/css/style_admin.css">
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<style type="text/css">
	#loginBtn{border-radius: 2em;}
</style>
<script>
function inputChk(form) {
  const managerId = form.manager_id.value.trim();
  const managerPass = form.manager_pass.value.trim();

  if (managerId === "" || managerPass === "") {
    alert("아이디와 비밀번호를 모두 입력해주세요.");
    return false; 
  }

  return true;
}
</script>
</head>
<body class="w3-light-grey">
    <form action="login" name="f" method="post" onsubmit="return inputChk(this)">

      <div class="container p-5 w3-white mt-5" style="width: 30%; border-radius: 2em;">
      	<div class="text-center"><img src="${path }/images/logo.png" style="width : 60%"></div>
        <h1 class="text-center mb-5">관리자 로그인</h1>
        
        <div class="form-group">
          <label class="mb-1">아이디</label><input placeholder="아이디" type="text" name="manager_id" class="form-control mb-4" required="required" value="hamtori">
          <label class="mb-1">비밀번호</label><input placeholder="비밀번호" type="password" name="manager_pass" class="form-control mb-3" required="required" value="1234">
        </div>
        
        <div class="mb-5">아이디 : <span class="text-primary">hamtori</span> | 비밀번호 : <span class="text-primary">1234</span></div>
        
        <div class="mt-3">
          <button id="loginBtn" type="submit" class="btn btn-dark w-100 mb-3">로그인</button>
        </div>
        
        <div class="mt-5 text-center">
					<a class="btn btn-outline-dark" href="${path }/">호미짐 바로가기</a>
        </div>
      </div>
      
    </form>
</body>
</html>