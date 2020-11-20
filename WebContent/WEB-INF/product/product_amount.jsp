<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% String ctxPath = request.getContextPath(); %>
<html>
<head>
	<title>BLUEB</title>
</head>

<body onload="init();">
<script language="JavaScript">

var product_price;
var amount;

function init () {
	product_price = document.CarcFrm.product_price.value;
	
	amount = document.CarcFrm.amount.value;
	
	document.CarcFrm.sum.value = product_price;
	
	change();
	
}// -------------------------------------------------


function add () { //수량+
	hm = document.CarcFrm.amount;
	
	sum = document.CarcFrm.sum;
	
	hm.value ++ ;

	sum.value = parseInt(hm.value) * product_price;
	
}// -------------------------------------------------

function del () { //수량-
	
	hm = document.CarcFrm.amount;
	
	sum = document.CarcFrm.sum;
	
		if (hm.value > 1) {
			hm.value -- ;
			sum.value = parseInt(hm.value) * product_price;
			
		}
}// -------------------------------------------------

function change () {
	
	hm = document.CarcFrm.amount;
	
	sum = document.CarcFrm.sum;

		if (hm.value < 0) {
			hm.value = 0;
		}
		
	sum.value = parseInt(hm.value) * product_price;
	
}// -------------------------------------------------


</script>

<form name="CarcFrm" method="get">

<input type="hidden" name="product_price" value="${rProductVO.price}">

수량 : <input type="text" name="amount" id="amount" value="1" size="15" onchange="change();">  
<input type="button" value=" + " onclick="add();">
<input type="button" value=" - " onclick="del();"><br>

합계 : <input type="text" id="CarcSum" name="sum" size="20"  value="priceSum" readonly>
</form>

</body>