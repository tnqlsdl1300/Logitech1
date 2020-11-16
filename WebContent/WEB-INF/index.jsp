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
		
	}
	
	div#bestItemTitle{
		text-align: center;
		padding: 0;
		padding-top: 1%;
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
		padding: 0;
		margin: 0;
		cursor: pointer;
	}
	
	div.testItem{
		border: solid 1px red;
		float: left;
	}
	
	.equal {
	  display: flex;
	  display: -webkit-flex;
	  flex-wrap: wrap;
	}
	
	.eachItemBox{
		border: solid 1px black;
		padding: 0;
		margin: 0;
		margin-bottom: 2%;
	}
	
	.indexBestItem > .rankText{
		color: red;
		font-size: 15pt;
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
	
	// 제품상세 페이지로 이동하는 함수
	function gotoDetail(productid) {
		alert(productid);
		location.href="productviewpage.sg?productid=" + productid;
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
   <%-- 여기 --%>
	
  
  
  <div class="totalWrap" id="bestItemWrap">
	<div id="wrap">
	  
	 <div class="row" id="indexBestItemBox">
	  	<div id="bestItemTitle">
	  		<h1>카테고리별 BEST 3</h1>
	    	<p></p>
	  	</div>
	  	
	  	<h2>스피커</h2>
	  	<div class="bestItemBox" style="border: solid 0px red;"> 
	 		<c:forEach var="speakervo" items="${ speakerList }" varStatus="status">
	 			<div class="col-md-4 eachItemBox" style="text-align: center; border-right: solid 1px #cccccc; background-color: #d4d4d4">
		     		<div class="indexBestItem" onclick="gotoDetail('${ speakervo.productid }')">
		     			<label class="rankText">${ status.count }위</label>
		     			<hr style="margin: 0; padding: 0;">
				    	<div class="eachItemImg" style="margin: 0; padding: 0;">
				    		<img src="${ speakervo.imgfilename }" class="img-thumbnail" style="width:90%; height: 280px;" alt="Image">
				    	</div>				    	
				    	<p class="productId">${ speakervo.productid }</p>
				    	<p class="productName">${ speakervo.productname }</p>
				    </div>
	     		</div>
	 		</c:forEach>
	   </div>
	   
	   <h2>마우스</h2>
	  	<div class="bestItemBox"> 
	 		<c:forEach var="mousevo" items="${ mouseList }" varStatus="status">
	 			<div class="col-md-4 eachItemBox" style="text-align: center; border-right: solid 1px #cccccc; background-color: #d4d4d4">
		     		<div class="indexBestItem" onclick="gotoDetail('${ mousevo.productid }')">
		     			<label class="rankText">${ status.count }위</label>
		     			<hr style="margin: 0; padding: 0;">
				    	<div class="eachItemImg">
				    		<img src="${ mousevo.imgfilename }"  class="img-thumbnail" style="width:90%; height: 300px;" alt="Image">
				    	</div>				    	
				    	<p class="productId">${ mousevo.productid }</p>
				    	<p class="productName">${ mousevo.productname }</p>
				    </div>
	     		</div>
	 		</c:forEach>
	   </div>
	   
	   <%-- DB에 데이터를 모두 넣은 뒤 헤드셋, 키보드 까지 넣으면 됨 --%>
	   
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




















