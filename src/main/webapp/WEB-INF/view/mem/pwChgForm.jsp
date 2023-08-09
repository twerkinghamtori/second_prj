<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>비밀번호 변경</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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
    .container .form-group{position: relative;}
    #minMsg{position: absolute; bottom: 5vh; left: 0; color: red;}
    #cor1, #cor2{position:relative;}
  	#corPwMsg{position:absolute; bottom:-40%; left:0;}
  	#pwChkMsg{ position:absolute; bottom:-37%; left:0;}
  </style>
  <script>
	function inchk(f){
		if(f.mem_pw.value.trim() === ""){
			alert("변경 비밀번호를 입력하세요");
	        f.mem_pw.focus();
	        return false;
		}			
		if(f.mem_pw2.value.trim() === ""){
			alert("변경 재입력 비밀번호를 입력하세요");
	        f.mem_pw2.focus();
	        return false;
		}
	    if(document.f.pwchkchk.value != "pwchecked") {
			alert("비밀번호를 확인해주세요.");
			return false;
		 }
		 if(document.f.corpwchk.value != "pwchecked") {
			alert("비밀번호를 확인해주세요.");
			return false;
		}
	    return true;
	}
	$(function() {
		$("#mem_pw").keyup(function() {
			corPwChk();
			pwChk();
		})
		$("#mem_pw2").keyup(function() {
			corPwChk();
			pwChk();
		})
	})
	function corPwChk() {
		let param = {pass:$("#mem_pw").val(), pass2:$("#mem_pw2").val()};
		$.ajax({
			url : "${path}/ajax/corrPassChk",
			type : "POST",
			data : param,
			success : function(result) {
				$("#corPwMsg").html(result)
			},
			error : function(e) {
				alert("비밀번호 입력" + e.status)
			}
		})
	}
	function pwChk() {
		let param = {pass:$("#mem_pw").val(), pass2:$("#mem_pw2").val()};
		$.ajax({
			url : "${path}/ajax/passChk",
			type : "POST",
			data : param,
			success : function(result) {
				$("#pwChkMsg").html(result)
			},
			error : function(e) {
				alert("비밀번호 입력" + e.status)
			}
		})
	}
</script>
</head>
<body>
   <form action="password1"  method="post" name="f" onsubmit="return inchk(this)" >
     <div class="container">
     <input type="hidden" name="email" value="${param.email}">
       <h2>비밀번호 변경</h2>
       <!-- 비밀번호-->
       <div id="cor1" class="form-group">
         <label class="mb-1" for="pwd">변경 비밀번호</label>
         <input type="password" class="form-control mb-4" id="mem_pw" name="mem_pw" placeholder="8~16자 영대소문자/숫자 조합 특수문자 불가">
         <div class="invalid-feedback" id="corPwMsg"></div>
       </div>
       <!-- 비밀번호 재입력 -->
       <div id="cor2" class="form-group mt-5">
         <label class="mb-1" for="pwd">변경 비밀번호 재입력</label>
         <input type="password" class="form-control mb-5" id="mem_pw2" name="mem_pw2">
         <div class="invalid-feedback" id="pwChkMsg"></div> 
       </div>

       <div class="form-group">
         <button type="submit" class="btn btn-dark">변경하기</button>
       </div>
       
     </div>
   </form>
</body>
</html>