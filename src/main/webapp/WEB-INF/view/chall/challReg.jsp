<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<script>
  $(()=>{
    // 이미지 파일 선택 시 미리보기
    $("#challThumbInput").change(function() {
      var file = this.files[0];
      var reader = new FileReader();
      reader.onload = function(e) {
        $("#thumbPreview").attr("src", e.target.result).show();
      };
      reader.readAsDataURL(file);
      
      // 유효성 체크
      var allowedTypes = ["image/jpeg", "image/png", "image/gif"];
      if (allowedTypes.indexOf(file.type) == -1) {
        $("#isPicValid").val("0");
        $("#thumbError").text("이미지 파일만 첨부할 수 있습니다.").show();
        $("#thumbPreview").attr("src", "");
      } else {
        $("#isPicValid").val("1");
        $("#thumbError").text("").hide();
      }
    });
  })
	
  function inputChk(f) {
    const isPicValid = $("#isPicValid").val();
    if(!(isPicValid == '1')){
		  alert("사진을 등록하세요.");
			return false;
	  }

	  return true;
	}
</script>
</head>
<body>
  <div class="container pt-1" style="width:60%">
    <h3><i class="fa fa-caret-square-o-right text-danger" aria-hidden="true"></i> 오운완 챌린지</h3>
    <p class="mb-3 text-danger">※ 1일 1회만 참여 가능합니다.</p>
    <form action="challReg" method="post" name="f" enctype="multipart/form-data" onsubmit="return inputChk(this)">
    	<input type="hidden" name="mem_id" value="${sessionScope.loginMem.mem_id }">
      <table class="table align-middle">
        <tr>
        	<td class="table-secondary text-center">참여자 이름<span class="text-danger">*</span></td>
        	<td><input class="form-control" readonly required name="mem_name" value="${sessionScope.loginMem.mem_name }"></td>
        </tr>
        <tr>
          <td class="table-secondary text-center">이미지<span class="text-danger">*</span></td>
          <td colspan="3">
            <input class="form-control mb-3" type="file" name="thumbFile" id="challThumbInput" required>
            <img id="thumbPreview" src="" style="max-width: 300px; display: none;">
            <input type="hidden" id="isPicValid" value="0">
            <span id="thumbError" class="text-danger">&nbsp;</span>
          </td>
        </tr>
      </table>

      <div class="text-center">
        <button type="submit" class="btn btn-danger">등록</button>
        <a href="challList" class="btn btn-danger">목록</a>
      </div>
    </form>
    <br>
  </div>
</body>
</html>