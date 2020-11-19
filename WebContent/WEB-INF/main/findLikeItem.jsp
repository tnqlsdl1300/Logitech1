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
		
		// 1번 외에 다른 질문, 버튼을 안보이게 하기
		allHide();
		
		
		$("h2#qna1").show();
		$("div#Choice1").show();
		
	});
	
	function goChoice(whatCh, val) {
		
		var ans1 = "";
		var ans2 = "";
		var ans3 = "";
		
		if (whatCh == "ch1") {
			ans1 = val;
			allHide();
			$("h2#qna2").show();
			$("div#Choice2").show();
		}
		
		if (whatCh == "ch2") {
			ans2 = val;
			allHide();
			$("h2#qna3").show();
			$("div#Choice3").show();
		}
		
		if (whatCh == "ch3") {
			ans3 = val;
			allHide();
			$("h2#qna3").show();
			$("div#Choice3").show();
			
			// ans1,2  값이 들어오지 않음
			console.log("ans1: " + ans1);
			console.log("ans2: " + ans2);
			console.log("ans3: " + ans3);
		}
		
	}
	
	function allHide() {
		$("h2.qnaText").hide();
		$("div.likeItemChoice").hide();
	}

</script>

<%-- 취향 맞춤 추천 --%>
<div class="totalWrap" id="bestItemWrap" onclick="findLikeItem()" style="background-color: #00ead0; height: 100px; cursor: pointer;">
	<div id="wrap" style="text-align: center;">
		<h3 style="padding: 0; padding-top: 3%; margin: 0; font-weight: bold;">취향 맞춤 추천</h3>
	</div>
</div>

<div class="totalWrap" id="likeItemWrap">
	<div id="wrap">
		<div class="innerContainer" id="likeItemContainer">
		
			<div id="qnaBox">
				<h2 id="qna1" class="qnaText">Q1. 당신이 찾고있는 제품의 카테고리는?</h2>
				<h2 id="qna2" class="qnaText">Q2. 당신이 찾고있는 제품 용도는?</h2>
				<h2 id="qna3" class="qnaText">Q3. 당신이 찾고있는 제품의 연결방식은?</h2>
			</div>
			
			
			<hr style="border-top: 4px dashed black;">
			
			
			<div id="Choice1" class="likeItemChoice">
				<div>
					<button type="button" class="btn btn-default choiceBtn" onclick="goChoice('ch1', 'mouse')"><span>마우스</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="keyboard" onclick="goChoice('ch1', 'keyboard')"><span>키보드</span></button>
				</div>
				<div>
					<button type="button" class="btn btn-default choiceBtn" value="speaker" onclick="goChoice('ch1', 'speaker')"><span>스피커</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="headset" onclick="goChoice('ch1', 'headset')"><span>헤드셋</span></button>
				</div>
			</div>
			
			<div id="Choice2" class="likeItemChoice">
				<div>
					<button type="button" class="btn btn-default choiceBtn" onclick="goChoice('ch2', 'office')"><span>사무용</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="keyboard" onclick="goChoice('ch2', 'home')"><span>가정용</span></button>
				</div>
				<div>
					<button type="button" class="btn btn-default choiceBtn" value="speaker" onclick="goChoice('ch2', 'gaming')"><span>게임용</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="headset" onclick="goChoice('ch2', 'edu')"><span>교육용</span></button>
				</div>
			</div>
			
			<div id="Choice3" class="likeItemChoice">
				<div>
					<button type="button" class="btn btn-default choiceBtn" onclick="goChoice('ch3', 'usb')"><span>USB 수신기</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="keyboard" onclick="goChoice('ch3', 'bluetooth')"><span>블루투스</span></button>
				</div>
				<div>
					<button type="button" class="btn btn-default choiceBtn" value="speaker" onclick="goChoice('ch3', 'code')"><span>유선</span></button>
					<button type="button" class="btn btn-default choiceBtn" value="headset" onclick="goChoice('ch3', 'mix')"><span>복합수신기</span></button>
				</div>
			</div>

	
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />