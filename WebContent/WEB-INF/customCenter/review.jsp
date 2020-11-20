<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<style type="text/css">

*{margin:0; padding:0;}
	
.star{
  display:inline-block;
  width: 30px;height: 60px;
  cursor: pointer;
}
	
.star_left{
  background: url(http://gahyun.wooga.kr/main/img/testImg/star.png) no-repeat 0 0; 
  background-size: 60px; 
  margin-right: -3px;
}

.star_right{
  background: url(http://gahyun.wooga.kr/main/img/testImg/star.png) no-repeat -30px 0; 
  background-size: 60px; 
  margin-left: -3px;
}

.star.on{
  background-image: url(http://gahyun.wooga.kr/main/img/testImg/star_on.png);
}

		
</style>

<script type="text/javascript">

$(document).ready(function () {
	
	  $(".star").on('click',function(){
		   var idx = $(this).index();
		   $(".star").removeClass("on");
		     for(var i=0; i<=idx; i++){
		        $(".star").eq(i).addClass("on");
		   }
		 });
	
})
</script>


<div class="star-box">
  <span class="star star_left"></span>
  <span class="star star_right"></span>
  <span class="star star_left"></span>
  <span class="star star_right"></span>
  <span class="star star_left"></span>
  <span class="star star_right"></span>
 <span class="star star_left"></span>
 <span class="star star_right"></span>
 <span class="star star_left"></span>
 <span class="star star_right"></span>
</div>

<jsp:include page="../footer.jsp" />




















