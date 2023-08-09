<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호미짐</title>
<script type="text/javascript">
	function listpage(page) {
		document.searchForm.pageNum.value = page;
		document.searchForm.submit();
	}
	function noPage() {
		alert("페이지가 존재하지 않습니다.");
	}
</script>
<style>
	.noline {text-decoration:none;}
	a.active {color : red;}
	
  .divider {
    display: inline-block;
    width: 1px;
    height: 10px;
    background-color: #000;
    margin: 0 5px;
  }
  a:hover{
  	color:red;
  }
</style>
</head>
<body>
	<div class="container">
      <div class="row">
        <div class="col-3" style="font-size:40px;">${product_type_name }</div> 
        <div class="col-5"></div>
        <div class="col">
          <form action="productList" name="searchForm">
          	<input type="hidden" name="pageNum" value="1">
          	<input type="hidden" name="sort" value="${param.sort != null? param.sort : '' }">
          	<input type="hidden" name="product_type" value="${param.product_type }">
            <div class="input-group">
              <input type="text" class="form-control" id="searchContent" name="searchContent" placeholder="상품을 검색하세요." value="${searchContent }">
              <button class="btn btn-danger" type="submit" id="button-addon2"><i class="fa fa-search"></i></button>
            </div>
          </form>
        </div>        
      </div>
      <hr>
      <div class="row">
        <div class="col" style="margin-bottom:20px; font-size:20px;">
  			<a href="productList?product_type=${param.product_type}&sort=1&searchContent=${param.searchContent != null ? param.searchContent : ''}" class="noline ${param.sort == 1 ? 'active' : ''}">주문많은순</a>
  			<span class="divider"></span>
  			<a href="productList?product_type=${param.product_type}&sort=2&searchContent=${param.searchContent != null ? param.searchContent : ''}" class="noline ${param.sort == 2 ? 'active' : ''}">낮은가격순</a>
  			<span class="divider"></span>
  			<a href="productList?product_type=${param.product_type}&sort=3&searchContent=${param.searchContent != null ? param.searchContent : ''}" class="noline ${param.sort == 3 ? 'active' : ''}">높은가격순</a>
  			<span class="divider"></span>
  			<a href="productList?product_type=${param.product_type}&sort=4&searchContent=${param.searchContent != null ? param.searchContent : ''}" class="noline ${param.sort == 4 ? 'active' : ''}">최신등록순</a>
  			<span class="divider"></span>
  			<a href="productList?product_type=${param.product_type}&sort=5&searchContent=${param.searchContent != null ? param.searchContent : ''}" class="noline ${param.sort == 5 ? 'active' : ''}">리뷰많은순</a>
		</div>     
      </div>
      
      <c:if test="${empty map}">
      	<h2 class="text-secondary text-center" >상품이 없습니다.</h2>
      </c:if>
	
	  <c:forEach items="${map }" var="m" varStatus="st">
	  		<c:if test="${st.index % 3 == 0}">
    			<div class="row">
  			</c:if>
  			<c:if test='${m.key.product_discountRate != 0 }'>
  			<div class="col-4">
	  		<table class="table">
	  			<tr>
	  				<td>				
          				<a href="productDetail?product_number=${m.key.product_number }"><img src="${path }/img/thumb/${m.key.product_thumb}" style="width:100%"></a>
          				<div class="row"> 
	          				<div class="col-6" style="display: flex;">
              					<div class="text-secondary" style="font-size: 20px;text-decoration:line-through;">
              						<fmt:formatNumber value="${m.key.product_price }" pattern=",###" />원
              					</div>
            					<c:set var="discounted" value="${m.key.product_price*(100-m.key.product_discountRate)/100 }" />
              					<div style="font-size: 20px; margin-left: 10px;">
              						<fmt:formatNumber value="${discounted+(1-(discounted%1))%1}" />원
              					</div>
            				</div>
            				<div class="col-6 text-end">            					
              					<div class="text-primary" style="font-size: 20px;">${m.key.product_discountRate}%</div>              					
            				</div>            				
          				</div>        
          				<div style="font-size:20px;"><a href="productDetail?product_number=${m.key.product_number }" style="text-decoration:none;">${m.key.product_name }</a></div>
          				<c:if test="${! empty m.value }">
          					<c:set var="sum" value="0" />
          					<c:forEach items="${m.value}" var="review">
      							<c:set var="sum" value="${sum + review.review_value}" />
   							</c:forEach>
   							<c:set var="average" value="${sum / m.value.size()}" />
          				</c:if>
         				<div class="text-secondary">
         					<c:if test="${! empty m.value }">
         						<span>평점 <fmt:formatNumber value="${average}" pattern="#.0" /></span>
         					</c:if>         					
         					<span>  리뷰 ${m.value.size() }</span>
         				</div>        				
	  				</td>
	  			</tr>
	  		</table>
	  		</div>
	  		</c:if>
	  		<c:if test='${m.key.product_discountRate == 0 }'>
  			<div class="col-4">
	  		<table class="table">
	  			<tr>
	  				<td>	  					
          				<a href="productDetail?product_number=${m.key.product_number }"><img src="${path }/img/thumb/${m.key.product_thumb}" style="width:100%"></a>
          				<div class="row"> 
            				<div class="col-6">              					
            				</div>
            				<div class="col-3 ms-2">
            				</div>
            				<div class="col-3">
              					<div style="font-size: 20px;"><fmt:formatNumber value="${m.key.product_price }" pattern=",###" />원</div>
            				</div>
          				</div>        
          				<div style="font-size:20px;"><a href="productDetail?product_number=${m.key.product_number }" style="text-decoration:none;">${m.key.product_name }</a></div>
         				<c:if test="${! empty m.value }">
          					<c:set var="sum" value="0" />
          					<c:forEach items="${m.value}" var="review">
      							<c:set var="sum" value="${sum + review.review_value}" />
   							</c:forEach>
   							<c:set var="average" value="${sum / m.value.size()}" />
          				</c:if>
         				<div class="text-secondary">
         					<c:if test="${! empty m.value }">
         						<span>평점 <fmt:formatNumber value="${average}" pattern="#.0" /></span>
         					</c:if>         					
         					<span>  리뷰 ${m.value.size() }</span>
         				</div>      				
	  				</td>
	  			</tr>
	  		</table>
	  		</div>
	  		</c:if>
	  		<c:if test="${st.index % 3 == 2 or st.last}">
    			</div>
  			</c:if>
	  </c:forEach>
      	
    <br>
    <div class="w3-center w3-padding-32">
      <div class="w3-bar">
      	<c:if test="${pageNum >1 }">
      		<a href="javascript:listpage('${pageNum -1 }')" class="w3-bar-item w3-button" style="font-size:20px">&laquo;</a>
      	</c:if>
      	<c:if test="${pageNum <= 1 }">
			<a href="javascript:noPage()" class="w3-bar-item w3-button" style="font-size:20px">&laquo;</a>
		</c:if>
		<c:forEach var="a" begin="${startpage }" end="${endpage }">
			<c:if test="${a==pageNum }"><a href="javascript:listpage('${a }')" class="w3-bar-item w3-button w3-hover-black w3-black	" style="font-size:20px">${a }</a></c:if>
			<c:if test="${a != pageNum }">
				<a href="javascript:listpage('${a }')" class="w3-bar-item w3-button w3-hover-black" style="font-size:20px">${a }</a>
			</c:if>
		</c:forEach>
      	<c:if test="${pageNum < maxpage }">
			<a href="javascript:listpage('${pageNum + 1 }')" class="w3-bar-item w3-button w3-hover-black" style="font-size:20px">&raquo;</a>
		</c:if>
		<c:if test="${pageNum >= maxpage }">
			<a href="javascript:noPage()" class="w3-bar-item w3-button" style="font-size:20px">&raquo;</a>
		</c:if>
      </div>
    </div>
</body>
</html>