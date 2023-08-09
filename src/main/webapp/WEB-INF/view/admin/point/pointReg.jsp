<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<style type="text/css">
	.navy, .btn-outline-custom-navy:hover {
		background-color: navy !important;
		color : white;
	}
/*	.btn-outline-custom-navy {
	  color: navy;
	  background-color: navy !important;
	}
	
	.active-navy{
		color: white;
	  background-color: navy !important;
	}
*/
</style>
<script>
  function inputChk(f) {
    if($.trim(f.point_value.value) == "") {
	    alert("지급 포인트를 입력하세요.");
	    f.point_value.focus();
	    return false;
	  }

	  const isPointValid = $("#isPointValid").val();
	  if(!(isPointValid == '1')){
		  alert("포인트값이 유효하지 않습니다.");
			return false;
	  }

	  return true;
	}

  function validPoint() {
    var input = $("#point").val();
    var pattern = /^[0-9]+$/; // 숫자만 허용하는 정규식 패턴
    var codeMsg = $("#pointMsg");
    
    if (pattern.test(input)) {
      $("#point").removeClass("is-invalid").addClass("is-valid");
      codeMsg.css("color", "green").text("올바른 입력입니다.");
      $("#isPointValid").val("1");
    } else {
      $("#point").removeClass("is-valid").addClass("is-invalid");
      codeMsg.css("color", "red").text("숫자만 입력해주세요.");
      $("#isPointValid").val("0");
    }
  }
</script>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1" style="width:50%;">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 포인트 지급</h3>
      <p class="mb-3">포인트를 지급하는 페이지 입니다.</p>
      <form action="pointReg" method="post" name="f" onsubmit="return inputChk(this)">
      	<input type="hidden" value="${mem.mem_id }" name="mem_id">
      	<input type="hidden" value="${mem.mem_number }" name="mem_number">
        <table class="table align-middle">
          <tr class="text-center">
            <td class="navy text-center" width="30%">사용자 아이디</td>
            <td>${mem.mem_id }</td>
          </tr>
          <tr>
          	<td class="navy text-center">사용자 포인트</td>
            <td class="text-center"><fmt:formatNumber value="${mem.mem_point }" pattern="#,###"/>P</td>
          </tr>
          <tr>
          	<td class="navy text-center">지급 포인트(P)<span class="text-danger">*</span></td>
            <td>
              <input type="number" name="point_value" id="point" class="form-control" onkeyup="validPoint()" placeholder="지급 포인트를 입력하세요.">
              <span class="mt-1" id="pointMsg">&nbsp;</span>
              <input type="hidden" value="0" id="isPointValid">
            </td>
          </tr>
          <tr>
          	<td class="navy text-center">지급 사유<span class="text-danger">*</span></td>
          	<td><input type="text" name="point_type" class="form-control" required="required"></td>
          </tr>
        </table>

        <div class="text-center">
          <button type="submit" class="btn btn-dark">지급</button>
          <a href="pointList" class="btn btn-dark">목록</a>
        </div>
      </form>
      <br>
    </div>
</body>
</html>