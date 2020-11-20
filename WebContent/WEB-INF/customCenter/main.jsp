<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 


<%
	String ctxPath = request.getContextPath();
%>


<jsp:include page="../header.jsp" />

<div class="container">

	<div style="width: 100%; margin: 0 auto;">
	  <div id="myCarousel" class="carousel slide" data-ride="carousel">
	    <!-- Indicators -->
	    <ol class="carousel-indicators">
	      
	      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	      <li data-target="#myCarousel" data-slide-to="1"></li>
	      <li data-target="#myCarousel" data-slide-to="2"></li>
	      <li data-target="#myCarousel" data-slide-to="3"></li>
	      
	      <%--
	      <c:forEach var="imgList" items="${ imgList }" varStatus="status">
	      	<c:if test="${ status.index == 0 }">
	      		<li data-target="#myCarousel" data-slide-to="${ status.index }" class="active"></li>
	      	</c:if>
	      	
	      	<c:if test="${ status.index != 0 }">
	      		<li data-target="#myCarousel" data-slide-to="${ status.index }"></li>
	      	</c:if>
	      </c:forEach>
	      --%>
	    </ol>
	
	    <!-- Wrapper for slides -->
	    <div class="carousel-inner">
	      
	      <div class="item active">
	        <img src="<%= ctxPath %>/images/동원.png" alt="야외 풀장" style="width:100%;">
	      </div>
	
	      <div class="item">
	        <img src="<%= ctxPath %>/images/레노보.png" alt="디럭스룸" style="width:100%;">
	      </div>
	    
	      <div class="item">
	        <img src="<%= ctxPath %>/images/미샤.png" alt="레스토랑" style="width:100%;">
	      </div>
	      
	      <div class="item">
	        <img src="<%= ctxPath %>/images/원더플레이스.png" alt="레스토랑" style="width:100%;">
	      </div>
	      
	      <%-- 
	      <c:forEach var="imgvo" items="${ imgList }" varStatus="status">
	      	<c:if test="${ status.index == 0 }">
	      	  <div class="item active">
		        <img src="<%= ctxPath %>/images/${ imgvo.imgfilename }" style="width:100%;">
		      </div>
	      	</c:if>
	      	
	      	<c:if test="${ status.index != 0 }">
	      	  <div class="item">
		        <img src="<%= ctxPath %>/images/${ imgvo.imgfilename }" style="width:100%;">
		      </div>
	      	</c:if>
	      </c:forEach>
	      	--%>
	      	
	      	
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
	  
	  

	
  <h3>인기제품</h3><br>
  <div class="row">
    <div class="col-sm-3">
      <p>마우스</p>
      <img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image">
    </div>
    <div class="col-sm-3"> 
      <p>키보드</p>
      <img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image">
    </div>
    <div class="col-sm-3"> 
      <p>헤드셋</p>
      <img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image">
    </div>
    <div class="col-sm-3">
      <p>스피커</p>
      <img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image">
    </div>
  </div>
	
	
	
</div>

<jsp:include page="../footer.jsp" />




















