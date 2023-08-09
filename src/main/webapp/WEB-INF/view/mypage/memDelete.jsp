<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<script>
	function input_chk(f) {
		if(f.mem_pw.value.trim() == "") {
			alert("비밀번호를 입력하세요.")
			mem_pw.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div class="container">
		<div style="display: flex; justify-content: space-between;">
			<div style="flex-basis: 30%;">
				<%@ include file="mypageSideBar2.jsp"%>
			</div>
			<div style="flex-basis: 70%; margin-left: 150px;">
					<h1 style="width:70%; padding: 5px; margin-bottom: 15px;">회원 탈퇴</h1>
					<form action="memDelete" method="POST" name="f" onsubmit="return input_chk(this)">
					<input type="hidden" name="mem_id" value="${param.mem_id }">
					<div>						
						<div class="form-group">
							<label class="mb-1" for="mem_pw">비밀번호</label>
							<div class="input-group mb-3">
								<input type="text" class="form-control" name="mem_pw" id="mem_pw" placeholder="비밀번호를 입력하세요.">
							</div>
						</div>
						<button type="button" class="btn btn-danger" style="margin-left:150px;" data-bs-toggle="modal" data-bs-target="#staticBackdrop">탈퇴 하기</button>
					</div>
					<!-- Modal -->
               <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                 <div class="modal-dialog">
                   <div class="modal-content">
                     <div class="modal-header">
                       <h5 class="modal-title" id="staticBackdropLabel">회원 탈퇴</h5>
                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                     </div>
                     <div class="modal-body">
                       탈퇴 시 모든 회원 데이터 및 포인트가 삭제됩니다. 정말 탈퇴하시겠습니까?
                     </div>
                     <div class="modal-footer">
                       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                       <button type="submit" class="btn btn-danger">탈퇴</button>
                     </div>
                   </div>
                 </div>
               </div>
					</form>
					<br>
			</div>
		</div>
	</div>
</body>
</html>