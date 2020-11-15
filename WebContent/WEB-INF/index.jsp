<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp" />

<style type="text/css">

	h4.modal-title{
		font-weight: bold;
	}
	
	div#carWrap{
		background-color: #d4d4d4;
	}
	
	div#bestItemWrap{
		background-color: white;
	}
	
	div#footerWrap{
		background-color: #222222;
	}
	
	div#bestItemWrap{
		background-color: #f1f1f1;
	}
	
	div#indexBestItemBox{
		padding: 4% 0;
	}
	
	div#bestItemTitle{
		text-align: center;
		padding-bottom: 4%;
	}
	
	div#bestItemTitle h1{
		font-weight: bold;
	}
	
	div#bestItemTitle p{
		font-style: italic;
		font-weight: bold;
		font-size: 10pt;
	}
	
	div.indexBestItem{
		padding-bottom: 30px;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
	});
	
	function goEventModal(seq_event) {
		
		// 로그인을 하지 않았을 시 거부
		if (${ sessionScope.loginuser.userid == null }) {
			alert("이벤트 참여는 로그인 시에만 가능합니다.");
			return;
		}
		
		// 로그인일 시 모달창으로 정상 이동
		var frm = document.sessionFrm;
		frm.action = "<%= ctxPath %>/product/goJoinEvent.sg";
		frm.method = "GET";
		frm.seq_event.value = seq_event;
		frm.submit();
	}
	
</script>

<form name="sessionFrm">
	<input type="hidden" name="seq_event" value="">
</form>


