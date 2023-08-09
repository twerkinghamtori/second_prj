<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<style type="text/css">
	a{
		text-decoration: none;
	}
</style>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1" >
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 회원 목록</h3>
      <p class="mb-3">회원 목록을 보여주는 페이지 입니다.</p>
      
      <div class="container">
      	<form action="memList">
	        <div style="display: flex;justify-content: space-between;border-bottom: 2px solid black;margin-bottom: 10px;">
	          <h4 style="margin-top: 25px;">총 <span class="text-danger">${memCnt }</span>명</h4>
	          <div class="input-group p-3" style="width: 40%;">
	          	<select id="sel" class="form-select" name="f">
			          <option ${param.f eq 'mem_id'? 'selected' : '' } value="mem_id">아이디</option>
			          <option ${param.f eq 'mem_name'? 'selected' : '' } value="mem_name">이름</option>
			        </select>
	            <input type="text" class="form-control" name="query" placeholder="검색어" value="${param.query}">
	            <button class="btn btn-outline-secondary" type="submit" id="button-addon2"><i class="fa fa-search"></i></button>
	          </div>
	        </div>
        </form>
        
        <c:if test="${empty memCnt }">
        	<h4 class="text-center">등록된 회원이 없습니다.</h4>
        </c:if>
        
        <c:if test="${!empty memCnt }">
	        <table class="table table-hover table-bordered text-center align-middle">
	          <tr class="table-warning">
	            <th width="10%">회원 번호</th>
	            <th width="25%">아이디</th>
	            <th width="20%">채널</th>
	            <th width="20%">연락처</th>
	            <th width="25%">포인트</th>
	          </tr>
	          <c:forEach var="mem" items="${memList }">
		          <tr>
		            <td>${mem.mem_number }</td>
		            <td>
		            	${mem.mem_id} 
		            	<br>
		            	<a class="btn btn-sm btn-dark" href="memChg?mem_number=${mem.mem_number}">정보수정</a>
		            	<c:if test="${sessionScope.loginManager.manager_grant eq '총괄'}">
		            		<form action="memDel" method="post" style="display:inline-block;">
		            			<input type="hidden" name="mem_number" value="${mem.mem_number}">
			            		<a type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop${mem.mem_number }">탈퇴</a>
																		
											<%-- Modal --%>
											<div class="modal fade" id="staticBackdrop${mem.mem_number }" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
											  <div class="modal-dialog">
											    <div class="modal-content">
											      <div class="modal-header">
											        <h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>
											        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
											      </div> 
											      <div class="modal-body">해당 회원을 탈퇴 처리 하시겠습니까?</div>
											      <div class="modal-footer">
											        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
											        <button type="submit" class="btn btn-dark">탈퇴</button>
											      </div>
											    </div>
											  </div>
											</div>
										</form>
		            	</c:if>
		            </td>
		            <td>${empty mem.mem_channel? '일반' :  mem.mem_channel}</td>
		            <td>${mem.mem_phoneno}</td>
		            <td>
		            	<fmt:formatNumber value="${mem.mem_point }" pattern="#,###"/>P
		            	<br>
		            	<a class="btn btn-sm btn-secondary" href="${path }/admin/point/pointReg?mem_number=${mem.mem_number}">포인트 지급</a>
		            </td>
		          </tr>
	          </c:forEach>
	        </table>
        </c:if>

        <div class="w3-center w3-padding-32">
			    <div class="w3-bar">
				    <c:if test="${pageNum<= 1}">
							<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
						</c:if>
						<c:if test="${pageNum > 1}">
							<a class="w3-bar-item w3-button w3-hover-black" href="memList?pageNum=${pageNum-1}&query=${param.query}&f=${param.f}">&laquo;</a>
						</c:if>
						
						<c:forEach var="a" begin="${startPage}" end="${endPage}">
							<c:if test="${a <= maxPage}">
								<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="memList?pageNum=${a}&query=${param.query}&f=${param.f}">${a}</a>
							</c:if>
						</c:forEach>
							
						<c:if test="${startPage+4 >= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
						</c:if>
						<c:if test="${startPage+4 < maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black" href="memList?pageNum=${startPage+5}&query=${param.query}&f=${param.f}">&raquo;</a>
						</c:if>
			    </div>
			  </div>

      </div>
    </div>
</body>
</html>