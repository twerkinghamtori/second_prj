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
<script>
	function list_disp(cs_number) {
		$("#cs_aContent"+cs_number).toggle();
		console.log(cs_number)
		$.ajax({
			url : "${path}/ajax/csDetail",
			method : "POST",
			data : {cs_number : cs_number}, 
			success : function(result) {
				var html = ""
				html+="<tr style='background-color:pink; color:white;'><th>답변일자</th><th>답변내용</th><th>담당자</th></tr>"              	
				html += "<tr>";
				if(result.cs_aContent == null) {
					html += "<td colspan='3' class='text-secondary'>아직 답변이 등록되지 않았습니다.</td>"
				} else {
					html += "<td>" + formatDate(result.cs_adate) + "</td>";;
					html += "<td>" + result.cs_aContent + "</td>";
					html += "<td>" + result.manager_name + "</td>";		
				}					
				html += "</tr>";
				$("#csDetail"+cs_number).html(html);
			}, error : function(e) {
				alert("문의 상세정보 불러오기 오류 : " + e.status)
			}
		})
	}
	// 날짜 포맷팅 함수
	function formatDate(dateString) {
	  var date = new Date(dateString);
	  var year = date.getFullYear();
	  var month = ("0" + (date.getMonth() + 1)).slice(-2);
	  var day = ("0" + date.getDate()).slice(-2);
	  return year + "년 " + month + "월 " + day + "일";
	}
	
	function cancel(order_id) {
		$.ajax({
			url : "${path}/ajax/cancelOrder",
			method : "POST",
			contentType : "application/json;charset=utf-8",
			data : {order_id : order_id},
			success : function(result) {
				alert(result);
			}, error : function(e) {
				alert("[ajax] 주문취소 오류 : " + e.status)
			}
		})
	}
</script>
</head>
<body>
	<div class="container">
		<div style="display: flex; justify-content: space-between;">
			<div style="flex-basis: 20%;">
				<%@ include file="mypageSideBar2.jsp"%>
			</div>
			<div style="flex-basis: 80%;">
      <h1 class="mb-3">1:1 문의</h1>
      <c:if test="${empty csList }">
      		<h2 class="text-secondary text-center" style="margin-top:50px;">1:1 문의 내역이 없습니다.</h2>
      </c:if>
      <c:if test="${!empty csList }">
      <div class="row">
        <div class="col-9">
          <h5>총 <span style="color: red;">${csList.size() }</span>건</h5>
        </div>
        <div class="col-3 text-end">
        	<button type="button" class="btn btn-danger" onclick="location.href='${path}/cs'">1:1 문의 하기</button>
        </div>
      </div>
      
      <div class="row" id="oinfo" class="info">
      
      
        <table class="table table-hover">
          <tr style="text-align:center; background-color:#D1180B; color: white;">
          	<c:set var="n" value="1" />
          	<th>번호</th>
          	<th>문의내용</th>
            <th>문의일자</th>            
          </tr>
        <c:forEach items="${csList }" var="c" varStatus="st">
          <tr style="text-align:center;">
          	<td>${st.index+1 }</td>
          	<td><a href="javascript:list_disp('${c.cs_number }')">${c.cs_qContent }</a></td>  
            <td><fmt:formatDate value="${c.cs_qdate }" pattern="yyyy년 MM월 dd일" /></td>                      
          </tr> 
          
          <!-- 문의 상세정보 -->
          <tr style="text-align:center;display:none;" class="saleLine" id="cs_aContent${c.cs_number }">
            <td colspan="7">
            <table id="csDetail${c.cs_number }" class="table table-borderless">                    
            </table>
            </td>
          </tr>         
          </c:forEach>
        </table>
      </div>
      </c:if>
    </div>
			</div>
		</div>
</body>
</html>