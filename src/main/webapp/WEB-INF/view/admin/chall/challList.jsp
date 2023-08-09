<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐 관리자</title>
<style type="text/css">
	#tr, .Lightseagreen, .btn-outline-custom-Lightseagreen:hover {
		background-color: Lightseagreen;
		color : white;
	}
	.btn-outline-custom-Lightseagreen {
	  color: Lightseagreen;
	  border-color: Lightseagreen;
	}
	
	.active-Lightseagreen{
		color: white;
	  background-color: Lightseagreen;
	}
</style>
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 챌린지 참여자 목록</h3>
      <p class="mb-3">챌린지 참여자를 보여주는 페이지 입니다.</p>
      
      <div class="container">
      	<form action="challList">
	        <div style="display: flex;justify-content: space-between;border-bottom: 2px solid black;margin-bottom: 10px;">
	          <h4 style="margin-top: 25px;">총 <span class="text-danger">${challCnt }</span>건</h4>
	          <div class="input-group p-3" style="width: 75%;">
						  <input type="date" name="sd" value="${sd}" class="form-control mr-3">
						  <div class="input-group-prepend">
						    <span class="input-group-text">부터</span>
						  </div>
						  <input type="date" name="ed" value="${ed}" class="form-control">
						  <div class="input-group-prepend">
						    <span class="input-group-text">까지</span>
						  </div>
						  <input type="text" class="form-control ms-3" name="query" placeholder="회원명" value="${param.query}">
						  <div class="input-group-append">
						    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">
						      <i class="fa fa-search"></i>
						    </button>
						  </div>
						</div>
	        </div>
        </form>
        
       <div class="btn-group mb-3">
				  <button type="button" onclick="location.href='challList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&query=${param.query}'" class="btn btn-outline-custom-Lightseagreen btn-sm ${empty chall_state ? 'active-Lightseagreen' : '' }">전체</button>
				  <button type="button" onclick="location.href='challList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&query=${param.query}&chall_state=지급대기'" class="btn btn-outline-custom-Lightseagreen btn-sm ${chall_state eq '지급대기' ? 'active-Lightseagreen' : '' }">지급대기</button>
				  <button type="button" onclick="location.href='challList?pageNum=${pageNum}&sd=${sd}&ed=${ed}&query=${param.query}&chall_state=지급완료'" class="btn btn-outline-custom-Lightseagreen btn-sm ${chall_state eq '지급완료' ? 'active-Lightseagreen' : '' }">지급완료</button>
				</div>
        
        <c:if test="${empty challList }">
        	<h4 class="text-center">등록된 챌린지가 없습니다.</h4>
        </c:if>
        
        <c:if test="${!empty challList }">
	        <table class="table table-hover table-bordered text-center align-middle">
	          <tr id="tr">
	            <th width="10%">챌린지 번호</th>
	            <th width="20%">이미지</th>
	            <th width="20%">아이디</th>
	            <th width="10%">이름</th>
	            <th width="15%">참여일</th>
	            <th width="10%">횟수</th>
	            <th width="15%">상태</th>
	          </tr>
	          <c:forEach var="chall" items="${challList }" varStatus="st">
		          <tr>
		            <td>${chall.chall_number }</td>
		            <td><img src="${path }/img/chall/${chall.chall_pic }" width="150"></td>
		            <td>${chall.mem_id} </td>
		            <td>${chall.mem_name}</td>
		            <td><fmt:formatDate value="${chall.chall_regdate }" pattern="yyyy-MM-dd" /></td>
		            <td>${chall.chall_cnt}</td> 
		            <td>
		            	${chall.chall_state}
		            	<br>
		            	<c:if test="${chall.chall_state eq '지급대기'}">
			            	<form action="payPoint" method="post" style="display: inline-block;">
			            		<input type="hidden" name="chall_number" value="${chall.chall_number }">
			            		<input type="hidden" name="mem_id" value="${chall.mem_id }">
			            		<input type="hidden" name="chall_cnt" value="${chall.chall_cnt }">
			            		 <a type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop${st.index }${chall.chall_number }">포인트 지급</a>
																		
												<%-- Modal --%>
												<div class="modal fade" id="staticBackdrop${st.index }${chall.chall_number }" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
												  <div class="modal-dialog">
												    <div class="modal-content">
												      <div class="modal-header">
												        <h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>
												        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
												      </div> 
												      <div class="modal-body">해당 회원에게 포인트를 지급 하시겠습니까?</div>
												      <div class="modal-footer">
												        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
												        <button type="submit" class="btn btn-dark">지급</button>
												      </div>
												    </div>
												  </div>
												</div>
			            	</form>
		            	</c:if>
		            	
		            	<form action="challDel" method="post" style="display: inline-block;">
		            		<input type="hidden" name="chall_number" value="${chall.chall_number }">
		            		 <a type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop${chall.chall_number }">삭제</a>
																	
										<%-- Modal --%>
										<div class="modal fade" id="staticBackdrop${chall.chall_number }" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
										  <div class="modal-dialog">
										    <div class="modal-content">
										      <div class="modal-header">
										        <h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>
										        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										      </div> 
										      <div class="modal-body">해당 챌린지를 삭제 하시겠습니까?</div>
										      <div class="modal-footer">
										        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
										        <button type="submit" class="btn btn-dark">삭제</button>
										      </div>
										    </div>
										  </div>
										</div>
		            	</form>
		            	
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
						<a class="w3-bar-item w3-button w3-hover-black" href="challList?pageNum=${pageNum-1}&sd=${sd}&ed=${ed}&query=${param.query}&chall_state=${param.chall_state}">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="challList?pageNum=${a}&sd=${sd}&ed=${ed}&query=${param.query}&chall_state=${param.chall_state}">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="challList?pageNum=${startPage+5}&sd=${sd}&ed=${ed}&query=${param.query}&chall_state=${param.chall_state}">&raquo;</a>
					</c:if>
		    </div>
		  </div>

      </div>
    </div>
</body>
</html>