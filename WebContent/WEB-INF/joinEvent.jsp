<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />

<style>
	
	.container{
		width: 80%;
		margin: 0 auto;
	}

	.submitBtn{
		display: block;
		width: 30%;
		margin: 0 auto;
	}
	
	#titleText{
		font-size: 20pt;
		font-weight: bold;
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
		
		$("label#titleText").html("${ evo.eventname }");
		
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
<div class="totalWrap">
	<div class="container" id="joinWrap" style="width: 50%;">
  <form name="joinEventFrm">
 	<label id="titleText"></label>
    <br><br>
  	<label>이름</label>
    <input id="name" type="text" class="form-control" name="name" placeholder="이름" value="${ sessionScope.loginuser.name }" disabled >
    <br>
    <label>전화번호</label>
    <input id="mobile" type="text" class="form-control" name="mobile" placeholder="전화번호" value="${ sessionScope.loginuser.mobile }" disabled >
    <br>
    <label for="comment">이벤트 참여 이유</label>
    <textarea class="form-control" rows="5" id="eventcomment" name="eventcomment"></textarea>
    
    <br>
    
    <button type="button" class="btn btn-default submitBtn" onclick="joinEvent()">참여하기</button>
  </form>
  
  </div>
</div>

<jsp:include page="footer.jsp" />

    