<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript">
</script>
<div class="options">
<div class="row mt-3">
	<div class="col" style="font-size: 20px;">${opt_name }</div>
</div>
<div class="row mt-3">
	<div class="col-8">
		<div class="btn-group btn-group-lg" style="width: 150px;">
    		<button type="button" class="btn btn-secondary minus" id="minus">-</button>
    		<input type="number" name="quantity" id="quantityInput" style="width: 55px;" value="1" readonly>
    		<input type="hidden" value="${opt_number }" name="opt_number" id="hiddenOpt_number">
    		<button type="button" class="btn btn-secondary plus" id="plus">+</button>
		</div>
	</div>
	<div class="col-3" style="font-size: 20px;"><fmt:formatNumber value="${discountedPrice}" />원</div>
	<div class="col">
		<button type="button" id="removeBtn" class="btn-close removeBtn" aria-label="Close"></button>
	</div>		
</div>
</div>
<hr>
