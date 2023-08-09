<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<script>
	//입력값 체크
	function input_check(f){
	  if(f.email1.value.trim() == "" ){
	    alert("이메일을 입력하세요")
	    f.email1.focus();
	    return false;
	  }
	  if(f.email2.value.trim() == "" ){
		    alert("이메일을 입력하세요")
		    f.email2.focus();
		    return false;
		  }
	  if(f.mem_pw.value.trim() == ""){
	    alert("비밀번호를 입력하세요")
	    f.mem_pw.focus();
	    return false;
	  }
	  if(f.mem_pw2.value.trim() == ""){
		    alert("비밀번호를 입력하세요")
		    f.mem_pw2.focus();
		    return false;
		  }
	  if(f.mem_name.value.trim() == ""){
	    alert("이름을 입력하세요")
	    f.mem_name.focus();
	    return false;
	  }	  
	  if(f.mem_phoneno.value.trim() == ""){
		    alert("전화번호를 입력하세요")
		    f.mem_phoneno.focus();
		    return false;
	  }
	  if(f.emailchkchk.value != "emailchecked") {
  		alert("이메일 인증을 해주세요.");
  		return false;
  	  }
	  if(f.pwchkchk.value != "pwchecked") {
		f.mem_pw2.focus();
		return false;
	  }
	  if(f.corpwchk.value != "pwchecked") {
		f.mem_pw.focus();
		return false;
	  }
	  return true;
	}
	
	//이메일 인증 폼 열기
	function win_open(page){		
		if(f.email1.value == "") {
    		alert("이메일을 입력하세요.");
    		f.email1.focus();
    		return;
    	} else if(f.email2.value == "") {
    		alert("이메일을 입력하세요.");
    		f.email2.focus();
    		return;
    	} else {
    		let email1 = document.f.email1.value;
    		let email2 = document.f.email2.value;
    		let email = email1 + "@" + email2;
    		let op = "width=500, height=300, left=50, top=150";
    	    open(page+"?email="+ email,"",op);
    	}
	}
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
	$(function() {
		$("#mem_pw").keyup(function() {
			corPwChk();
			pwChk();
		})
		$("#mem_pw2").keyup(function() {
			corPwChk();
			pwChk();
		})
		$("#email1").keyup(function() {
			$("#email1").removeClass("is-invalid");
			$("#email1").removeClass("is-valid");
			$("#authMsg").html("");
			$("#emailchkchk").val("emailunchecked");
			$("#emailBtn").show();
		})
		$("#email2").change(function() {
			$("#email1").removeClass("is-invalid");
			$("#email1").removeClass("is-valid");
			$("#authMsg").html("");
			$("#emailchkchk").val("emailunchecked");
			$("#emailBtn").show();
		})
	})

</script>
</head>
<body>
	<div class="container">
      <form action="join" method="post" name="f" onsubmit="return input_check(this)">
        <h1 id="title" style="text-align:center;">회원가입</h1>          
          <div class="container form">
            <!-- 오른쪽 아이디/비번/닉네임 입력구역-->
            <div style="margin-left:400px; margin-right:400px;">
              <!-- 이메일 -->
              <div class="form-group mb-3" style="position:relative">
                <label class="mb-1" for="email1">이메일</label><span class="text-danger">*</span>
                <div class="input-group mb-3" style="width:100%;"> 
                  <input type="text" class="form-control" name="email1" id="email1" placeholder="아이디" aria-label="Username">
                  <span class="input-group-text">@</span>
                  <select class="form-select" name="email2" id="email2">
                    <option value="naver.com">naver.com</option>
                    <option value="nate.com">nate.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="hanmail.net">hanmail.net</option>
                    <option value="daum.net">daum.net</option>
                  </select>
                  <input type="hidden" value="" name="mem_id" id="mem_id">
                  <button type="button" class="btn btn-dark" id="emailBtn" onclick="win_open('emailForm')">이메일인증</button>
                </div>               
<!--             <div class="valid-feedback" id="authMsg"></div>             -->        
                <input type="hidden" name="emailchkchk" id="emailchkchk" value="emailunchecked"> 
              </div>
              <!-- 비밀번호-->
              <div id="cor1" class="form-group mb-4">
                <label class="mb-1" for="pwd">비밀번호</label><span class="text-danger">*</span>
                  <input type="password" class="form-control" id="mem_pw" name="mem_pw" 
                    placeholder="8~16자 영대소문자/숫자 조합 특수문자 불가">
                  <div class="invalid-feedback" id="corPwMsg">
                </div>
              </div>
              <!-- 비밀번호 재입력 -->
              <div id="cor2" class="form-group mb-4">
                <label class="mb-1" for="pwd2">비밀번호 재입력</label><span class="text-danger">*</span>
                  <input type="password" class="form-control " id="mem_pw2" name="mem_pw2">
                  <div class="invalid-feedback" id="pwChkMsg">
                  </div>
              </div>
              <!-- 이름 -->
              <div id="cor3" class="form-group mt-1">
                <label class="mb-1" for="pwd2">이름</label><span class="text-danger">*</span>
                  <input type="text" class="form-control mb-4" id="mem_name" name="mem_name">
              </div>
              <!-- 전화번호 -->
              <div id="cor3" class="form-group">
                <label class="mb-1" for="pwd2">전화번호</label><span class="text-danger">*</span>
                  <input type="number" class="form-control mb-4" id="mem_phoneno" name="mem_phoneno">
              </div>
            </div>      
          </div>
      
          <!-- 회원가입 / 초기화 -->
          <div class="container mt-3" align="center">
            <button type="submit" class="btn btn-dark" id="join">회원가입</button>
            <button type="reset" class="btn btn-dark ms-2">초기화</button>
          </div>
      
        </form>
    </div>
</body>
</html>