<div class="totalWrap" id="carWrap">

		  <div id="myCarousel" class="carousel slide" data-ride="carousel">
		    <!-- Indicators -->
		    <ol class="carousel-indicators">

		      <c:forEach var="evo" items="${ eventList }" varStatus="status">
		      	<c:if test="${ status.index == 0 }">
		      		<li data-target="#myCarousel" data-slide-to="${ status.index }" class="active"></li>
		      	</c:if>
		      	
		      	<c:if test="${ status.index != 0 }">
		      		<li data-target="#myCarousel" data-slide-to="${ status.index }"></li>
		      	</c:if>
		      </c:forEach>

		    </ol>
		
		    <!-- Wrapper for slides -->
		    <div class="carousel-inner">

		      <c:forEach var="evo" items="${ eventList }" varStatus="status">
		      	<c:if test="${ status.index == 0 }">
		      	  <div class="item active" onclick="goEventModal('${evo.seq_event}')">
			        <img src="${ evo.carouselimg }" style="width:100%;">
			      </div>
		      	</c:if>
		      	
		      	<c:if test="${ status.index != 0 }">
		      	  <div class="item" onclick="goEventModal('${evo.seq_event}')">
			        <img src="${ evo.carouselimg }" style="width:100%;">
			      </div>
		      	</c:if>
		      </c:forEach>

		    </div>
		    
		
		    <!-- Left and right controls -->
		    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
		      <span class="glyphicon glyphicon-chevron-left"></span>
		      <span class="sr-only">Previous</span>
		    </a>
		    <a class="right carousel-control" href="#myCarousel" data-slide="next">
		      <span class="glyphicon glyphicon-chevron-right"></span>
		      <span class="sr-only">Next</span>
		    </a>
		  </div>
	  

	 </div>

	<%--
  <h3>인기제품</h3><br>
  <div class="row">
    <div class="col-sm-3">
      <p>마우스</p>
      <img src="https://placehold.it/150x80?text=IMAGE" class="img-thumbnail" style="width:100%" alt="Image">
    </div>
    <div class="col-sm-3"> 
      <p>키보드</p>
      <img src="https://placehold.it/150x80?text=IMAGE" class="img-thumbnail" style="width:100%" alt="Image">
    </div>
    <div class="col-sm-3"> 
      <p>헤드셋</p>
      <img src="https://placehold.it/150x80?text=IMAGE" class="img-thumbnail" style="width:100%" alt="Image">
    </div>
    <div class="col-sm-3">
      <p>스피커</p>
      <img src="https://placehold.it/150x80?text=IMAGE" class="img-thumbnail" style="width:100%" alt="Image">
    </div>
  </div>
   --%>
  
  
  <div class="totalWrap" id="bestItemWrap">
	<div id="wrap">
	  
	 <div class="row" id="indexBestItemBox">
	  	<div id="bestItemTitle">
	  		<h1>카테고리별 BEST 3</h1>
	    	<p></p>
	  	</div>
	  
	  	<%-- 가로로 다시 만드는걸 추천 - 테이블사용 --%>
	    <div class="col-sm-3" style="text-align: center; border-right: solid 1px #cccccc; background-color: #d4d4d4">
	      <p style="text-align: center; font-weight: bold; font-size: 12pt;">마우스</p>
	      <br>
	      <div>
      	<div class="indexBestItem" onclick="gotoDetail()">
	    	<div class="eachItemImg">
	    		<img src="https://assets.logitech.com/assets/54686/x300-gallery.png"  class="img-thumbnail" class="img-rounded" style="width:90%;" alt="Image">
	    	</div>				    	
	    	<p class="productId">아이템1</p>
	    	<p class="productName">만암니람지라밎라</p>
	    </div>
	      	<div class="indexBestItem">
	      		<a href="#"><img src="<%= ctxPath %>/images/동원.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>1. 마우스</p></a>
	      	</div>
	      	<div class="indexBestItem">
	      		<a href="#"><img src="<%= ctxPath %>/images/미샤.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>1. 마우스</p></a>
	      	</div>
	      	<div class="indexBestItem">
	      		<a href="#"><img src="<%= ctxPath %>/images/레노보.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>1. 마우스</p></a>
	      	</div>
	      </div>
	    </div>
	    
	    <div class="col-sm-3" style="text-align: center; border-right: solid 1px #cccccc;">
	      <p style="text-align: center; font-weight: bold; font-size: 12pt;">키보드</p>
	      <div>
	      	<a href="#"><img src="<%= ctxPath %>/images/동원.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>1. 키보드</p></a>
	      	<br>
	      	<a href="#"><img src="<%= ctxPath %>/images/미샤.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>2. 키보드</p></a>
	      	<br>
	      	<a href="#"><img src="<%= ctxPath %>/images/레노보.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>3. 키보드</p></a>
	      	<br>
	      </div>
	    </div>
	    
	    <div class="col-sm-3" style="text-align: center; border-right: solid 1px #cccccc;">
	      <p style="text-align: center; font-weight: bold; font-size: 12pt;">헤드셋</p>
	      <div>
	      	<a href="#"><img src="<%= ctxPath %>/images/동원.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>1. 헤드셋</p></a>
	      	<br>
	      	<a href="#"><img src="<%= ctxPath %>/images/미샤.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>2. 헤드셋</p></a>
	      	<br>
	      	<a href="#"><img src="<%= ctxPath %>/images/레노보.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>3. 헤드셋</p></a>
	      	<br>
	      </div>
	    </div>
	    
	    <div class="col-sm-3" style="text-align: center;">
	      <p style="text-align: center; font-weight: bold; font-size: 12pt;">스피커</p>
	      <div>
	      	<a href="#"><img src="<%= ctxPath %>/images/동원.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>1. 스피커</p></a>
	      	<br>
	      	<a href="#"><img src="<%= ctxPath %>/images/미샤.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>2. 스피커</p></a>
	      	<br>
	      	<a href="#"><img src="<%= ctxPath %>/images/레노보.png" class="img-thumbnail" class="img-rounded" style="width:100%;" alt="Image"><p>3. 스피커</p></a>
	      	<br>
	      </div>
	    </div>
	 </div> 
	 
  </div>
 </div>
  
  
  <%-- 아래는 Modal --%>
  
  


<%-- 이벤트 Modal --%>
<div id="eventModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
        <h4 class="modal-title">이벤트 참여</h4>
      </div>
      <div class="modal-body">
      	  <div id="register">
             <iframe style="border: none; width: 100%; height: 500px;" src="<%= ctxPath %>/product/goJoinEvent.sg">
             </iframe>
          </div>
      </div>
    </div>

  </div>
</div>



<jsp:include page="footer.jsp" />




















