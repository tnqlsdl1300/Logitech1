<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>



<!DOCTYPE html>
<html>
<head>


<title>Insert title here</title>


<style type="text/css">

body {
  font-family: Arial;
  margin: 0;
}

* {
  box-sizing: border-box;
}

img {
  vertical-align: middle;
}


.container {
  position: relative;
}


.mySlides {
  display: none;
}


.cursor {
  cursor: pointer;
}

/* Next & previous buttons */
.prev,
.next {
  cursor: pointer;
  position: absolute;
  top: 40%;
  width: auto;
  padding: 16px;
  margin-top: -50px;
  color: white;
  font-weight: bold;
  font-size: 20px;
  border-radius: 0 3px 3px 0;
  user-select: none;
  -webkit-user-select: none;
}


.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

.prev:hover,
.next:hover {
  background-color: rgba(0, 0, 0, 0.8);
}

.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}


.caption-container {
  text-align: center;
  background-color: #222;
  padding: 2px 16px;
  color: white;
}

.row:after {
  content: "";
  display: table;
  clear: both;
}


.column {
  float: left;
  width: 16.66%;
}

.demo {
  opacity: 0.5;
}

.active,
.demo:hover {
  opacity: 1;
}

div#wrap{
		border: solid 0px blue;
		width: 1150px;
		margin: 0 auto;
	}

h{
 font-weight:bold;
}
</style>

<script type="text/javascript">

	
var slideIndex = 1;
showSlides(slideIndex);


function plusSlides(n) {
  showSlides(slideIndex += n);
}// end of


function currentSlide(n) {
  showSlides(slideIndex = n);
} //end of


function showSlides(n) {
  var i;
  
  
  var slides = document.getElementsByClassName("mySlides");
  
  var dots = document.getElementsByClassName("demo");
  
  var captionText = document.getElementById("caption");
  
  if (n > slides.length) {slideIndex = 1}
  
  if (n < 1) {slideIndex = slides.length}
  
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
  }
  
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
  captionText.innerHTML = dots[slideIndex-1].alt;
  
}//end of showSlides(n)---------------------------------------


	
	


</script>
</head>
<body>
<div id ="wrap">

<h2 style="text-align:center">상 품 이 미 지</h2>

<div class="container">
  <div class="mySlides">
    <div class="numbertext">1 / 6</div>
    <img src="https://assets.logitech.com/assets/54721/x50-gallery.png" style="width:100%">
  </div>

  <div class="mySlides">
    <div class="numbertext">2 / 6</div>
    <img src="https://assets.logitech.com/assets/54726/x50-gallery.png" style="width:100%">
  </div>

  <div class="mySlides">
    <div class="numbertext">3 / 6</div>
    <img src="https://assets.logitech.com/assets/54729/x50-gallery.png" style="width:100%">
  </div>
    
  <div class="mySlides">
    <div class="numbertext">4 / 6</div>
    <img src="https://assets.logitech.com/assets/54722/x50-gallery.png" style="width:100%">
  </div>

  <div class="mySlides">
    <div class="numbertext">5 / 6</div>
    <img src="https://assets.logitech.com/assets/54723/x50-gallery.png" style="width:100%">
  </div>
    
  <div class="mySlides">
    <div class="numbertext">6 / 6</div>
    <img src="https://assets.logitech.com/assets/54724/x50-gallery.png" style="width:100%">
  </div>
    
  <a class="prev" onclick="plusSlides(-1)">❮</a>
  <a class="next" onclick="plusSlides(1)">❯</a>

  <div class="caption-container">
    <p id="caption"></p>
  </div>

  <div class="row">
    <div class="column">
      <img class="demo cursor" src="https://assets.logitech.com/assets/54721/x50-gallery.png" style="width:100%" onclick="currentSlide(1)" alt="">
    </div>
    <div class="column">
      <img class="demo cursor" src="https://assets.logitech.com/assets/54726/x50-gallery.png" style="width:100%" onclick="currentSlide(2)" alt="">
    </div>
    <div class="column">
      <img class="demo cursor" src="https://assets.logitech.com/assets/54729/x50-gallery.png" style="width:100%" onclick="currentSlide(3)" alt="">
    </div>
    <div class="column">
      <img class="demo cursor" src="https://assets.logitech.com/assets/54722/x50-gallery.png" style="width:100%" onclick="currentSlide(4)" alt="">
    </div>
    <div class="column">
      <img class="demo cursor" src="https://assets.logitech.com/assets/54723/x50-gallery.png" style="width:100%" onclick="currentSlide(5)" alt="">
    </div>    
    <div class="column">
      <img class="demo cursor" src="https://assets.logitech.com/assets/54724/x50-gallery.png" style="width:100%" onclick="currentSlide(6)" alt="">
    </div>
  </div>
  
  <!-- 상품설명 -->
  <h2 style="font-weight:bold">상품 설명</h2>
  <div >
  
   <img src="https://www.logitech.com/assets/53849/3/x50-wireless-speaker.jpg"/>
   <span><h2 style="font-weight:bold;">Bluetooth 무선 스피커</h2></span>
   <br>
   <span><h4>이제 어디서든 원할 때 음악을 들을 수 있습니다. <br> 블루투스™ 무선 연결은 최대 10미터(30피트)까지 무선의 자유를 선사합니다.</h4></span>
   <br>
  
   <img src="https://www.logitech.com/assets/53849/5/x50-wireless-speaker.jpg"/>
   <span><h2 style="font-weight:bold;">충전식 배터리</h2></span>
   <br>
   <span><h4>한 번 충전으로 최대 5시간 동안 연속해서 플레이할 수 있습니다. . <br> 이 미니 무선 스피커로 계속해서 파티를 즐길 수 있습니다.</h4></span>
   <br>
   
   <img src="https://www.logitech.com/assets/53849/7/x50-wireless-speaker.jpg"/>
   <span><h2 style="font-weight:bold;">보조 입력</h2></span>
   <br>
   <span><h4>블루투스 무선 음악 장치와 페어링하거나 3.5mm 잭을 사용해 다른 플레이어에 연결할 수 있습니다.</h4></span>
   <br>
   
   <img src="https://www.logitech.com/assets/53849/9/x50-wireless-speaker.jpg"/>
   <span><h2 style="font-weight:bold;">컴팩트한 디자인, 커다란 사운드</h2></span>
   <br>
   <span><h4>컴팩트한 크기의 스피커로 크고 선명한 사운드를 경험해 보십시오.</h4></span>
   <br>
 
  
  </div>
  
</div>


</body>
</html>