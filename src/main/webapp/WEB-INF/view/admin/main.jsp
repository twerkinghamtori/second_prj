<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate value="${today }" pattern="yyyy년 MM월 dd일" var="d"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
</head>
<body>
	<br><br>
    <div class="container">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 오늘의 주문 현황</h3>
      <p class="text-danger text-end">${d}</p>
      <div class="container w3-white p-3">
	      <h5 class="ms-3 mb-3" style="display: inline-block;">
	     		※ 최근 업데이트 일시 : <span id="realTime1"></span> (자정 12시에 초기화됨)
	     	</h5>
	     	<a class="btn btn-sm btn-primary ms-3" href="javascript:stateReload()">새로고침 <i class="fa fa-refresh" aria-hidden="true"></i></a>
	      <div id="state"></div>
			</div>
			
      <h3 class="mt-5"><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 쇼핑몰 매출 현황</h3>
      <div class="container w3-white p-3">
        
        <div style="margin-bottom: 20px;">
        	<h5 class="ms-3 mb-3">
        		※ 최근 업데이트 일시 : <span id="realTime2"></span> (자정 12시에 초기화됨)
        	</h5>
        	<a class="btn btn-sm btn-primary ms-3" href="javascript:shopReload()">새로고침 <i class="fa fa-refresh" aria-hidden="true"></i></a>
        </div>

        <div class="row mt-3" id="sale">
          <div class="col-6 p-5">
            <br>
            <div id="shopChart"></div>
            <br>
          </div>
          <div class="col-6" id="shop"></div>
        </div>
        
      </div>
    </div>
    
  <script>
  function shopReload(){
  	barGraph();
    salesTable();
  }
  function stateReload(){
  	orderState();
  }
  function formatDate(){
  	var currentDate = new Date();
 	  var year = currentDate.getFullYear();
 	  var month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
 	  var day = currentDate.getDate().toString().padStart(2, '0');
 	  var hours = currentDate.getHours().toString().padStart(2, '0');
 	  var minutes = currentDate.getMinutes().toString().padStart(2, '0');
 	  var seconds = currentDate.getSeconds().toString().padStart(2, '0');

 	  var formattedDate = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
 	  return formattedDate;
  }
  
  $(()=> {
  	orderState();
    barGraph();
    salesTable();
  });
  
  function orderState(){
  	$.ajax({
  		url : "orderState",
  		success : function(data){
  			let html = '<table class="table table-bordered text-center align-middle">';
	      html += '<tr class="table-secondary">';
	      html += '<th rowspan="2">결제완료</th>';
	      html += '<th rowspan="2">상품준비</th>';
	      html += '<th rowspan="2">배송준비</th>';
	      html += '<th rowspan="2">배송중</th>';
	      html += '<th rowspan="2">배송완료</th>';
	      html += '<th rowspan="2">구매확정</th>';
	      html += '<th rowspan="2">취소</th>';
	      html += '<th>환불</th>';
	      html += '<th>1:1 문의</th>';
	      html += '</tr>';
	      html += '<tr class="table-secondary">';
	      html += '<th>신청/처리완료</th>';
	      html += '<th>미처리 건</th>';
	      html += '</tr>';
	      html += '<tr>';
	      html += '<td>'+data.결제완료+'</td>';
	      html += '<td>'+data.상품준비+'</td>';
	      html += '<td>'+data.배송준비+'</td>';
	      html += '<td>'+data.배송중+'</td>';
	      html += '<td>'+data.배송완료+'</td>';
	      html += '<td>'+data.구매확정+'</td>';
	      html += '<td>'+data.주문취소+'</td>';
	      html += '<td>'+data.환불+'</td>';
	      html += '<td>'+data.문의+'</td>';
	      html += '</tr>';
	      html += '</table>';
	      
	      $("#state").html(html);
	      const realTime = formatDate();
     	  $("#realTime1").html(realTime);
  		}
  	})
  }
  
  function salesTable(){
  	$.ajax({
  		url : "salesList",
  		success : function(data){
  			let html = "<table class='table table-bordered align-middle'>";
        html += '<tr class="table-secondary text-center">';
        html += '<th width="25%">날짜</th>';
        html += '<th width="25%">주문(결제완료)</th>';
        html += '<th width="25%">취소</th>';
        html += '<th width="25%">환불(처리완료)</th>';
        html += '</tr>'
        $.each(data, function(i, sale){
        	html += "<tr "+ (i==0? "class= 'text-danger'" : "") +">";
        	html += "<td class='text-center'>" + sale.date + "</td>";
       	 	html += "<td class='text-end'>" + formatAmount(sale.saleAmount) + "원<br>(" + sale.saleCnt + "건)</td>";
       	  html += "<td class='text-end'>" + formatAmount(sale.cancelAmount) + "원<br>(" + sale.cancelCnt + "건)</td>";
       	  html += "<td class='text-end'>" + formatAmount(sale.backAmount) + "원<br>(" + sale.backCnt + "건)</td>";
        	html += "</tr>";
        });
      	html += "</table>";
      	
      	$("#shop").html(html);
      	const realTime = formatDate();
     	  $("#realTime2").html(realTime);
  		},
  		error : function(e){ alert(e.status) }
  	});
  }
  
  function formatAmount(amount) {
    return amount.toLocaleString();
  }
  
  function barGraph(){
  	$.ajax({
  		url : "salesList",
  		success : function(data){
				console.log(data);
				let canvas = "<canvas id='canvas1' style='width:100%'></canvas>";
				$("#shopChart").html(canvas);
				barGraphPrint(data);
			},
			error : function(e) {}
  	})
  }

  let rsf = function(){
    return Math.round(Math.random()*255);
  }
  let randomColor= function(opacity){
    return "rgba("+ rsf() + "," + rsf() + "," + rsf() + "," + (opacity || '0.3') +")";
  }

  function barGraphPrint(arr){
		let dates = [];	
		let datas = [];
		let colors = [];
		
		$.each(arr, function(i, sale){
			colors[i] = randomColor(0.5);
			dates.push(sale.date);
			datas.push(sale.saleAmount);
		});
		
		let chartData = {
			labels : dates,
			datasets : [{
				type : "line",
				borderWidth : 2,
				boraderColor : colors,
				label : "매출 금액",
				fill : false,
				data : datas
			},{
				type : "bar",
				label : "매출 금액",
				backgroundColor : colors,
				data : datas
			}]
		}

		let config = {
			type : 'bar',   //그래프 종류
			data : {        //데이터 정보
				datasets : [
				  { type : "line",	borderWidth : 2,   borderColor : colors,
					label :'매출 금액',	fill : false,  	   data : datas },
                  {	type : "bar",  backgroundColor : colors,  label :'매출 금액',	data : datas }
                 ],
			     labels : dates,
			},
			options : {
				responsive : true,
				legend : {display:false},
			    title : {
			    	display : true, 	text : "최근 7일 매출 현황",
			    	position : 'bottom'
			    },
			    scales : {
			    	xAxes : [{ display : true,
			    		       scaleLabel : {display : true, labelString : "날짜"}
			    	         }],
			    	yAxes : [{
			    		scaleLabel : { display : true, labelString : "매출 금액"  },
			    		ticks : {beginAtZero : true}
			    	  }]
			    }
			}
	}
		
		let ctx = document.getElementById("canvas1").getContext('2d');
		new Chart(ctx, config);
	}	// barGraphPrint
</script>
</body>
</html>