<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${emptyChk=='emptyChk' }">
		<input type="hidden" name="pwchkchk" id="pwchkchk" value="pwunchecked">
		<script type="text/javascript">
			pass2 = document.querySelector("#mem_pw2");
			pass2.classList.remove("is-invalid");
			pass2.classList.remove("is-valid");
			pwChkMsg = document.querySelector("#pwChkMsg");
			pwChkMsg.classList.remove("invalid-feedback");
			pwChkMsg.classList.remove("valid-feedback");
		</script>
	</c:when>
	<c:when test="${b }">
		<span>비밀번호가 일치합니다.</span>
		<input type="hidden" name="pwchkchk" id="pwchkchk" value="pwchecked"> 
		<script type="text/javascript">
			pass2 = document.querySelector("#mem_pw2");
			pass2.classList.remove("is-invalid");
			pass2.classList.add("is-valid");
			pwChkMsg = document.querySelector("#pwChkMsg");
			pwChkMsg.classList.remove("invalid-feedback");
			pwChkMsg.classList.add("valid-feedback");
		</script>   
	</c:when>	
	<c:otherwise>
		<span>비밀번호가 일치하지 않습니다.</span>
		<input type="hidden" name="pwchkchk" id="pwchkchk" value="pwunchecked"> 
		<script type="text/javascript">
			pass2 = document.querySelector("#mem_pw2");
			pass2.classList.remove("is-valid");
			pass2.classList.add("is-invalid");
			pwChkMsg = document.querySelector("#pwChkMsg");
			pwChkMsg.classList.remove("valid-feedback");
			pwChkMsg.classList.add("invalid-feedback");
		</script> 
	</c:otherwise>
</c:choose>
