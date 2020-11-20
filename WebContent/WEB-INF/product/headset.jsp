<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<jsp:include page="../header.jsp"/>

<style type="text/css">
@CHARSET "UTF-8";

 * {
    box-sizing: border-box;
} 
body {
    font-family: Arial;
    
    background: #f1f1f1;
}
/* 헤더 타이틀 */
.header {
    padding: 30px;
    text-align: center;
    background: white;
}
.header h1 {
    font-size: 50px;
}
/* 탑 네비게이션 바 */
.topnav {
    overflow: hidden;
    background-color: #333;
}
/*탑 링크*/
.topnav a {
    float: left;
    display: block;
    color: #f2f2f2;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}
/* 호버 */
.topnav a:hover {
    background-color: #ddd;
    color: black;
}

/* 완쪽 컬럼 */
.leftcolumn {   
    float: left;
    width: 25%;
}
/* 오른쪽 컬럼 */
.rightcolumn {
    float: left;
    width: 75%;
    background-color: #f1f1f1;
    padding-left: 20px;
}
/* 임시 명암표시 */
.fakeimg {
    background-color: #aaa;
    width: 100%;
    padding: 20px;
}

.card {
    background-color: white;
    padding: 20px;
    margin-top: 20px;
}

.row:after {
    content: "";
    display: table;
    clear: both;
}

.footer {
    padding: 20px;
    text-align: center;
    background: #ddd;
    margin-top: 20px;
}

@media screen and (max-width: 800px) {
    .leftcolumn, .rightcolumn {   
        width: 100%;
        padding: 0;
    }
}

@media screen and (max-width: 400px) {
    .topnav a {
        float: none;
        width: 100%;
    }
}



</style>




 
 <div id="myCarousel" class="carousel slide" data-ride="carousel">
    
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
      <li data-target="#myCarousel" data-slide-to="3"></li>
    </ol>

    
    <div class="carousel-inner">
      <div class="item active">
        <img src="/Logitech/images/mousemain.png" alt="mouse" style="width:100%;">
      </div>

      <div class="item">
        <img src="/Logitech/images/keyboardmain.png" alt="keyboard" style="width:100%;">
      </div>
    
      <div class="item">
        <img src="/Logitech/images/headsetmain.png" alt="headset" style="width:100%;">
      </div>
      
      <div class="item">
        <img src="/Logitech/images/speakermain.png" alt="headset" style="width:100%;">
      </div>
    </div>

    
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
<!-- <div class="topnav">
  <a href="#">홈</a>
  <a href="#">제품</a>
  <a href="#">링크</a>
   <a href="#" style="float:right"></a>
</div> -->

 
<div class="totalWrap">
<div id="wrap">
		
<jsp:include page="productfilter.jsp"/>

</div>
</div>
<jsp:include page="../footer.jsp"/>