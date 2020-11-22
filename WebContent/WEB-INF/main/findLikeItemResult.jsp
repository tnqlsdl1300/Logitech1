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

	
	button.choiceBtn{
		width: 270px;
		height: 120px;
		background-color: #919191;
		color: white;
		border-radius: 12px;
		font-size: 20pt;
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
			
			
			<div id="Choice1" class="likeItemChoice">
				<div>
					<button type="button" class="btn btn-default choiceBtn" onclick="goChoice('ch1', 'mouse')"><span>${ pvo.productname }</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="keyboard" onclick="goChoice('ch1', 'keyboard')"><span>키보드</span></button>
				</div>
				<div>
					<button type="button" class="btn btn-default choiceBtn" value="speaker" onclick="goChoice('ch1', 'speaker')"><span>스피커</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="headset" onclick="goChoice('ch1', 'headset')"><span>헤드셋</span></button>
				</div>
			</div>
			
			<div id="Choice2" class="likeItemChoice">
				<div>
					<button type="button" class="btn btn-default choiceBtn" onclick="goChoice('ch2', '사무용')"><span>사무용</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="keyboard" onclick="goChoice('ch2', '가정용')"><span>가정용</span></button>
				</div>
				<div>
					<button type="button" class="btn btn-default choiceBtn" value="speaker" onclick="goChoice('ch2', '게이밍')"><span>게이밍</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="headset" onclick="goChoice('ch2', '교육용')"><span>교육용</span></button>
				</div>
			</div>
			
			<div id="Choice3" class="likeItemChoice">
				<div>
					<button type="button" class="btn btn-default choiceBtn" onclick="goChoice('ch3', 'USB 수신기')"><span>USB 수신기</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="keyboard" onclick="goChoice('ch3', '블루투스')"><span>블루투스</span></button>
				</div>
				<div>
					<button type="button" class="btn btn-default choiceBtn" value="speaker" onclick="goChoice('ch3', '유선')"><span>유선</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="headset" onclick="goChoice('ch3', '복합수신기')"><span>복합수신기</span></button>
				</div>
			</div>

	
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />