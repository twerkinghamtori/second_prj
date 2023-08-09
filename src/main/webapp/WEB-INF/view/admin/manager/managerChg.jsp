<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<script>
  function inputChk(f) {
    const isValidBirth = $("#isValidBirth").val();
    const isEqualPass = $("#isEqualPass").val();

    if (isValidBirth === "1" && isEqualPass === "1") {
      return true;
    } else {
      alert("유효하지 않은 입력란들이 있습니다.");
      return false;
    }
  }
  
  function passCheck() {
    const manager_pass1 = $("#manager_pass1").val();
    const manager_pass2 = $("#manager_pass2").val();

    if (manager_pass1 !== manager_pass2) {
      $("#passEqualMsg").html("비밀번호가 일치하지 않습니다.");
      $("#passEqualMsg").css("color", "red");
      $("#manager_pass").val("");
      $("#isEqualPass").val("0");

      $("#manager_pass1").addClass("is-invalid");
      $("#manager_pass2").addClass("is-invalid");
      $("#manager_pass1").removeClass("is-valid");
      $("#manager_pass2").removeClass("is-valid");

      if(!(manager_pass1 && manager_pass2)){
        $("#passEqualMsg").html("");
        $("#manager_pass1").removeClass("is-valid");
        $("#manager_pass2").removeClass("is-valid");
        $("#manager_pass1").removeClass("is-invalid");
        $("#manager_pass2").removeClass("is-invalid");
      }
    } else {
      $("#passEqualMsg").html("비밀번호가 일치합니다.");
      $("#passEqualMsg").css("color", "green");
      $("#manager_pass").val(manager_pass1);
      $("#isEqualPass").val("1");


      $("#manager_pass1").addClass("is-valid");
      $("#manager_pass2").addClass("is-valid");
      $("#manager_pass1").removeClass("is-invalid");
      $("#manager_pass2").removeClass("is-invalid");

      if(!(manager_pass1 && manager_pass2)){
        $("#passEqualMsg").html("");
        $("#manager_pass1").removeClass("is-valid");
        $("#manager_pass2").removeClass("is-valid");
        $("#manager_pass1").removeClass("is-invalid");
        $("#manager_pass2").removeClass("is-invalid");
      }
    }
  }
  function validateBirth() {
    const birthValue = $("#manager_birth").val();
    const regex = /^[0-9]{6}$/; // 6자리 숫자 정규식

    if (regex.test(birthValue)) {
      $("#BirthValidMsg").html("");
      $("#BirthValidMsg").removeClass("text-danger");
      $("#BirthValidMsg").addClass("text-success");
      $("#isValidBirth").val("1");

      $("#manager_birth").addClass("is-valid");
      $("#manager_birth").removeClass("is-invalid");
    } else {
      $("#BirthValidMsg").html("생년월일은 6자리 숫자로 입력해야 합니다.");
      $("#BirthValidMsg").removeClass("text-success");
      $("#BirthValidMsg").addClass("text-danger");
      $("#isValidBirth").val("0");

      $("#manager_birth").addClass("is-invalid");
      $("#manager_birth").removeClass("is-valid");
    }
  }
  
  function ablePass() {
	  $("#manager_pass1").prop("disabled", false);
	  $("#manager_pass2").prop("disabled", false);
	  $("#passMsg").show();
	}
</script>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1" style="width:50%">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 매니저 정보수정</h3>
      <p class="mb-3">매니저의 정보를 수정하는 페이지 입니다.</p>

      <form action="managerChg" method="post" name="f" onsubmit="return inputChk(this)">
      <input type="hidden" name="manager_number" value="${manager.manager_number }">

        <div class="form-group">
          <label class="mb-1" for="manager_id">아이디</label>
          <div class="mb-4">
            <input name="manager_id" id="manager_id" type="text" class="form-control" readonly value="${manager.manager_id }">
          </div>
					
					<div style="display:flex; justify-content: space-between;">
	          <div><label class="mb-1" for="manager_pass">비밀번호</label></div>
	          <div><button class="btn btn-sm btn-outline-dark mb-1 text-end" onclick="ablePass()">비밀번호 변경</button></div>
          </div>
          <div class="mb-4">
            <input placeholder="비밀번호" id="manager_pass1" type="password" class="form-control" onkeyup="passCheck()" required  disabled>
            <input placeholder="비밀번호 재입력" id="manager_pass2" type="password" onkeyup="passCheck()" class="form-control mt-1" disabled>
            <input type="hidden" name="manager_pass" id="manager_pass" value="${manager.manager_pass}">
            <input type="hidden" id="isEqualPass" value="1">
            <span id="passEqualMsg"></span>
            <div class="mt-1" id="passMsg" style="display:none;font-size : 13px;"><span class="text-danger">*</span> 비밀번호를 입력하고 아래 수정 버튼을 눌러주세요.</div>
          </div>

          <label class="mb-1" for="manager_name">이름</label>
          <div class="mb-4">
            <input placeholder="이름" type="text" name="manager_name" class="form-control" required value="${manager.manager_name}" maxlength="10">
          </div>

          <label class="mb-1" for="manager_birth">생년월일</label>
          <div class="mb-4">
            <input placeholder="생년월일(ex_990101)" type="text" name="manager_birth" id="manager_birth" class="form-control" value="${manager.manager_birth}" required maxlength="6" onkeyup="validateBirth()">
            <input type="hidden" id="isValidBirth" value="1">
            <span id="BirthValidMsg"></span>
          </div>

          <label class="mb-1">권한</label>
          <div style="display: flex; align-items: center;">
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="manager_grant" id="inlineRadio2" value="일반" ${manager.manager_grant eq '일반'? 'checked' : ''}>
              <label class="form-check-label" for="inlineRadio2">일반</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="manager_grant" id="inlineRadio1" value="총괄" ${manager.manager_grant eq '총괄'? 'checked' : ''}>
              <label class="form-check-label" for="inlineRadio1">총괄</label>
            </div>
          </div>
        </div>
		
        <div class="text-center mt-3">
          <button type="submit" class="btn btn-dark">수정</button>
          <a class="btn btn-dark" href="managerList">목록</a>
        </div>

      </form>
      <br>
    </div>
</body>
</html>