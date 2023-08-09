<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${emptyChk=='emptyChk' }">
		<input type="hidden" name="corpwchk" id="corpwchk" value="pwunchecked">
		<script type="text/javascript">
			pass = document.querySelector("#mem_pw");
			pass.classList.remove("is-invalid");
			pass.classList.remove("is-valid");
			corPwMsg = document.querySelector("#corPwMsg");
			corPwMsg.classList.remove("invalid-feedback");
			corPwMsg.classList.remove("valid-feedback");
		</script>
	</c:when>
	<c:when test="${b }">
		유효한 비밀번호 입니다.
		<input type="hidden" name="corpwchk" id="corpwchk" value="pwchecked"> 
		<script type="text/javascript">
			pass = document.querySelector("#mem_pw");
			pass.classList.remove("is-invalid");
			pass.classList.add("is-valid");
			corPwMsg = document.querySelector("#corPwMsg");
			corPwMsg.classList.remove("invalid-feedback");
			corPwMsg.classList.add("valid-feedback");
		</script>
	</c:when>
	<c:otherwise>
		유효하지 않은 비밀번호입니다.
		<input type="hidden" name="corpwchk" id="corpwchk" value="pwunchecked">  
		<script type="text/javascript">
			pass = document.querySelector("#mem_pw");
			pass.classList.remove("is-valid")
			pass.classList.add("is-invalid");
			corPwMsg = document.querySelector("#corPwMsg");
			corPwMsg.classList.remove("valid-feedback");
			corPwMsg.classList.add("invalid-feedback");
		</script>
	</c:otherwise>
</c:choose>
