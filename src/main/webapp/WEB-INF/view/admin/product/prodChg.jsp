<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<script>
  $(()=>{
    $('input[name="product_isDiscount"]').change(function() {
      var isDiscount = $(this).val();
      if (isDiscount === "1") {
        $('#discount').prop('disabled', false);
        $('#isDiscountValid').val("1");
      } else {
        $('#discount').prop('disabled', true);
        $('#isDiscountValid').val("0");
        $("#discount").val("");
        $("#discount").removeClass("is-valid").removeClass("is-invalid");
        $("#discountMsg").text("");
      }
    });

    // 이미지 파일 선택 시 미리보기
    $("#productThumbInput").change(function() {
      var file = this.files[0];
      var reader = new FileReader();
      reader.onload = function(e) {
        $("#thumbPreview").attr("src", e.target.result).show();
      };
      reader.readAsDataURL(file);
      
      // 유효성 체크
      const allowedTypes = ["image/jpeg", "image/png", "image/gif"];
      if (allowedTypes.indexOf(file.type) == -1) {
        $("#isPicValid").val("0");
        $("#thumbError").text("이미지 파일만 첨부할 수 있습니다.").show();
        $("#thumbPreview").attr("src", "");
      } else {
        $("#isPicValid").val("1");
        $("#thumbError").text("").hide();
      }
    });
    
    $('#pics').on('change', function() {
      const fileList = Array.from(this.files); // 선택된 파일 리스트 가져오기
      var fileNames = fileList.map(function(file) {
        return file.name; // 파일명 추출
      });
      var joinedNames = fileNames.join(', '); // 파일명 콤마로 구분하여 연결

      $('#picMsg').text('변경 예정 : ' + joinedNames);
    });
  })
  function validPrice() {
    var input = $("#price").val();
    var pattern = /^[0-9]+$/; // 숫자만 허용하는 정규식 패턴
    var codeMsg = $("#priceMsg");
    
    if (pattern.test(input)) {
      $("#price").removeClass("is-invalid").addClass("is-valid");
      $("#isPriceValid").val("1");
      codeMsg.css("color", "green").text("올바른 입력입니다.");
    } else {
      $("#price").removeClass("is-valid").addClass("is-invalid");
      codeMsg.css("color", "red").text("숫자만 입력해주세요!");
      $("#isPriceValid").val("0");
    }
  }
  function validDiscount() {
    var input = $("#discount").val();
    var pattern = /^[1-9][0-9]?$/;
    var codeMsg = $("#discountMsg");

    if (pattern.test(input)) {
      $("#discount").removeClass("is-invalid").addClass("is-valid");
      $("#isDiscountValid").val("1");
      codeMsg.css("color", "green").text("올바른 입력입니다.");
    } else {
      $("#discount").removeClass("is-valid").addClass("is-invalid");
      codeMsg.css("color", "red").text("1~99 숫자만 입력해주세요.");
      $("#isDiscountValid").val("0");
    }
  }

  function inputChk(f) {
	  if($.trim(f.product_name.value) == "") {
	    alert("제품명을 입력하세요.");
	    f.product_name.focus();
	    return false;
	  }

	  if($.trim(f.product_price.value) == "") {
	    alert("가격을 입력하세요.");
	    f.product_price.focus();
	    return false;
	  }

	  if($.trim(CKEDITOR.instances.desc.getData()) == "") {
	    alert("내용을 입력하세요.");
	    CKEDITOR.instances.desc.focus();
	    return false;
	  }

	  const isPriceValid = $("#isPriceValid").val();
	  if(!(isPriceValid == '1')){
		  alert("가격이 유효하지 않습니다.");
			return false;
	  }
	  
    const isPicValid = $("#isPicValid").val();
    if(!(isPicValid == '1')){
		  alert("썸네일 사진을 등록하세요.");
			return false;
	  }

	  return true;
	}
