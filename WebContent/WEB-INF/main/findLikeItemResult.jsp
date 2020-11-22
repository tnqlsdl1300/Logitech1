<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<style>
	
	div#likeItemWrap{
		background-color: #f6f6f6;	
		min-height: 1000px;
		height: auto;
	}
	
	div#wrap{
		text-align: center;
	}
	
	div#likeItemContainer{
		width: 100%;
		padding: 3% 0;
	}
	
	div#qnaBox{
		text-align: left;
	}
	
	h1#likeItemTitle{
		font-weight: bold;
		padding: 1% 0;
	}
	
	div.likeItemChoice{
		border: solid 0px red;
		display: inline-block;
		text-align: left;
	}
	
	div.imgBackground{
		border: solid 0px red;
		background-color: #d4d4d4;
	}

	
	button.choiceBtn{
		width: 100px;
		height: 50px;
		background-color: #919191;
		color: white;
		border-radius: 12px;
		font-size: 10px;
		transition: all 0.5s;
		cursor: pointer;
		margin: 5px;
		outline: none;	<%-- 끝까지 안들어가면 button 태그에 직접 넣기 --%>
	}
	
	.choiceBtn span {
	  cursor: pointer;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	.choiceBtn span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	}
	
	.choiceBtn:hover span {
	  padding-right: 25px;
	}
	
	.choiceBtn:hover span:after {
	  opacity: 1;
	  right: 0;
	}

	
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		
		
	});
	
	function gotoDetail(proid) {
		location.href="<%= request.getContextPath() %>/product/productviewpage.sg?productid=" + proid;
	}
	

</script>

<%-- 취향 맞춤 추천 --%>
<div class="totalWrap" id="bestItemWrap" style="background-color: #00ead0; height: 100px;">
	<div id="wrap" style="text-align: center;">
		<h3 style="padding: 0; padding-top: 3%; margin: 0; font-weight: bold;">취향 맞춤 추천</h3>
	</div>
</div>

<div class="totalWrap" id="likeItemWrap">
	<div id="wrap">
		<div class="innerContainer" id="likeItemContainer">
			
			
			<div id="qnaBox">
				<c:if test="${ sessionScope.loginuser == null }">
					<h2 id="qna1" class="qnaText">고객님의 검색결과는!!</h2>
				</c:if>
				<c:if test="${ sessionScope.loginuser != null }">
					<h2 id="qna1" class="qnaText">"${ sessionScope.loginuser.name }"님의 검색결과는!!</h2>
				</c:if>
			</div>
			
			
			<hr style="border-top: 4px dashed black;">
			
			<c:if test="${ pvo == null }">
				검색결과 없음
			</c:if>
			
			
			<c:if test="${ pvo != null }">
				<div id="likeItemChoice" class="likeItemChoice">
				
					<div class="well">
					    <div class="media-left imgBackground">
					      <img src="${ pvo.imgfilename }" class="media-object" style="width:500px">
					    </div>
					    <div class="media-body well-lg">
					      <h1 class="media-heading">${ pvo.productid }</h1>
					      <h1 class="media-heading">${ pvo.productname }</h1>
					      <p>카테고리: ${ pvo.fk_category }</p>
					      <p>특징: ${ pvo.character }</p>
					      <p>가격: <fmt:formatNumber value="${pvo.price}" pattern="###,###" />원</p>
					      
					      <button type="button" class="btn btn-default choiceBtn" onclick="gotoDetail('${ pvo.productid }')"><span>상세페이지로<br>이동</span></button>
					    </div>
					</div>
					
				</div>
			</c:if>
			
			
			
			

	
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />