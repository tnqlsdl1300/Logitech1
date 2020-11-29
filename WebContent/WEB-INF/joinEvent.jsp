<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />

<style>
	
	body{
		background-color: #f6f6f6;
	}
	
	.container{
		width: 80%;
		margin: 0 auto;
		padding-top: 1%;
		padding-bottom: 3%;
	}

	.submitBtn{
		height: 50px;
		background-color: #47555e;
		color: white;
		font-weight: bold;
		display: block;
		width: 100%;
		margin: 0 auto;
	}
	
	.submitBtn span {
	  cursor: pointer;
	  font-size: 13pt;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	.submitBtn span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	  color: #f1c40f;
	}
	
	.submitBtn:hover span {
	  padding-right: 25px;
	  color: #f1c40f;
	}
	
	.submitBtn:hover span:after {
	  opacity: 1;
	  right: 0;
	}
	
	div.titleBox{
		text-align: center;
	}
	
	#titleText{
		font-size: 40pt;
		font-weight: bold;
		color: #3f5a75;
	}
	
	#titleSemiText{
		border-bottom: 2px solid black;
		font-size: 19pt;
		
	}
	
	input[type="text"]:disabled{
		height: 40px;
		font-size: 13pt;
		background: white;
	}
	
	label.infoText{
		font-size: 14pt;
	}
	
	#comment{
		resize: none;
	}
	
	div#joinWrap{
		margin-top: 3%;
		margin-bottom: 3%;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
	});
	
	// 이벤트 참여 버튼
	function joinEvent() {
		
		// 텍스트를 입력했는지 체크
		if ($("textarea#eventcomment").val() == "") {
			alert("이벤트 참여 이유 항목을 입력해주세요.");
			$("textarea#eventcomment").focus();
			return;
		}
		
		eventcomment = $("textarea#eventcomment").val();
		
		$.ajax({
			url: "<%= request.getContextPath() %>/product/joinEvent.sg",
			type: "POST",
			data: {"seq_event":"${ evo.seq_event }", "memberno":"${ sessionScope.loginuser.memberno }" , "eventcomment":eventcomment},
			dataType: "json",
			success: function(json) {
				if (json.event_duplication == true) {
					alert("이미 해당 이벤트에 참여한 회원입니다.");
					location.href="<%= request.getContextPath() %>/index.sg";
				}
				
				if (json.event_join_success == true) {
					alert("<${ evo.eventname }> 이벤트에 참여가 완료되었습니다.");
					location.href="<%= request.getContextPath() %>/index.sg";
				}
				
				if (json.event_join_fail == true) {
					alert("DB 문제");
					location.href="<%= request.getContextPath() %>/index.sg";
				}
				
			},
			error: function(request, status, error){ 
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
		 
	}
	
</script>

<%-- Modal 로 띄울 페이지 - 이벤트 --%>
<div class="totalWrap" id="eventWrap">
	<div class="container" id="joinWrap" style="width: 40%;">
	  <form name="joinEventFrm">
	  		<div class="titleBox">
	  			<label id="titleText">SquadG</label>
	  			<br>
	  			<label id="titleSemiText">고객 참여 이벤트</label>
	  		</div>

	    <br><br>
	    <label class="infoText">이벤트명</label>
	    <input id="eventName" type="text" class="form-control disableInput" name="eventName" placeholder="이벤트명" value="${ evo.eventname }" disabled >
	    <br>
	  	<label class="infoText">이름</label>
	    <input id="name" type="text" class="form-control disableInput" name="name" placeholder="이름" value="${ sessionScope.loginuser.name }" disabled >
	    <br>
	    <label class="infoText">전화번호</label>
	    <input id="mobile" type="text" class="form-control disableInput" name="mobile" placeholder="전화번호" value="${ sessionScope.loginuser.mobile }" disabled >
	    <br><br>
	    <label class="infoText" for="comment">이벤트 참여 이유</label>
	    <textarea class="form-control" rows="5" id="eventcomment" name="eventcomment"></textarea>
	    
	    <br>
	    
	    <button type="button" class="btn submitBtn" onclick="joinEvent()"><span>참여하기</span></button>
	  </form>
  
  </div>
</div>

<jsp:include page="footer.jsp" />

    