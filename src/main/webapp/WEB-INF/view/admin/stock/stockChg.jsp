<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<script>
  function inputChk(f) {
	  if($.trim(f.stock_quantity.value) == "") {
		    alert("입고 수량을 입력하세요.");
		    f.stock_quantity.focus();
		    return false;
		  }
	  
	  const isQuantityValid = $("#isQuantityValid").val();
	  if(!(isQuantityValid == '1')){
		  alert("수량이 유효하지 않습니다.");
			return false;
	  }
	  return true;
	}
  
  function validQuantity() {
	    let input = $("#quantity").val();
	    var pattern = /^[0-9]+$/; // 숫자만 허용하는 정규식 패턴
	    var codeMsg = $("#quantityMsg");
	    
	    if (pattern.test(input)) {
	      $("#quantity").removeClass("is-invalid").addClass("is-valid");
	      codeMsg.css("color", "green").text("올바른 입력입니다.");
	      $("#isQuantityValid").val("1");
	    } else {
	      $("#quantity").removeClass("is-valid").addClass("is-invalid");
	      codeMsg.css("color", "red").text("숫자만 입력해주세요.");
	      $("#isQuantityValid").val("0");
	    }
	  }
</script>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1" style="width:60%">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 재고 등록 내역 수정</h3>
      <p class="mb-3">재고 등록 내역을 수정하는 페이지 입니다.</p>
      <form action="stockChg" method="post" name="f" onsubmit="return inputChk(this)">
      	<input type="hidden" value="${stock.stock_number }" name="stock_number">
      	<input type="hidden" value="${stock.opt_number }" name="opt_number">
        <table class="table align-middle">
          <tr class="text-center">
            <td width="25%" class="table-danger text-center">제품명(옵션)</td>
            <td>${stock.stock_prodName }</td>
          </tr>
          <tr>
          	<td class="table-danger text-center">제품 이미지</td>
            <td class="text-center"><img src="${path }/img/thumb/${stock.stock_prodThumb }" width="200" height="130"></td>
          </tr>
          <tr>
            <td class="table-danger text-center">수량</td>
            <td>
            	<input type="text" name="stock_quantity" id="quantity" class="form-control" onkeyup="validQuantity()" value="${stock.stock_quantity }">
              <span class="mt-1" id="quantityMsg">&nbsp;</span>
              <input type="hidden" name="curQuantity" value="${stock.stock_quantity }">
              <input type="hidden" value="1" id="isQuantityValid">  
            </td>
          </tr>
        </table>

        <div class="text-center">
          <button type="submit" class="btn btn-dark">수정</button>
          <a href="stockList" class="btn btn-dark">목록</a>
        </div>
      </form>
      <br>
    </div>
</body>
</html>