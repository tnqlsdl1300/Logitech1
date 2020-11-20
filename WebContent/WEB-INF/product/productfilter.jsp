<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<!DOCTYPE html>
<html>
<head>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

<title>Insert title here</title>



<style type="text/css">

* {
  box-sizing: border-box;
}

body {
  background-color: #f1f1f1;
  
  font-family: Arial;
}


.main {
  max-width: 1000px;
  margin: auto;
}

h1 {
  font-size: 50px;
  word-break: break-all;
}

.row {
  margin: 8px -16px;
}


.row,
.row > .column {
  padding: 20px;
}


.column {
  float: left;
  width: 33.33%;
  display: none; 
}


.row:after {
  /* content: ""; */
  display: table;
  clear: both;
}


.content {
  background-color: white;
  padding: 30px;
  
  
  
}


  /* .show {
  display: block;
}   */


.btn {
  border: none;
  outline: none;
  padding: 12px 16px;
  background-color: white;
  cursor: pointer;
}


.btn:hover {
  background-color: #ddd;
}


.btn.active {
  background-color: #666;
   color: white;
   
}

 img.img{
	width:280px;
	height:280px;
}

 img.img:hover{
	cursor: pointer;
	background-color: SlateBlue;
} 

</style>

<script type="text/javascript">


 $(document).ready(function() {
   
	
	 <%--
	 $("button#goPurchase").click(function(){
			
		 	   if($("select#selectColor").val() == ""){
		 		
		 		alert('색상을 선택해주세요!!');
		 		return;
		 	}
		 	if($("select#selectColor").val() != ""){
		 		var color = $("#selectColor option:selected").val();
				// alert(color);
				$("input#color").val(color);
				alert(color);
		 		var frm = document.selectColor;
				frm.action = "<%= ctxPath%>/product/purchasedetail.sg"; 
				frm.method = "POST";
				frm.submit();
		 	}  
		 	
			
			}); 
	 --%>
	 
	 
	 
	 
   $("button.btn").click(function(){
      
     
   });// end of $("button.btn").click(function(){})-------------------------
   
   
    $("button.btn").eq(0).trigger("click");
    
}); // end of $(document).ready(function(){ })-------------------




filterSelection("all") 

function filterSelection(c) {
	
  var x, i;
  x = document.getElementsByClassName("column");
  if (c == "all") c = "";
  
  for (i = 0; i < x.length; i++) {
    RemoveClass(x[i], "show");
    if (x[i].className.indexOf(c) > -1) AddClass(x[i], "show");
    
  }
  
  
}


//애드클래스

function AddClass(element, name) {
  var i, arr1, arr2;
  arr1 = element.className.split(" ");
  arr2 = name.split(" ");
  for (i = 0; i < arr2.length; i++) {
    if (arr1.indexOf(arr2[i]) == -1) {
      element.className += " " + arr2[i];
    }
  }
}

//리무브 클래스

function RemoveClass(element, name) {
	
  var i, arr1, arr2;
  arr1 = element.className.split(" ");
  arr2 = name.split(" ");
  for (i = 0; i < arr2.length; i++) {
    while (arr1.indexOf(arr2[i]) > -1) {
      arr1.splice(arr1.indexOf(arr2[i]), 1);
    }
  }
  element.className = arr1.join(" ");
}

//버튼

var btnContainer = document.getElementById("myBtnContainer");

var btns = btnContainer.getElementsByClassName("btn");
for (var i = 0; i < btns.length; i++) { 
  btns[i].addEventListener("click", function(){
    var current = document.getElementsByClassName("active");
    current[0].className = current[0].className.replace(" active ", "");
    this.className += " active ";
  });
  
  
} 


</script>
</head>
<body>
<br>
<h2 style="font-weight:bold; color:navy; text-align:center;">로지텍의 제품을 둘러보세요.</h2>
<br>

<div id="myBtnContainer">
  <button class="btn active" onclick="filterSelection('all')"> 전체</button>
  <button class="btn" onclick="filterSelection('a')"> 유선</button>
  <button class="btn" onclick="filterSelection('b')"> 무선</button>
   
</div>

	
			
			
			

 <%-- <div class="row">
  <c:forEach var="pvo" items="${productList}">
  
  </c:forEach> 
	  <div class="column a">
	    <div class="content">
	      <a href="javascript:location.href='/Logitech/productsingle.sg?productid=${pvo.fk_category}'"> <!-- <img src="https://assets.logitech.com/assets/54721/x50-gallery.png" alt="Lights" style="width:100%"> --> </a>
		  <img class="img" src="${rProductVO.imgfilename}" onclick="javascript:location.href='productviewpage.sg?productid=${rProductVO.productid}'" />
	     
	      <h3 style="text-align:center; font-weight:bold;">${rProductVO.productname}</h3>
	       
	      <h4 style="text-align:center; font-weight:bold;"><fmt:formatNumber value="${rProductVO.price}" pattern="###,###" />원</h4>
	    </div>
      </div> --%>
      
      
 
 

