<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	alert("${exception.message}");
	if(${exception.opener}) opener.location.reload();
	self.close();	
</script>