<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	alert("${exception.message}");	
	opener.location.href="${exception.url}";
	self.close();
</script>