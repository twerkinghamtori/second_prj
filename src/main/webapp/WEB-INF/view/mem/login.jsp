<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<style type="text/css">
	.btn.px-0.fw-bold:hover{
		color : rgba(0,0,0,0.3);
	}
	p.mb-2{
		color : rgba(0,0,0,0.5);
		font-size : 14px;
	}
	#loginBtn{
		border-radius: 2em;
		
	}
	
	.logingLogo{
		width:50px;
		height:50px;
		border-radius: 50%;
		margin: 8px;
		box-shadow: 0px 3px 6px 0 rgba(0,0,0,0.3);
	}
</style>
<script type="text/javascript">
	function input_check(f) {
		if (f.mem_id.value.trim() === "") {
			alert("아이디를 입력하세요")
			f.mem_id.focus();
			return false;
		}
		if (f.mem_pw.value.trim() === "") {
			alert("비밀번호를 입력하세요")
			f.mem_pw.focus();
			return false;
		}
		return true;
	}
	//이메일 저장.
	$(function() { //아이디저장 
			let key = getCookie("key");
			$("#mem_id").val(key);
			
			if($("#mem_id").val() != "") {
				$("#rememberId").attr("checked",true);
			}
			
			$("#rememberId").change(function() { //체크박스 변동
				if($("#rememberId").is(":checked")) {
					setCookie("key", $("#mem_id").val(), 7) 
				} else {
					deleteCookie("key")
				}
			})
			
			$("#mem_id").keyup(function() { //
				if($("#rememberId").is(":checked")) {
					setCookie("key", $("#mem_id").val(), 7)
				}
			})
		})
		
		//쿠키값 set
		function setCookie(cookieName, value, exdays){
		    let exdate = new Date();
		    exdate.setDate(exdate.getDate() + exdays);
		    let cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		    document.cookie = cookieName + "=" + cookieValue;
		} //escape : 16진수로 변환. 쿠키문자열과 충돌 방지 / unescape : 다시 원래 문자로

		//쿠키값 delete
		function deleteCookie(cookieName){
		    let expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() -1);
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}

		//쿠키값 get
		function getCookie(cookieName){
		    cookieName = cookieName + "=";
		    let cookieData = document.cookie;
		    let start = cookieData.indexOf(cookieName);
		    let cookieValue = '';
		    if(start != -1){
		        start += cookieName.length;
		        let end = cookieData.indexOf(';', start);
		        if(end == -1)end = cookieData.length;
		        cookieValue = cookieData.substring(start, end);
		    }
		    return unescape(cookieValue); //unescape로 디코딩 후 값 리턴
		}
		function win_open(page){		
	    	let op = "width=500, height=450, left=50, top=150";
	    	open(page,"",op);
	  	}
</script>
</head>
<body>
	<div class="container">
      <form action="login" name="f" method="post" onsubmit="return input_check(this)">
        <h1 class="mb-5" style="text-align:center;">로그인</h1>
    
        <div class="container">
          <div style="margin-left:450px; margin-right:450px;">
          <div class="form-group">
            <label class="mb-1" for="usr">이메일</label><input placeholder="이메일" type="text" class="form-control mb-4" id="mem_id" name="mem_id">
            <label class="mb-1" for="pwd">비밀번호</label><input placeholder="비밀번호" type="password" class="form-control mb-3" id="mem_pw" name="mem_pw">
            <div class="mb-3"><input class="form-check-input" type="checkbox" id="rememberId" name="rememberId"> 이메일 저장</div>
          </div>
          
          <div>
            <button id="loginBtn"type="submit" class="btn btn-dark w-100 mb-3">로그인</button>
            
            <p class="mb-2" style="display: inline-block;">회원이 아니신가요?</p>&nbsp;&nbsp;&nbsp;
            <button type="button" class="btn px-0 fw-bold" onclick="location.href='join'">회원가입</button>
            
            <div class="text-center mb-3">
	            <a href="${apiURL }"><img alt="네이버로 시작하기" src="${path}/images/naver.png" class="logingLogo"></a>
	            <a href="${kakaoApiURL }"><img alt="카카오로 시작하기" src="${path}/images/kakao.png" class="logingLogo"></a>
	            <a href="${googleApiURL }"><img alt="구글로 시작하기" src="${path}/images/google.png" class="logingLogo"></a>
            </div>
            <p class="mb-2">비밀번호를 찾으실려면 아래 버튼을 눌러주세요.</p>
            <button type="button" class="btn  px-0 fw-bold" onclick="win_open('emailForm2')">비밀번호 찾기</button>
        <input type="hidden" name="emailchkchk" value="emailunchecked">
          </div>
        </div>  
        </div>
        
      </form>
    </div>
</body>
</html>