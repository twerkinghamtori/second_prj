<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<script type="text/javascript">
	$(()=>{
		const opt_number = $("#opt_number").val();
		const pageNum1 = $("#pageNum1").val();
		const pageNum2 = $("#pageNum2").val();
		optOrder(opt_number, pageNum1);
		optStock(opt_number, pageNum2);
	})
	
	function fmtDate(date){
		const fmtDate = new Date(date);
    const year = fmtDate.getFullYear();
    const month = fmtDate.getMonth() + 1;
    const day = fmtDate.getDate();
    const formattedDate = year + "년 " + month + "월 " + day + "일";
    
    return formattedDate;
	}
	
	function optOrder(opt_number, pageNum=1){
		$.ajax({
			url : "optOrder?opt_number=" + opt_number + "&pageNum=" + pageNum,
			success : function(data){
				printOptOrder(data);
			},
			error : function(e) { alert(e.status); }
		})
		
	}
	
	function printOptOrder(json){
		let html = "<input type='hidden' id='pageNum1' value='"+json.pageNum+"'>"
		html += "<table class='table table-bordered table-hover text-center'>";
		html += "<tr class='table-primary'>";
		html += "<th width='75%'>날짜</th>"
		html += "<th width='25%'>판매 개수</th>"
		html += "</tr>";
		
		if(json.optOrerList == null || json.optOrerList.length === 0){
 			html += "<tr><td colspan='2'>등록된 주문내역이 없습니다.</td></tr>";
 		}else{
			$.each(json.optOrerList, function(i, item){
				html += "<tr>";
				html += "<td>" + fmtDate(item.order_date) + "</td>";
				html += "<td>" + item.opt_count + "</td>";
				html += "</tr>";
			})
 		}
		
		html +="</table>";
		
		html += "<div class='w3-center w3-padding-32'>";
 		html += "<div class='w3-bar'>";
 		
 		if (json.pageNum <= 1) {
 		  html += '<a class="w3-bar-item w3-button w3-hover-black" onclick="alert(\'이전 페이지가 없습니다.\');">&laquo;</a>';
 		} else {
 		  html += '<a class="w3-bar-item w3-button w3-hover-black" href="javascript:optOrder(\'' + json.opt_number + "','" + (json.pageNum - 1) + '\')">&laquo;</a>'
 		}

 		for (var a = parseInt(json.startPage); a <= parseInt(json.endPage); a++) {
 		  if (a <= json.maxPage) {
 		   html += '<a class="w3-bar-item w3-button w3-hover-black '+ (a==json.pageNum? 'w3-black' : '') +' " href="javascript:optOrder(\'' + json.opt_number + "','" +a + '\')">'+a+'</a>';
 		  }
 		}

 		if (json.startPage + 4 >= json.maxPage) {
 		  html += '<a class="w3-bar-item w3-button w3-hover-black" onclick="alert(\'다음 페이지가 없습니다.\');">&raquo;</a>';
 		} else {
 			html += '<a class="w3-bar-item w3-button w3-hover-black" href="javascript:optOrder(\'' + json.opt_number + "','" + (json.startPage +5) + '\')">&raquo;</a>'
 		}

 		html += '</div>';
 		html += '</div>';
 		$("#order").html(html);
	}
	
	function optStock(opt_number, pageNum=1){
		$.ajax({
			url : "optStock?opt_number=" + opt_number + "&pageNum=" + pageNum,
			success : function(data){
				printStockOrder(data);
			},
			error : function(e) { alert(e.status); }
		})
	}
	
	function printStockOrder(json){
		let html = "<input type='hidden' id='pageNum2' value='"+json.pageNum+"'>"
		html += "<table class='table table-bordered table-hover text-center'>";
		html += "<tr class='table-primary'>";
		html += "<th width='75%'>날짜</th>"
		html += "<th width='25%'>입고 수량</th>"
		html += "</tr>";
		
		if(json.optStockList == null || json.optStockList.length === 0){
 			html += "<tr><td colspan='2'>등록된 재고내역 없습니다.</td></tr>";
 		}else{
			$.each(json.optStockList, function(i, stock){
				html += "<tr>";
				html += "<td>" + fmtDate(stock.stock_regdate) + "</td>";
				html += "<td>" + stock.stock_quantity + "</td>";
				html += "</tr>";
			})
 		}
		
		html +="</table>";
		
		html += "<div class='w3-center w3-padding-32'>";
 		html += "<div class='w3-bar'>";
 		
 		if (json.pageNum <= 1) {
 		  html += '<a class="w3-bar-item w3-button w3-hover-black" onclick="alert(\'이전 페이지가 없습니다.\');">&laquo;</a>';
 		} else {
 		  html += '<a class="w3-bar-item w3-button w3-hover-black" href="javascript:optStock(\'' + json.opt_number + "','" + (json.pageNum - 1) + '\')">&laquo;</a>'
 		}

 		for (var a = parseInt(json.startPage); a <= parseInt(json.endPage); a++) {
 		  if (a <= json.maxPage) {
 		   html += '<a class="w3-bar-item w3-button w3-hover-black '+ (a==json.pageNum? 'w3-black' : '') +' " href="javascript:optOrder(\'' + json.opt_number + "','" +a + '\')">'+a+'</a>';
 		  }
 		}

 		if (json.startPage + 4 >= json.maxPage) {
 		  html += '<a class="w3-bar-item w3-button w3-hover-black" onclick="alert(\'다음 페이지가 없습니다.\');">&raquo;</a>';
 		} else {
 			html += '<a class="w3-bar-item w3-button w3-hover-black" href="javascript:optOrder(\'' + json.opt_number + "','" + (json.startPage +5) + '\')">&raquo;</a>'
 		}

 		html += '</div>';
 		html += '</div>';
 		$("#stock").html(html);
	}
</script>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1" style="width:70%">
    <input id="opt_number" type="hidden" value="${opt.opt_number }">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 제품 옵션 상세</h3>
      <p class="mb-3">제품 옵션의 상세정보 페이지 입니다.</p>
        <table class="table align-middle">
          <tr class="text-center">
            <td class="table-primary text-center">제품명</td>
            <td>${opt.product_name }</td>
          </tr>
          <tr>
          	<td class="table-primary text-center">제품 이미지</td>
            <td class="text-center"><img src="${path }/img/thumb/${opt.product_thumb }" width="200" height="130"></td>
          </tr> 
          <tr>
            <td class="table-primary text-center">옵션명</td>
            <td><input type="text" name="opt_name" class="form-control" readonly value="${opt.opt_name }"></td>
          </tr>
          <tr>
          	<td class="table-primary text-center">수량</td>
            <td>
            	<input type="number"  class="form-control" readonly value="${opt.opt_quantity }">
            </td>
          </tr>
        </table>

        <div class="text-center">
          <a href="optList" class="btn btn-dark">목록</a>
        </div>
      <br>
    </div>
    
    <br><br>
    
    <div style="display:flex; justify-content: space-between;">
    	<div class="container w3-white pt-1" >
    		<h3><i class="fa fa-caret-square-o-right text-primary mb-3" aria-hidden="true"></i> 제품 판매 현황</h3>
    		<div id="order"></div>
    	</div>
    	<div>&nbsp;</div>
    	<div>&nbsp;</div>
    	<div>&nbsp;</div>
    	<div class="container w3-white pt-1">
    		<h3><i class="fa fa-caret-square-o-right text-primary mb-3" aria-hidden="true"></i> 제품 입고 현황</h3>
    		<div id="stock"></div>
    	</div>
    </div>
</body>
</html>