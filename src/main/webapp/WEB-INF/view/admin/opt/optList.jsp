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
</head>
<body>
	<br><br>
    <div class="container w3-white pt-1">
      <h3><i class="fa fa-caret-square-o-right text-primary" aria-hidden="true"></i> 제품 옵션 목록</h3>
      <p class="mb-3">제품 옵션 목록을 보여주는 페이지 입니다.</p>
      
      <div class="container">
      	<form action="optList">
	        <div style="display: flex;justify-content: space-between;border-bottom: 2px solid black;margin-bottom: 10px;">
	          <h4 style="margin-top: 25px;">총 <span class="text-danger">${optCnt }</span>개</h4>
	          <div class="input-group p-3" style="width: 30%;">
	            <input type="text" class="form-control" name="query" placeholder="제품명 검색" value="${param.query}">
	            <button class="btn btn-outline-secondary" type="submit" id="button-addon2"><i class="fa fa-search"></i></button>
	          </div>
	        </div>
        </form>
        
        <c:if test="${empty optList }">
        	<h4 class="text-center">등록된 제품 옵션이 없습니다.</h4>
        </c:if>
        
        <c:if test="${!empty optList }">
        	<form action="optDel" method="post">
		        <table class="table table-hover table-bordered text-center align-middle">
		          <tr class="table-primary">
		            <th width="10%">옵션 번호</th>
		            <th width="10%">제품 이미지</th>
		            <th width="50%">제품명(옵션명)</th>
		            <th width="15%">수량</th>
		            <th width="15%">&nbsp;</th>
		          </tr>
		          <c:forEach var="opt" items="${optList }">
			          <tr>
			            <td>${opt.opt_number }</td>
			            <td><img src="${path }/img/thumb/${opt.product_thumb }" width="100"></td>
			            <td>
			            	${opt.product_name }(${opt.opt_name })
			            	<br>
			            	<a class="btn btn-sm btn-dark" href="optDetail?opt_number=${opt.opt_number }">상세보기</a>
			            </td>
			            <td>${opt.opt_quantity}<br><a class="btn btn-sm btn-secondary mt-1" href="${path}/admin/stock/stockReg?opt_number=${opt.opt_number }">재고 등록</a></td>
			            <td>
			            	<input type="hidden" name="opt_number" value="${opt.opt_number }">
			            	<a class="btn btn-sm btn-dark" href="optChg?opt_number=${opt.opt_number}">수정</a>
					          <a type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop${opt.opt_number }">삭제</a>
																	
										<%-- Modal --%>
										<div class="modal fade" id="staticBackdrop${opt.opt_number}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
										  <div class="modal-dialog">
										    <div class="modal-content">
										      <div class="modal-header">
										        <h5 class="modal-title" id="staticBackdropLabel">호미짐 관리자</h5>
										        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										      </div> 
										      <div class="modal-body">해당 제품 옵션을 삭제 하시겠습니까?</div>
										      <div class="modal-footer">
										        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
										        <button type="submit" class="btn btn-dark">삭제</button>
										      </div>
										    </div>
										  </div>
										</div>
										
			            </td>
			          </tr>
		          </c:forEach>
		        </table>
	        </form>
        </c:if>

         <div class="w3-center w3-padding-32">
		    <div class="w3-bar">
			    <c:if test="${pageNum<= 1}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
					</c:if>
					<c:if test="${pageNum > 1}">
						<a class="w3-bar-item w3-button w3-hover-black" href="optList?pageNum=${pageNum-1}&query=${param.query}">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="optList?pageNum=${a}&query=${param.query}">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="optList?pageNum=${startPage+5}&query=${param.query}">&raquo;</a>
					</c:if>
		    </div>
		  </div>

      </div>
    </div>
</body>
</html>