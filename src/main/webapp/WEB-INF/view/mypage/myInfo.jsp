<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<style type="text/css">
#nMsg, #pMsg {
	display: none;
	font-size: 13px;
}
</style>
<script>
	function ableName() {
		$("#mem_name").prop("readonly", false);
		$("#nMsg").show();
	}

	function ablePhone() {
		$("#mem_phoneno").prop("readonly", false);
		$("#pMsg").show();
	}
</script>
</head>
<body>
	<div class="container">
		<div style="display: flex;">
			<div style="flex-basis: 30%;">
				<%@ include file="mypageSideBar2.jsp"%>
			</div>
			<div style="flex-basis: 70%;">
				<h1 style="padding: 5px; margin-bottom: 15px;">회원
					정보</h1>

				<form action="myInfoUpdate" method="post" name="f">
				<input type="hidden" value="${mem.mem_id }" name="mem_id">
					<div class="form-group w-50" >
						<label class="mb-1" for="email">이메일</label>
						<div class="mb-3" style="display: flex;">
							<c:set var="email" value="${mem.mem_id }" />
							<c:set var="split" value="@" />
							<input style="display:inline-block;" type="text" class="form-control" id="email1" name="email1" readonly value="${fn:substringBefore(email,split) }"> 
							<span style="display:inline-block;" class="input-group-text">@</span> 
							<input style="display:inline-block;" type="text"class="form-control" id="email2" name="email2" readonly value="${fn:substringAfter(email,split) }"> 
							<input type="hidden" value="${mem.mem_number}">
						</div>

						<div style="display: flex; justify-content: space-between;">
							<div>
								<label class="mb-1">이름</label>
							</div>
							<div>
								<button type="button"
									class="btn btn-sm btn-outline-dark mb-1 text-end"
									onclick="ableName()">이름 변경</button>
							</div>
						</div>
						<div class="mb-4">
							<input placeholder="이름" type="text" id="mem_name" name="mem_name"
								value="${mem.mem_name }" class="form-control" required readonly
								maxlength="10">
							<div class="mt-1" id="nMsg">
								<span class="text-danger">*</span> 이름을 입력하고 아래 수정 버튼을 눌러주세요.
							</div>
						</div>

						<div style="display: flex; justify-content: space-between;">
							<div>
								<label class="mb-1">연락처</label>
							</div>
							<div>
								<button type="button"
									class="btn btn-sm btn-outline-dark mb-1 text-end"
									onclick="ablePhone()">연락처 변경</button>
							</div>
						</div>
						<div class="mb-4">
							<input placeholder="연락처" type="number" name="mem_phoneno"
								id="mem_phoneno" value="${mem.mem_phoneno }"
								class="form-control" required readonly>
							<div class="mt-1" id="pMsg">
								<span class="text-danger">*</span> 연락처를 입력하고 아래 수정 버튼을 눌러주세요.
							</div>
						</div>

						<div class="mb-4">
							<label class="mb-1" for="nickname">보유 포인트</label>
							<div class="mb-3">
								<input type="text" class="form-control" name="point" id="point"
									readonly value="${mem.mem_point }">
							</div>
						</div>

					</div>

					<div class="text-center mt-3 mb-3 w-50">
						<button type="submit" class="btn btn-danger">수정</button>
					</div>

				</form>


			</div>
		</div>
		</div>
</body>
</html>