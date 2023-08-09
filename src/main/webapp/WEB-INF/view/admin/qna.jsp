<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<style>
	#info{
		display: flex;
		justify-content: space-between;		
	}
</style>
<script type="text/javascript">
	$(()=>{
		const type = $("#type").val();
		const pageNum = $("#pageNum").val();
		getQnaList(type, pageNum);
	});
	
	function getQnaList(type = "", pageNum = 1){
		$.ajax({
 			url : "qna/qnaList?pageNum="+pageNum+"&type="+type,
 			type : "get",
 			success : makeView,	 // 콜백함수
 			error : function(e){
 				alert("error : " + e.status);
 			}
 		});
	}
	
	function makeView(json){
		let type = json.type;
		
		let listHtml = "<div id='info' class='mb-1'><h4>총 <span class='text-danger'>" + json.qnaCnt + "</span>개</h4>";
		listHtml += "<div class='btn-group btn-group-sm' role='group'>";
		listHtml += "<button type='button' onclick='getQnaList()' class='btn " + (type == '' ? 'btn-dark' : 'btn-outline-dark') + "'>전체</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"로그인\")' class='btn " + (type == '로그인' ? 'btn-dark' : 'btn-outline-dark') + "'>로그인</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"제품\")' class='btn " + (type == '제품' ? 'btn-dark' : 'btn-outline-dark') + "'>제품</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"결제\")' class='btn " + (type == '결제' ? 'btn-dark' : 'btn-outline-dark') + "'>결제</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"배송\")' class='btn " + (type == '배송' ? 'btn-dark' : 'btn-outline-dark') + "'>배송</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"이벤트\")' class='btn " + (type == '이벤트' ? 'btn-dark' : 'btn-outline-dark') + "'>이벤트</button>";
		listHtml += "</div></div>";
		
		listHtml += "<input type='hidden' value='"+(type == '' ? '전체' : type)+"' id='type'/>";
		listHtml += "<input type='hidden' value='"+json.pageNum+"' id='pageNum'/>";
		
		listHtml += "<table class='table table-hover text-center align-middle'>";
 		listHtml += "<tr class='table-dark text-center'>";
 		listHtml += "<th width='10%'>번호</th>";
 		listHtml += "<th width='10%'>분류</th>";
 		listHtml += "<th width='50%'>제목</th>";
 		listHtml += "<th width='20%'>작성일</th>";
 		listHtml += "<th width='10%'>조회수</th>";
 		listHtml += "</tr>";
 		
 		if(json.qnaList == null || json.qnaList.length === 0){
 			listHtml += "<tr><td colspan='5'>등록된 게시글이 없습니다.</td></tr>";
 		}else{
	 		$.each(json.qnaList,function(idx, qna){
	 			listHtml += "<tr>";
	   		listHtml += "<td>"+qna.qna_number+"</td>";
	   		listHtml += "<td id='type"+qna.qna_number+"'>"+qna.qna_type+"</td>";
	   		listHtml += "<td id='t"+qna.qna_number+"'><a style='text-decoration: none' href='javascript:qnaDetail("+qna.qna_number+")'>"+qna.qna_title+"</a></td>";
	   		
	   		const regdate = new Date(qna.qna_regdate);
	   		const formattedDate = regdate.toISOString().split('T')[0];
	   		listHtml += "<td>" + formattedDate + "</td>";
	   		
	   		listHtml += "<td id='hits"+qna.qna_number+"'>"+qna.qna_hits+"</td>";
	   		listHtml += "</tr>";
	   		
	   		listHtml += "<tr class='detail' id='d"+qna.qna_number+"' style='display:none;'>";
	   		listHtml += "<td>내용</td>";
	   		listHtml += "<td colspan='4'>";
	   		listHtml += "<textarea id='ta"+qna.qna_number+"' rows='7' class='form-control' readonly></textarea>";
	   		listHtml += "<br/>"
	   		listHtml += "<span id='ub" + qna.qna_number + "'><button onclick='qnaChgForm(" + qna.qna_number + ", \"" + type + "\", " + json.pageNum + ")' class='btn btn-dark btn-sm'>수정</button></span>&nbsp;";
	   		listHtml += ""
	   		// 모달 시작
	   		// 모달 버튼
	   		listHtml += "<a type='button' class='btn btn-sm btn-dark' data-bs-toggle='modal' data-bs-target='#staticBackdrop" + qna.qna_number + "'>삭제</a>";
				// 모달 창
	   		listHtml += "<div class='modal fade' id='staticBackdrop" + qna.qna_number + "' data-bs-backdrop='static' data-bs-keyboard='false' tabindex='-1' aria-labelledby='staticBackdropLabel' aria-hidden='true'>";
	   		listHtml += "<div class='modal-dialog'>";
	   		listHtml += "<div class='modal-content'>";
	   		listHtml += "<div class='modal-header'>";
	   		listHtml += "<h5 class='modal-title' id='staticBackdropLabel'>호미짐 관리자</h5>";
	   		listHtml += "<button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button>";
	   		listHtml += "</div>";
	   		listHtml += "<div class='modal-body'>해당 게시글을 삭제하시겠습니까?</div>";
	   		listHtml += "<div class='modal-footer'>";
	   		listHtml += "<button type='button' class='btn btn-secondary btn-sm' data-bs-dismiss='modal'>닫기</button>";
	   		listHtml += "<button onclick='qnaDel("+qna.qna_number + ", \"" + type + "\", " + json.pageNum +")' class='btn btn-dark btn-sm'>삭제</button>";
	   		listHtml += "</div>";
	   		listHtml += "</div>";
	   		listHtml += "</div>";
	   		listHtml += "</div>";
	   		
	   		// 모달 끝
	   		
	   		listHtml += "<br/>"
	   		listHtml += "</td>";
	   		listHtml += "</tr>";
	 		});
 		}
 		listHtml+="</table>";
 		
 		listHtml += "<div class='text-end'>";
 		listHtml += "<button class='btn btn-primary' onclick='qnaRegForm()'>글쓰기</button>"
 		listHtml += "</div>";
 		
 		listHtml += "<div class='w3-center w3-padding-32'>";
 		listHtml += "<div class='w3-bar'>";
 		
 		type = type==''? "'',": type+",";

 		if (json.pageNum <= 1) {
 		  listHtml += '<a class="w3-bar-item w3-button w3-hover-black" onclick="alert(\'이전 페이지가 없습니다.\');">&laquo;</a>';
 		} else {
 		  listHtml += '<a class="w3-bar-item w3-button w3-hover-black" href="javascript:getQnaList(' + type + (json.pageNum - 1) +')">&laquo;</a>';
 		}

 		for (var a = json.startPage; a <= json.endPage; a++) {
 		  if (a <= json.maxPage) {
 		   listHtml += '<a class="w3-bar-item w3-button w3-hover-black '+ (a==json.pageNum? 'w3-black' : '') +' " href="javascript:getQnaList(' + type  + a +')">'+a+'</a>';
 		  }
 		}

 		if (json.startPage + 4 >= json.maxPage) {
 		  listHtml += '<a class="w3-bar-item w3-button w3-hover-black" onclick="alert(\'다음 페이지가 없습니다.\');">&raquo;</a>';
 		} else {
 		 	listHtml += '<a class="w3-bar-item w3-button w3-hover-black" href="javascript:getQnaList(' + type + (json.statPage + 5) +')">&raquo;</a>';
 		}

 		listHtml += '</div>';
 		listHtml += '</div>';
 		$("#view").html(listHtml);
 		goList();
 	}
	
	// 글 작성이 보이게 하는 함수
	function qnaRegForm(){
 		$("#view").css("display","none");
 		$("#regForm").css("display","block");
 	}
	// 글 리스트가 보이게 하는 함수
	function goList(){
 		$("#view").css("display","block");
 		$("#regForm").css("display","none");
 	}
	//글 작성 전 유효성 검사
	function validateForm() {
	  if ($("#reg")[0].checkValidity()) {
	    qnaReg();
	  } else {
	    alert("제목 또는 내용을 입력 하세요.");
	  }
	}
	// 글 작성하는 함수
	function qnaReg(){
		const fData = $("#reg").serialize();
		const type = $("#type").val();
		const pageNum = $("#pageNum").val();
	  		
 		$.ajax({
 			url : "qna/qnaReg",
 			type : "post",
 			data : fData,
 			success : function(){
 				getQnaList(type, pageNum);
 			},
 			error : function(e){
 				alert("error : " + e.status);
 			}
 		});
 		
 		// 글작성 후 폼 초기화
 		$("#formClear").trigger("click");
	}
	// 게시글 상세정보, 게시글 조회수
	function qnaDetail(number){
  		if($("#d"+number).css("display") === "none"){
  			$.ajax({
  				url : "qna/qnaDetail?qna_number="+number,
  				type : "get",
  				dataType : "json",
  				success : function(data){
  					$("#ta"+number).text(data.qna_content);
  				},
  				error : function(e){
  	 				alert("error : " + e.status);
  	 			}
  			});
  			
  			$(".detail").css("display", "none");	// 선택한 게시글만 보이게 나머지는 다 닫음
  			$("#d"+number).css({"display":"table-row"});
  			$("#ta"+number).attr("readonly",true);
  		}else{
  			$("#d"+number).css({"display":"none"});
  			$.ajax({
  				url : "qna/qnaHits?qna_number="+number,
  				type : "post",
  				dataType : "json",
  				success : function(data){
  					$("#hits"+number).text(data.qna_hits);
  				},
  				error : function(e){
  	 				alert("error : " + e.status);
  	 			}
  			});
  		}
  	}
	function qnaDel(number, curType, pageNum){
 		$.ajax({
 			url : "qna/qnaDel?qna_number="+number,
 			type : "post",
 			success : function(){
 				getQnaList(curType, pageNum);
 				closeModal(number); // 모달 닫기 함수 호출
 			},
 			error : function(){
 				alert("error");
 			}
 		});
 	}
	// 모달 닫기
	function closeModal(number) {
		  $('#staticBackdrop' + number).modal('hide');
		}
	// 업데이트 폼으로 바뀜
 	function qnaChgForm(number, curType, pageNum){
 		$("#ta"+number).attr("readonly",false);	// 1. 내용
 		
 		const title = $("#t"+number).text();
 		const newInput = "<input type='text' id='newt"+number+"' class='form-control' value='"+title+"'/>";
 		$("#t"+number).html(newInput);				// 2. 제목
 		
	  const type = $("#type"+number).text();
	  const selectBox = "<td><select id='newType"+number+"' class='form-select'><option value='로그인'"+(type === '로그인' ? " selected" : "")+">로그인</option><option value='제품'"+(type === '제품' ? " selected" : "")+">제품</option><option value='결제'"+(type === '결제' ? " selected" : "")+">결제</option><option value='배송'"+(type === '배송' ? " selected" : "")+">배송</option><option value='이벤트'"+(type === '이벤트' ? " selected" : "")+">이벤트</option></select></td>";
	  $("#type"+number).html(selectBox);  // 3. 셀렉트 박스
 		
 		const newButton = "<button class='btn btn-sm btn-dark' onclick='qnaChg("+number + ", \"" + curType + "\", " + pageNum + ")'>수정</button>"
 		$("#ub"+number).html(newButton);			// 4. 수정버튼
 	}
	// 게시글 업데이트 진행
 	function qnaChg(number, curType, pageNum){
 		const title = $("#newt"+number).val();
 		const newType = $("#newType"+number).val();
 		const content = $("#ta"+number).val();
 		
		if (title.trim() === "" || content.trim() === "") {
	   alert("제목과 내용을 입력하세요.");
	   return;
		}
 		
 		$.ajax({
 			url : "qna/qnaChg",
 			type : "post",
 			// contentType : 한글 인코딩
 			contentType : "application/json;charset=utf-8",
 			// data : json으로 주고 json으로 받아야한다.
 			data : JSON.stringify({
 				"qna_number":number,
 				"qna_title":title,
 				"qna_type":newType,
 				"qna_content":content
 			}),
 			success : function(){
 				getQnaList(curType, pageNum);
 			},
 			error : function(){
 				alert("error");
 			}
 		});
 	}
</script>
</head>
<body>
	<br><br>
	<div class="container w3-white pt-1">
		<h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 자주 묻는 질문</h3>
		<p class="mb-3">자주 묻는 질문을 관리하는 페이지 입니다.</p>

		<div id="view"></div>
		<div id="regForm" style="display: none;">
			<form id="reg">
				<table class="table align-middle">
					<tr>
						<td width="15%" class="table-dark text-center">질문 카테고리</td>
						<td><select class="form-select" name="qna_type">
								<option selected>로그인</option>
								<option>제품</option>
								<option>결제</option>
								<option>배송</option>
								<option>이벤트</option>
						</select></td>
					</tr>
					<tr>
						<td class="table-dark text-center">제목</td>
						<td colspan="3"><input type="text" name="qna_title" class="form-control" placeholder="제목을 입력하세요." required></td>
					</tr>
					<tr>
						<td class="table-dark text-center">내용</td>
						<td colspan="3"><textarea rows="15" name="qna_content" class="form-control" required></textarea></td>
					</tr>
				</table>

				<div class="text-center">
					<button type="button" class="btn btn-dark" onclick="validateForm()">글쓰기</button>
   				<button type="reset" class="btn btn-dark" id="formClear">초기화</button>
   				<button type="button"class="btn btn-dark" onclick="goList()">목록</button>
				</div>
			</form>
			<br>
		</div>

	</div>
</body>
</html>