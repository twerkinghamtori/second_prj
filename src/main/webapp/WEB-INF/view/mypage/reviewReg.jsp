<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<style type="text/css">
.star {
  display: inline-block;
  cursor: pointer;
  font-size : 20px;
  margin : 0 10px 10px 0;
}

.star.filled {
  color: red;
}
</style>
<script>
	function input_chk(f) {
		if(f.review_value.value.trim() === "") {
			alert("별점을 선택하세요.")
			f.review_value.focus();
			return false;
		}
		if(f.review_content.value.trim() === "") {
			alert("리뷰 내용을 입력하세요.");
			f.review_content.focus();
			return false;
		}
		return true;
	} 
	
	$(()=>{
		$(".star").click(function() {
	    var value = $(this).data("value");
	    $("#review_value").val(value);
	    $(".star").removeClass("filled");
	    $(this).prevAll(".star").addBack().addClass("filled");
	  });
		
	  const maxLength = 100; // 최대 글자 수

	  $("#review_content").keyup(function() {
	    const length = $(this).val().length;
	    const remaining = maxLength - length;

	    $("#char_count").text(remaining + " / 100");

	    if (remaining < 0) {
	      $(this).val($(this).val().substring(0, maxLength));
	      $("#char_count").text("0 / 100");
	    }
	  });
	})
</script>
</head>
<body>
	<div class="container">
		<div style="display: flex; justify-content: space-between;">
			<div style="flex-basis: 20%;">
				<%@ include file="mypageSideBar2.jsp"%>
			</div>
			<div style="flex-basis: 70%; margin-left: 150px;">
					<h1 style="width:70%; padding: 5px; margin-bottom: 15px;">리뷰쓰기</h1>
					<form action="reviewReg?mem_id=${sessionScope.loginMem.mem_id }" method="POST" name="f" onsubmit="return input_chk(this)">
					<input type="hidden" name="order_itemId" id="order_itemId" value="${ov.order_itemId }">
					<div>
						<div class="form-group mb-3">
							<label class="mb-1" for="order_itemId">상품정보</label>
							<div class="input-group mb-3">
								<input type="text" class="form-control" name="product_name" id="product_name" readonly value="${ov.product_name }" >
							</div>
						</div>
						
						<div class="form-group">
							<label class="mb-1" for="review_value">별점<span class="text-danger">*</span></label>
							<div class="input-group mb-3">
							  <input type="hidden" id="review_value" name="review_value" value="">
							  <div class="star" data-value="1"><i class="fa fa-star" aria-hidden="true"></i></div>
							  <div class="star" data-value="2"><i class="fa fa-star" aria-hidden="true"></i></div> 
							  <div class="star" data-value="3"><i class="fa fa-star" aria-hidden="true"></i></div> 
							  <div class="star" data-value="4"><i class="fa fa-star" aria-hidden="true"></i></div> 
							  <div class="star" data-value="5"><i class="fa fa-star" aria-hidden="true"></i></div> 
							</div>
						</div>
						
						<div class="form-group">
							<label class="mb-1" for="review_content">리뷰내용<span class="text-danger">*</span></label>
							<div class="input-group ">
							  <textarea rows="7" class="form-control" name="review_content" id="review_content">${review.review_content }</textarea>
							</div>
							<div  class="mb-3" style="color:grey" id="char_count"></div>
						</div>
						<button class="btn btn-danger" type="submit" id="reviewReg">리뷰등록</button>		
					</div>
					</form>
			</div>
		</div>
	</div>
</body>
</html>