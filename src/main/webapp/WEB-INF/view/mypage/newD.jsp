<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@600&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	body,h1,h2,h3,h4,h5,p,a {
    font-family: 'IBM Plex Sans KR', sans-serif !important;
 }
    .container{margin: 30px auto; padding: 0 50px;}
    h2{margin-bottom: 30px;}
  </style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function() {
		$("#searchPostcode").click(function() {
	  		sample6_execDaumPostcode();
		})
	})
	
	
	function input_check(f) {
		if (f.delivery_nickName.value.trim() == "") {
			alert("배송지 별명을 입력하세요.")
			f.delivery_nickName.focus();
			return false;
		}
		if (f.delivery_receiver.value.trim() == "") {
			alert("받으실 분을 입력하세요")
			f.delivery_receiver.focus();
			return false;
		}
		if (f.delivery_postcode.value.trim() == "") {
			alert("주소를 입력하세요")
			f.delivery_postcode.focus();
			return false;
		}
		if (f.delivery_address.value.trim() == "") {
			alert("주소를 입력하세요")
			f.delivery_address.focus();
			return false;
		}
		if (f.delivery_detailAddress.value.trim() == "") {
			alert("상세주소를 입력하세요")
			f.delivery_detailAddress.focus();
			return false;
		}
		if(f.delivery_phoneNo.value.trim() == "" ){
		    alert("전화번호를 입력하세요")
		    f.delivery_phoneNo.focus();
		    return false;
	  	}
		if(f.delivery_phoneNo.value.trim() == "" ){
		    alert("전화번호를 입력하세요")
		    f.delivery_phoneNo.focus();
		    return false;
	  	}
		var regex = /^\d+$/;
  	  	if(!regex.test(f.delivery_phoneNo.value.trim())){
		    alert("유효하지 않은 전화번호 입니다. 전화번호는 숫자만 입력해주세요.")
		    f.delivery_phoneNo.focus();
		    return false;
	  	  }
		return true;
	}

	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}

						} else {
							//                  document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}
</script>
</head>
<body>
	<div class="container">
		<h2 class="mb-3">배송지 추가</h2>
	<form action="deliveryList" method="POST" name="f" onsubmit="return input_check(this)">
		<div class="form-group" id="existingAddressContainer"
			style="display: none;"></div>
		<div id="nickName">
			<label for="name" class="form-label mb-0">배송지 별명</label><span class="text-danger">*</span>
			<input type="text" class="form-control" id="delivery_nickName" name="delivery_nickName">
		</div>
		<div class="mb-3 row">
			<label for="name" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-10">
				<div class="mb-1">
					<label for="name" class="form-label mb-0">받으실 분</label><span class="text-danger">*</span>
					<input type="text" class="form-control" id="delivery_receiver" name="delivery_receiver">
				</div>
			</div>
		</div>
		<div class="mb-1 row">
			<label for="name" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-3">
				<div class="mb-1">
					<label for="name" class="form-label">주소</label><span class="text-danger">*</span>
					<div class="input-group">
						<input type="text" class="form-control" name="delivery_postcode" id="sample6_postcode" placeholder="우편번호" readonly> 
						<input type="button" class="btn btn-light " id="searchPostcode" value="우편번호 찾기"><br>
					</div>
				</div>
			</div>
		</div>
		<div class=" row">
			<label for="name" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-10">
				<div>
					<input type="text" class="form-control" name="delivery_address"
						id="sample6_address" placeholder="주소" readonly><br>
				</div>
			</div>
		</div>
		<div class="mb-3 row">
			<div class="col-sm-10">
				<div class="mb-1">
					<input type="text" class="form-control"
						name="delivery_detailAddress" id="sample6_detailAddress"
						placeholder="상세주소">
				</div>
			</div>
		</div>
		<div class="mb-3 row">
			<label for="name" class="col-sm-2 col-form-label"></label>
			<div class="col-sm-10">
				<div class="mb-1">
					<label for="name" class="form-label mb-0">연락처</label><span class="text-danger">*</span>
					<input type="text" class="form-control" id="delivery_phoneNo" name="delivery_phoneNo" placeholder="숫자만 입력해주세요.">
				</div>
			</div>
		</div>
		<button class="btn btn-danger" type="submit" id="newDBtn">배송지 추가</button>		
	</form>
	</div>
</body>
</html>