<form name ="">
<div class="row">
  <c:forEach var="pvo" items="${productList}">
	  <div class="column a">  
	    <div class="content">
	      <!-- <a href ="javascript:location.href='/Logitech/productsingle.sg'"> -->
	      <a href="javascript:location.href='/Logitech/productsingle.sg?productid=${pvo.fk_category}'"> <!-- <img src="https://assets.logitech.com/assets/54721/x50-gallery.png" alt="Lights" style="width:100%"> --> </a>
	      
	      <img class="img" src="${pvo.imgfilename}" onclick="javascript:location.href='productviewpage.sg?productid=${pvo.productid}'" /> 
	      
	      <h4 style="text-align:center;">${pvo.productid}</h4>
	      <p style="text-align:center;"><fmt:formatNumber value="${pvo.price}" pattern="###,###" />원</p>
	      
	    </div>
	  </div>
  </c:forEach>
 </div> 
 </form>


<%-- <div class="row">
  
  <c:forEach var="pvo" items="${productList}">
  <div class="column b">  
    <div class="content">
    
      <a href="javascript:location.href='/Logitech/productsingle.sg?productid=${pvo.fk_category}'"> <!-- <img src="https://assets.logitech.com/assets/54721/x50-gallery.png" alt="Lights" style="width:100%"> --> </a>
      <img class="img" src="${pvo.imgfilename}" />
      
      <h4 style="text-align:center;">${pvo.productid}</h4> 
      <p style="text-align:center;">${pvo.price}</p>
    </div>
   
  
  </div>
    </c:forEach>
 </div>  --%>
 
 
 
 
 
 <!--  <div class="row">
   <div class="column nature">
    <div class="content">
    
     <a href="#"> <img src="https://assets.logitech.com/assets/54721/x50-gallery.png" alt="Lights" style="width:100%"> </a>
      <h4 style="text-align:center;">제품명</h4>
      <p style="text-align:center;">35,000원</p>
    </div>
  </div>
  <div class="column nature">
    <div class="content">
      <a href="#"> <img src="https://assets.logitech.com/assets/54721/x50-gallery.png" alt="Ligehts" style="width:100%"> </a>
      <h4 style="text-align:center;">제품명</h4>
      <p style="text-align:center;">35,000원</p>
    </div>
  </div>

  <div class="column cars">
    <div class="content">
      <a href="#"> <img src="https://assets.logitech.com/assets/54722/x50-gallery.png" alt="Lights" style="width:100%"> </a>
      <h4 style="text-align:center;">제품명</h4>
      <p style="text-align:center;">35,000원</p>
    </div>
  </div>
  <div class="column cars">
    <div class="content">
      <a href="#"> <img src="https://assets.logitech.com/assets/54722/x50-gallery.png" alt="Lights" style="width:100%"> </a>
      <h4 style="text-align:center;">제품명</h4>
      <p style="text-align:center;">35,000원</p>
    </div>
  </div>
  <div class="column cars">
    <div class="content">
      <a href="#"> <img src="https://assets.logitech.com/assets/54722/x50-gallery.png" alt="Lights" style="width:100%"> </a>
      <h4 style="text-align:center;">제품명</h4>
      <p style="text-align:center;">35,000원</p>
    </div>
  </div>

  <div class="column people">
    <div class="content">
      <a href="#"> <img src="https://assets.logitech.com/assets/54725/x50-gallery.png" alt="Lights" style="width:100%"> </a>
      <h4 style="text-align:center;">제품명</h4>
      <p style="text-align:center;">35,000원</p>
    </div>
  </div>
  <div class="column people">
    <div class="content">
      <a href="#"> <img src="https://assets.logitech.com/assets/54725/x50-gallery.png" alt="Lights" style="width:100%"> </a>
      <h4 style="text-align:center;">제품명</h4>
      <p style="text-align:center;">35,000원</p>
    </div>
  </div>
  <div class="column people">
    <div class="content">
      <a href="#"> <img src="https://assets.logitech.com/assets/54725/x50-gallery.png" alt="Lights" style="width:100%"> </a>
      <h4 style="text-align:center;">제품명</h4>
      <p style="text-align:center;">35,000원</p>
    </div>
  </div>  
 -->  
  
<!-- END GRID -->
</div>

</body>
</html>