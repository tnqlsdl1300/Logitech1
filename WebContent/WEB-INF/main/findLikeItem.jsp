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
	
	h2.qnaText{
		font-weight: bold;
		color: #34495e;
	}

	
	button.choiceBtn{
		width: 270px;
		height: 120px;
		background-color: #47555e;
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
		
		// 1번 외에 다른 질문, 버튼을 안보이게 하기
		allHide();
		
		$("h2#qna1").show();
		$("div#Choice1").show();
		
	});
	
	var ans1 = "";
	var ans2 = "";
	var ans3 = "";
	
	// 버튼을 눌렀을 시 해당 버튼의 값을 변수에 저장해서 보관 해주는 함수
	function goChoice(whatCh, val) {
		
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
		
		// 3번째 선택지(마지막)를 클릭 시 ajax로 검색
		if (whatCh == "ch3") {
			ans3 = val;
			allHide();
			$("h2#qna3").show();
			$("div#Choice3").show();
			
			// ajax 사용해서 하기(받은 밸류 3개 값만 보내기)
			console.log(ans1);
			console.log(ans2);
			console.log(ans3);
			
			$.ajax({
				url: "<%= request.getContextPath() %>/product/findLikeItem.sg",
				type: "get",
				data: {"ans1":ans1, "ans2":ans2,"ans3":ans3, "flag":"search"},
				dataType: "json",
				success: function(json) {
					
					location.href = "<%= request.getContextPath() %>/product/findLikeItemResult.sg?productid=" + json.productid;
					
				},
				error: function(request, status, error){ 
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			});
			
		}
		
	}
	
	function allHide() {
		$("h2.qnaText").hide();
		$("div.likeItemChoice").hide();
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
				<h2 id="qna1" class="qnaText">Q1. 당신이 찾고있는 제품의 카테고리는?</h2>
				<h2 id="qna2" class="qnaText">Q2. 당신이 찾고있는 제품 용도는?</h2>
				<h2 id="qna3" class="qnaText">Q3. 당신이 찾고있는 제품의 연결방식은?</h2>
			</div>
			
			
			<hr style="border-top: 4px dashed #34495e;">
			
			<div class="well" style="text-align: center; padding: 10%; width: 100%">
			
				<div id="Choice1" class="likeItemChoice">
					<div>
						<button type="button" class="btn choiceBtn" onclick="goChoice('ch1', 'mouse')"><span>마우스</span></button>
						<button type="button" class="btn choiceBtn" value="keyboard" onclick="goChoice('ch1', 'keyboard')"><span>키보드</span></button>
					</div>
					<div>
						<button type="button" class="btn choiceBtn" value="speaker" onclick="goChoice('ch1', 'speaker')"><span>스피커</span></button>
						<button type="button" class="btn choiceBtn" value="headset" onclick="goChoice('ch1', 'headset')"><span>헤드셋</span></button>
					</div>
				</div>
				
				<div id="Choice2" class="likeItemChoice">
					<div>
						<button type="button" class="btn choiceBtn" onclick="goChoice('ch2', '사무용')"><span>사무용</span></button>
						<button type="button" class="btn choiceBtn" value="keyboard" onclick="goChoice('ch2', '가정용')"><span>가정용</span></button>
					</div>
					<div>
						<button type="button" class="btn choiceBtn" value="speaker" onclick="goChoice('ch2', '게이밍')"><span>게이밍</span></button>
						<button type="button" class="btn choiceBtn" value="headset" onclick="goChoice('ch2', '교육용')"><span>교육용</span></button>
					</div>
				</div>
				
				<div id="Choice3" class="likeItemChoice">
					<div>
						<button type="button" class="btn choiceBtn" onclick="goChoice('ch3', 'USB 수신기')"><span>USB 수신기</span></button>
						<button type="button" class="btn choiceBtn" value="keyboard" onclick="goChoice('ch3', '블루투스')"><span>블루투스</span></button>
					</div>
					<div>
						<button type="button" class="btn choiceBtn" value="speaker" onclick="goChoice('ch3', '유선')"><span>유선</span></button>
						<button type="button" class="btn choiceBtn" value="headset" onclick="goChoice('ch3', '복합수신기')"><span>복합수신기</span></button>
					</div>
				</div>

			</div>
	
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />