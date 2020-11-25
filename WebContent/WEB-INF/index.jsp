<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	
	div#bestCategoryItemWrap{
		background-color: white;
	}
	
	div#footerWrap{
		background-color: #222222;
	}
	
	div#bestCategoryItemWrap{
		background-color: #ecebe9;
	}
	
	div.bestItemBox{
		padding:0;
		margin:0;
		border: solid 0px red;
		margin-top: 10%;
	}
	
	div#bestItemTitle{
		text-align: center;
		padding: 0;
		padding-top: 7%;
	}
	
	div#bestItemTitle h1{
		color: #464d5c;
		font-size: 33pt;
	}
	
	h2.categoryTitle{
		border: solid 0px red;
		color: #3c414b;
		font-size: 33pt;
	}
	
	div.categoryTitleBox{
		text-align: center;
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
	
	div.eachItemImg img{
		background-color: #f6f6f6;
		width:80%;
	}
	
	.img-thumbnail{
		border: solid 0px #34495e;
	}
	
	div.indexBestItemText{
		text-align: left;
		margin-top: 2%;
		margin-left: 10%;
	}
	
	p.productId{
		font-weight: bold;
		font-size: 18pt;
	}
	
	p.productName{
		font-style: italic;
		padding:0;
		margin: 0;
		padding-bottom: 1%;
	}
	
	p.productPrice{
		font-weight: bold;
	}

	.equal {
	  display: flex;
	  display: -webkit-flex;
	  flex-wrap: wrap;
	} 
	
	.eachItemBox{
		text-align: center;
		border: solid 0px black;
		padding: 0;
		margin: 0;
		margin-bottom: 2%;
	}
	
	.indexBestItem > .rankText{
		background-color: #47555e;
		padding: 1% 0;
		color: #e4e4e4;
		font-size: 15pt;
		margin: 0;
		margin-left: 10%;
		margin-right: 10%;
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
	
	// 검색한 제품을 클릭시 상세 페이지로 이동하는 함수
	function gotoDetail(proid) {
		location.href="<%= request.getContextPath() %>/product/productviewpage.sg?productid=" + proid;
	}
	
	// 취향 맞춤 추천 페이지로 이동하는 버튼
	function findLikeItem() {
		location.href="<%= request.getContextPath() %>/product/findLikeItem.sg"
	}
	
	
	
</script>

<form name="sessionFrm">
	<input type="hidden" name="seq_event" value="">
</form>

	<%-- 전체 Best3 --%>
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
			        <img src="${ evo.carouselimg }" style="width:100%; cursor: pointer;">
			        <div class="carousel-caption">
				        <h3>${ evo.eventname }</h3>
				        <p>${ evo.startday } ~ ${ evo.endday }</p>
		     		</div>
			      </div>
			      
		      	</c:if>
		      	
		      	<c:if test="${ status.index != 0 }">
		      	  <div class="item" onclick="goEventModal('${evo.seq_event}')">
			          <img src="${ evo.carouselimg }" style="width:100%; cursor: pointer;">
				      <div class="carousel-caption">
				        <h3>${ evo.eventname }</h3>
				        <p>${ evo.startday } ~ ${ evo.endday }</p>
				      </div>
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

	<%-- 취향 맞춤 추천 --%>
	<div class="totalWrap" id="bestItemWrap" onclick="findLikeItem()" style="background-color: #34495e; height: 100px; cursor: pointer;">
		<div id="wrap" style="text-align: center;">
			<h2 style="padding: 0; padding-top: 2%; margin: 0; font-weight: bold; color: #f1c40f;">SquadG Teller</h2>
			<h5 style="padding: 0; padding-top: 1%; margin: 0; color: #f1c40f;">주변기기 추천서비스</h5>
		</div>
	</div>
	
  
  <%-- 카테고리별 Best3 --%>
  <div class="totalWrap" id="bestCategoryItemWrap">
	<div id="wrap">
	  
	 <div class="row" id="indexBestItemBox">
	  	<div id="bestItemTitle">
	  		<h1>Best3 by Category</h1>
	  	</div>
	  	
	  	<hr style="border: solid 1px #464d5c; width: 35%;">

		
	   
	    
	  	<div class="bestItemBox"> 
		  	<div class="categoryTitleBox">
				<h2 class="categoryTitle">Mouse</h2>
				<hr style="border: solid 1px #464d5c; margin-top: -0.5%; width: 13%;">
			</div>
	 		<c:forEach var="mousevo" items="${ mouseList }" varStatus="status">
	 			<div class="col-md-4 eachItemBox">
		     		<div class="indexBestItem" onclick="gotoDetail('${ mousevo.productid }')">
		     			<div class="rankText">${ status.count }위</div>
				    	<div class="eachItemImg">
				    		<img src="${ mousevo.imgfilename }"  class="img-thumbnail" alt="Image">
				    	</div>	
				    	<div class="indexBestItemText">			    	
					    	<p class="productId">${ mousevo.productid }</p>
					    	<p class="productName">${ mousevo.productname }</p>
					    	<p class="productPrice"><fmt:formatNumber value="${ mousevo.price }" pattern="###,###" />원</p>
				    	</div>
				    </div>
	     		</div>
	 		</c:forEach>
	   </div>
	   
	   <%-- 키보드 --%>
	   
	   <div class="bestItemBox"> 
		  	<div class="categoryTitleBox">
				<h2 class="categoryTitle">Speaker</h2>
				<hr style="border: solid 1px #464d5c; margin-top: -0.5%; width: 13%;">
			</div>
	 		<c:forEach var="speakervo" items="${ speakerList }" varStatus="status">
	 			<div class="col-md-4 eachItemBox">
		     		<div class="indexBestItem" onclick="gotoDetail('${ speakervo.productid }')">
		     			<div class="rankText">${ status.count }위</div>
				    	<div class="eachItemImg">
				    		<img src="${ speakervo.imgfilename }"  class="img-thumbnail" alt="Image">
				    	</div>	
				    	<div class="indexBestItemText">			    	
					    	<p class="productId">${ speakervo.productid }</p>
					    	<p class="productName">${ speakervo.productname }</p>
					    	<p class="productPrice"><fmt:formatNumber value="${ speakervo.price }" pattern="###,###" />원</p>
				    	</div>
				    </div>
	     		</div>
	 		</c:forEach>
	   </div>
	   
	   <div class="bestItemBox"> 
		  	<div class="categoryTitleBox">
				<h2 class="categoryTitle">Headset</h2>
				<hr style="border: solid 1px #464d5c; margin-top: -0.5%; width: 13%;">
			</div>
	 		<c:forEach var="headsetvo" items="${ headsetList }" varStatus="status">
	 			<div class="col-md-4 eachItemBox">
		     		<div class="indexBestItem" onclick="gotoDetail('${ headsetvo.productid }')">
		     			<div class="rankText">${ status.count }위</div>
				    	<div class="eachItemImg">
				    		<img src="${ headsetvo.imgfilename }"  class="img-thumbnail" alt="Image">
				    	</div>	
				    	<div class="indexBestItemText">			    	
					    	<p class="productId">${ headsetvo.productid }</p>
					    	<p class="productName">${ headsetvo.productname }</p>
					    	<p class="productPrice"><fmt:formatNumber value="${ headsetvo.price }" pattern="###,###" />원</p>
				    	</div>
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




