</script>
</head>
<body>
<br><br>
    <div class="container w3-white pt-1">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 제품 수정</h3>
      <p class="mb-3">제품을 수정하는 페이지 입니다.</p>
      <form:form modelAttribute="product" action="prodChg" method="post" name="f" onsubmit="return inputChk(this)" enctype="multipart/form-data">
      	<input type="hidden" name="product_number" value="${product.product_number }">
        <table class="table align-middle">
          <tr>
            <td width="15%" class="table-secondary text-center">제품명</td>
            <td width="35%"><input type="text" name="product_name" class="form-control" value='${product.product_name }' placeholder="제품명을 입력하세요."></td>
            <td width="15%" class="table-secondary text-center">카테고리</td>
            <td width="35%">
              <select class="form-select" name="product_type">
                <option value="1" ${product.product_type eq '1'? 'selected' : ''}>카테고리1</option>
                <option value="2" ${product.product_type eq '2'? 'selected' : ''}>카테고리2</option>
                <option value="3" ${product.product_type eq '3'? 'selected' : ''}>카테고리3</option>
                <option value="4" ${product.product_type eq '4'? 'selected' : ''}>카테고리3</option>
              </select>
            </td>
          </tr>
          <tr>
            <td class="table-secondary text-center">가격</td>
            <td colspan="3">
              <input type="number" id="price" onkeyup="validPrice()" value="${product.product_price }" name="product_price" class="form-control" placeholder="가격을 입력하세요."><span class="mt-1" id="priceMsg">&nbsp;</span>
              <input type="hidden" value="1" id="isPriceValid">
              <br>
              <div style="display: flex; align-items: center;">
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="product_isDiscount" id="inlineRadio2" value="0" ${product.product_isDiscount eq 0? 'checked' : '' }>
                  <label class="form-check-label" for="inlineRadio2">할인 적용 안함</label>
                </div>
                <div class="form-check form-check-inline">
                  <input class="form-check-input" type="radio" name="product_isDiscount" id="inlineRadio1" value="1" ${product.product_isDiscount eq 1? 'checked' : '' }>
                  <label class="form-check-label" for="inlineRadio1">할인 적용</label>
                </div>
                <div>
                  <input type="number" id="discount" onkeyup="validDiscount()" name="product_discountRate" class="form-control" ${product.product_isDiscount eq 0? 'disabled' : '' } value="${product.product_discountRate}" placeholder="할인율">
                  <input type="hidden" value="1" id="isDiscountValid">
                </div>
                <div><span class="ms-3" id="discountMsg">&nbsp;</span></div>
              </div>
            </td>
          </tr>
          <tr>
            <td class="table-secondary text-center">제품 설명</td>
            <td colspan="3">
              <textarea rows="15" name="product_desc" class="form-control" id="desc">${product.product_desc}</textarea>
            </td>
            <script>
              CKEDITOR.editorConfig = function( config ) {
                config.htmlFilter = CKEDITOR.filter.disallowAll();
              };
              CKEDITOR.replace("product_desc",{
                filebrowserImageUploadUrl : "imgupload",
                toolbar: [
                  { name: 'document', items: [ 'Source','-','Save','NewPage','Preview','-','Templates' ] },
                  { name: 'clipboard', items: [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
                  { name: 'insert', items: [ 'Image','Table','HorizontalRule','SpecialChar' ] },
                  '/',
                  { name: 'styles', items: [ 'Styles','Format','Font','FontSize' ] },
                  { name: 'basicstyles', items: [ 'Bold','Italic','Strike','-','RemoveFormat' ] }
                ],
                skin: 'moono',
                language: 'ko',
                height: 300,
                resize_enabled: false
              });
            </script>
          </tr>
          <tr>
            <td class="table-secondary text-center">제품 썸네일</td>
            <td colspan="3">
              <input class="form-control mb-3" type="file" name="thumbFile" id="productThumbInput">
              <input type="hidden" name="product_thumb" value="${product.product_thumb}">
              <img id="thumbPreview" src="${path }/img/thumb/${product.product_thumb }" style="max-width: 300px;">
              <input type="hidden" id="isPicValid" value="1">
              <span id="thumbError" class="text-danger">&nbsp;</span>
            </td>
          </tr>
          <tr>
            <td class="table-secondary text-center">제품 사진</td>
            <td colspan="3" >
              <input class="form-control" id="pics" type="file" name="picFiles[]" multiple>
              <input type="hidden" name="product_pictures" value="${product.product_pictures}">
              <span id="picMsg" class="text-primary mt-1">현재 등록되어 있는 사진 : ${product.product_pictures}</span>
            </td>
          </tr>
        </table>

        <div class="text-center">
          <button type="submit" class="btn btn-dark">수정</button>
          <a href="prodList" class="btn btn-dark">목록</a>
        </div>
      </form:form>
      <br>
    </div>
</body>
</html>