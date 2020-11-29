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
		min-height: 900px;
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
	
	h2.qnaText{
		color: #34495e;
		font-weight: bold;
		padding: 1% 0;
	}
	
	div.likeItemChoice{
		border: solid 0px red;
		display: inline-block;
		margin-top: 3%;
		text-align: left;
	}
	
	div.imgBackground{
		padding: 30px;
		border: solid 0px red;
		background-color: #d4d4d4;
	}
	
	div.contentText{
		border: solid 0px red;
		padding: 40px;
	}
	
	div.contentText p{
		font-size: 15pt;
		padding-bottom: 1%;
	}
	
	div.btnGroup{
		margin-top: 25%;
	}

	
	a.choiceBtn{
		border: solid 1px gray;
		background-color: #47555e;
		color: white;
		border-radius: 12px;
		font-size: 15px;
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
	  color: #f1c40f;
	}
	
	.choiceBtn:hover span {
	  padding-right: 25px;
	  color: #f1c40f;
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
	
	function reTest() {
		location.href="<%= request.getContextPath() %>/product/findLikeItem.sg";
	}
	

</script>

<%-- 취향 맞춤 추천 --%>
<div class="totalWrap" id="bestItemWrap" onclick="findLikeItem()" style="background-color: #34495e; height: 100px;">
	<div id="wrap" style="text-align: center;">
		<h2 style="padding: 0; padding-top: 2%; margin: 0; font-weight: bold; color: #f1c40f;">SquadG Teller</h2>
		<h5 style="padding: 0; padding-top: 1%; margin: 0; color: #f1c40f;">주변기기 추천서비스</h5>
	</div>
</div>

<div class="totalWrap" id="likeItemWrap">
	<div id="wrap">
		<div class="innerContainer" id="likeItemContainer">
			
			
			<div id="qnaBox">
				<c:if test="${ sessionScope.loginuser == null }">
					<h2 id="qna1" class="qnaText">고객님의 검색결과는..</h2>
				</c:if>
				<c:if test="${ sessionScope.loginuser != null }">
					<h2 id="qna1" class="qnaText">"${ sessionScope.loginuser.name }"님의 검색결과는..</h2>
				</c:if>
			</div>
			
			
			<hr style="border-top: 4px dashed #34495e;">
			
			<c:if test="${ pvo == null }">
				<div id="likeItemChoice" class="likeItemChoice" style="display: block;">
					<div class="well" style="text-align: center; padding: 10%; width: 100%">
					
						<h1 class="media-heading" style="font-weight: bold;">검색결과가 없습니다.</h1>
						<br><br>
						<div class="btn-group btnGroup" style="margin: 0;">
							  <a href="#" class="btn choiceBtn" onclick="reTest()" style="font-size: 15pt; width: 200px; height: 50px;"><span>테스트 다시 하기</span></a>
						</div>
						
					</div>
				</div>
			</c:if>
			
			
			<c:if test="${ pvo != null }">
				<div id="likeItemChoice" class="likeItemChoice">
				
					<div class="well">
					    <div class="media-left imgBackground">
					      <img src="${ pvo.imgfilename }" class="media-object" style="width:500px">
					    </div>
					    <div class="media-body contentText">
					      <h1 class="media-heading" style="font-weight: bold;">${ pvo.productid }</h1>
					      <br>
					      <h2 class="media-heading" style="font-size: 20pt;">${ pvo.productname }</h2>
					      <hr style="border: solid 1px #34495e">
					      <br>
					      <p>카테고리: ${ pvo.fk_category }</p>
					      <p>특징: ${ pvo.character }</p>
					      <p>가격: <fmt:formatNumber value="${pvo.price}" pattern="###,###" />원</p>
					      
							<div class="btn-group btn-group-justified btnGroup">
							  <a href="#" class="btn choiceBtn" onclick="gotoDetail('${ pvo.productid }')"><span>상세페이지로<br>이동</span></a>
							  <a href="#" class="btn choiceBtn" onclick="reTest()"><span>테스트 다시 하기</span></a>
							</div>

					    </div>
					</div>
					
				</div>
			</c:if>
			
			
			
			

	
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />