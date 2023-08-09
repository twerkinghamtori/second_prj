<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<style type="text/css">
	  #customer .btn {
    border-bottom: 2px solid transparent;
    transition: all 0.3s;
    position: relative;
  }

  #customer .btn::after {
    content: "";
    position: absolute;
    bottom: -2px;
    left: 50%;
    width: 0;
    height: 5px;
    background-color: white;
    transition: all 0.3s;
    transform: translateX(-50%);
  }

  #customer .btn.active::after,
  #customer .btn:hover::after {
    width: 100%;
    transform: translateX(-50%);
  }
  
  .red-border {
    border-bottom: 3px solid red;
  }
  
  .w3-bar-block {
    border-radius: 8px; /* 꼭짓점을 둥글게 설정 */
    box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.3); /* 그림자 효과 설정 */
  }
  
  .content{
  	min-height: 100px;
  	padding: 10px;
  	background-color: rgba(0,0,0,0.1);
  	text-align: left;
  	margin-left: 70px;
  	margin-right: 50px;
  }
  .cc{
  	color : white;
  	font-size : 16px;
  }
</style>
<script type="text/javascript">
	$(()=>{
		const type = $("#type").val();
		const pageNum = $("#pageNum").val();
		
		$("#q").addClass("active");
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
		
		let listHtml = "<div class='btn-group btn-group-sm mb-3' role='group'>";
		listHtml += "<button type='button' onclick='getQnaList()' class='btn " + (type == '' ? 'btn-danger' : 'btn-outline-danger') + "'>전체</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"로그인\")' class='btn " + (type == '로그인' ? 'btn-danger' : 'btn-outline-danger') + "'>로그인</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"제품\")' class='btn " + (type == '제품' ? 'btn-danger' : 'btn-outline-danger') + "'>제품</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"결제\")' class='btn " + (type == '결제' ? 'btn-danger' : 'btn-outline-danger') + "'>결제</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"배송\")' class='btn " + (type == '배송' ? 'btn-danger' : 'btn-outline-danger') + "'>배송</button>";
		listHtml += "<button type='button' onclick='getQnaList(\"이벤트\")' class='btn " + (type == '이벤트' ? 'btn-danger' : 'btn-outline-danger') + "'>이벤트</button>";
		listHtml += "</div>";
		
		listHtml += "<input type='hidden' value='"+(type == '' ? '전체' : type)+"' id='type'/>";
		listHtml += "<input type='hidden' value='"+json.pageNum+"' id='pageNum'/>";
		
		listHtml += "<table class='table table-hover text-center align-middle'>";
 		listHtml += "<tr class='text-center red-border'>";
 		listHtml += "<th width='15%'>분류</th>";
 		listHtml += "<th width='55%'>질문</th>";
 		listHtml += "<th width='10%'>조회수</th>";
 		listHtml += "</tr>";
 		
 		if(json.qnaList == null || json.qnaList.length === 0){
 			listHtml += "<tr><td colspan='5'>등록된 게시글이 없습니다.</td></tr>";
 		}else{
	 		$.each(json.qnaList,function(idx, qna){
	 			listHtml += "<tr>";
	   		listHtml += "<td id='type"+qna.qna_number+"'>"+qna.qna_type+"</td>";
	   		listHtml += "<td id='t"+qna.qna_number+"'><a style='text-decoration: none' href='javascript:qnaDetail("+qna.qna_number+")'>"+qna.qna_title+"</a></td>";
	   		
	   		listHtml += "<td id='hits"+qna.qna_number+"'>"+qna.qna_hits+"</td>";
	   		listHtml += "</tr>";
	   		
	   		listHtml += "<tr class='detail' id='d"+qna.qna_number+"' style='display:none;'>";
	   		listHtml += "<td colspan='3'>";
	   		listHtml += "<div class='content' id='ta"+qna.qna_number+"'></div></td>"
	   		listHtml += "</tr>";
	 		});
 		}
 		listHtml+="</table>";
 		
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
 	}
	
	// 게시글 상세정보, 게시글 조회수
	function qnaDetail(number){
  		if($("#d"+number).css("display") === "none"){
  			$.ajax({
  				url : "qna/qnaDetail?qna_number="+number,
  				type : "get",
  				dataType : "json",
  				success : function(data){
  					$("#ta"+number).html("답변 : <br> "+data.qna_content);
  				},
  				error : function(e){
  	 				alert("error : " + e.status);
  	 			}
  			});
  			
  			$(".detail").css("display", "none");	// 선택한 게시글만 보이게 나머지는 다 닫음
  			$("#d"+number).css({"display":"table-row"});
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
</script>
</head>
<body>
	<br><br>
	<div class="container-sm pt-1">
		<div style="display:flex;">
			<div style="flex-basis: 20%; margin-top : 100px;">
				<nav class="w3-bar-block w3-red p-3">
				  <div id="customer" class="w3-large w3-center" style="font-weight:bold">
				  	<h2><i class="fa fa-question-circle" aria-hidden="true"></i> 고객센터</h2><br>
				  	<p>
				    <a href="${path }/qna" id="q" class="btn cc">· 자주 묻는 질문</a><br>
				    <a href="${path }/cs" class="btn cc">· 1:1 문의</a>
				  </div>
				</nav>
			</div>
			<div style="flex-basis: 5%">&nbsp;</div>
			<div style="flex-basis: 75%; margin-right: 100px">
				<h2 ><i class="fa fa-caret-square-o-right text-danger" aria-hidden="true"></i> 자주 묻는 질문</h2>
				<p class="mb-3">고객님들께서 자주 궁금해 하시는 질문들을 모아놓은 곳입니다.</p>
				<div id="view"></div>
			</div>
		</div>
	</div>
</body>
</html>