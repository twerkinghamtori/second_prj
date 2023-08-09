<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<style type="text/css">
	#nMsg,#pMsg{display:none; font-size : 13px;}
</style>
<script>
  function ableName() {
	  $("#mem_name").prop("readonly", false);
	  $("#nMsg").show();
	}
  
  function ablePhone(){
	  $("#mem_phoneno").prop("readonly", false);
	  $("#pMsg").show();
  }
</script>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1" style="width:50%">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 회원 상세정보</h3>
      <p class="mb-3">회원의 상세정보 및 변경을 하는 페이지 입니다.</p>

      <form action="memChg" method="post" name="f">
      <input type="hidden" name="mem_number" value="${mem.mem_number }">

        <div class="form-group">
          <label class="mb-1" for="mem_id">아이디</label>
          <div class="mb-4">
            <input name="mem_id" type="text" class="form-control" readonly value="${mem.mem_id }" required>
            <input type="hidden" value="${mem.mem_number}">
          </div>

          <div style="display:flex; justify-content: space-between;">
	          <div><label class="mb-1">이름</label></div>
	          <div><button type="button" class="btn btn-sm btn-outline-dark mb-1 text-end" onclick="ableName()">이름 변경</button></div>
          </div>
          <div class="mb-4">
            <input placeholder="이름" type="text" id="mem_name" name="mem_name" value="${mem.mem_name }" class="form-control" required readonly maxlength="10">
            <div class="mt-1" id="nMsg"><span class="text-danger">*</span> 이름을 입력하고 아래 수정 버튼을 눌러주세요.</div>
          </div>

          <div style="display:flex; justify-content: space-between;">
	          <div><label class="mb-1">연락처</label></div>
	          <div><button type="button" class="btn btn-sm btn-outline-dark mb-1 text-end" onclick="ablePhone()">연락처 변경</button></div>
          </div>
          <div class="mb-4">
            <input placeholder="연락처" type="text" name="mem_phoneno" id="mem_phoneno" value="${mem.mem_phoneno }" class="form-control" required readonly>
            <div class="mt-1" id="pMsg"><span class="text-danger">*</span> 연락처를 입력하고 아래 수정 버튼을 눌러주세요.</div>
          </div>

        </div>
        
        <div class="text-center mt-3 mb-3">
          <button type="submit" class="btn btn-dark">수정</button>
          <a class="btn btn-dark" href="memList">목록</a>
        </div>
        
        <hr>
        
        <h3 class="mb-3"><i class="fa fa-bus text-danger" aria-hidden="true"></i> ${mem.mem_name }님의 배송지 정보</h3>
        <c:if test="${!empty delList}">
	        <c:forEach var="d" items="${delList}" varStatus="st">
			      <div class="mb-3">
			      	<div class="mb-2">배송지명 : ${d.delivery_nickName }</div>
			        <div class="mb-1">
			        	<input type="text" class="form-control mb-1" readonly style="width:20%;" value="${d.delivery_postcode }">
			          <input type="text" class="form-control mb-1" readonly value="${d.delivery_address }">
			          <input type="text" class="form-control" readonly value="${d.delivery_detailAddress }">
			        </div>
			      </div>
		      </c:forEach>
	      </c:if>
	      <c:if test="${empty delList}">등록된 배송지 정보가 없습니다.</c:if>

      </form>
      <br>
      
    </div>
</body>
</html>