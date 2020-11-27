<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<style>
	
	div#agreeRegisterWrap{
		background-color: #f6f6f6;
	}

	div.innerContainer{
		border: solid 0px red;
		padding-top: 4%;
		padding-bottom: 10%;
		line-height: 35px;
	}
	
	h2#agreeTitle{
		font-size: 40pt;
		font-weight: bold;
		text-align: center;
		color: #3f5a75;
		padding-bottom: 10%;
	}
	
	input[type=checkbox]{
		zoom:1.4;
	}
	
	label{
		font-size: 12pt;
	}
	
	label.infoText{
		font-size: 15pt;
		color: #3f5a75;
	}
	
	label.semiInfoText{
		font-size: 10pt;
	}
	
	a.guideText{
		border: solid 0px red;
		font-size: 10pt;
	}
	
	.registerBtn{
		display:inline-block;
		width: 100px;
		margin: 0 auto;
	}
	
	label.errorText{
		font-size: 11pt;
	}
	
	#btnWrapper{
		text-align: center;
	}
	
	#submitBtn {
		width: 140px;
		margin-right: 5%; 
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("label.errorText").hide();
		
		// 전체동의 체크박스 컨트롤(전체선택/해제)
		$("input.checkAll").click(function() {
			$("input.checkAgree").prop("checked", this.checked);		
		});
		
		// 전체동의 체크박스 컨트롤(개별선택시 전체동의 상태 변화)
		$("input.checkAgree").click(function() {
			if ($("input.checkAgree:checked").length == 5) {
				$("input.checkAll").prop("checked", true);
			}else{
				$("input.checkAll").prop("checked", false);
			}
		});
		
		// 필수동의항목 체크 검사
		$("button#submitBtn").click(function() {
			if($("input.requireCheck:checked").length != 2){
				$("label.errorText").show();
				return false;
			}
			goRegister();
		});
		
	});
	
	function goRegister() {
		var frm = document.registerAgreeFrm;
		frm.action = "memberRegister.sg";
		frm.method = "post";
		frm.submit();
	}
	

</script>

<%-- Modal 로 띄울 페이지 - 회원가입전 동의 --%>
<div class="totalWrap" id="agreeRegisterWrap">
	<div id="wrap">
		<div class="innerContainer">
			<form name="registerAgreeFrm">
			
				<h2 id="agreeTitle">SquadG</h2>
			
			  	<div class="checkbox">
				  <label><input type="checkbox" class="checkAll" value="">전체동의</label>
				</div>
				
				<hr style="border-top: 2px dashed #3f5a75;">
				
				<label class="infoText">필수 동의 항목</label><br>
				<div class="checkbox">
				  <label><input type="checkbox" class="checkAgree requireCheck" value="">개인정보 수집 및 이용</label><label><a class="guideText" href="/Logitech/iframeAgree/agree.html" target="_blank">약관 전체보기</a></label><br>
				  <label><input type="checkbox" class="checkAgree requireCheck" value="">구매관련 회원 이용 약관</label><label><a class="guideText" href="/Logitech/iframeAgree/agree.html" target="_blank">약관 전체보기</a></label>
				  <label class="errorText">SquadG 개인정보 수집 및 이용과 구매관련 회원 이용 약관에 대한 안내 모두 동의해주세요.</label>
				</div>
			
				<br>
				<label class="infoText">선택 동의 항목</label><br>
				<div class="checkbox">
				  <label><input type="checkbox" class="checkAgree" name="agreethird" value="1">개인정보 제3자 제공 동의</label><label><a class="guideText" href="/Logitech/iframeAgree/agree.html" target="_blank">약관 전체보기</a></label><br>
				  <label><input type="checkbox" class="checkAgree" name="agreesms" value="1">이메일 수신 동의</label><br>
				  <label><input type="checkbox" class="checkAgree" name="agreeemail" value="1">SMS 수신 동의</label>
				</div>
				
				<label class="semiInfoText">단, 거래정보-결제/교환/환불 등과 관련된 내용은 거래안전을 위해 수신 동의와 관련없이 전송됩니다.</label><br>
				
	
				<div id="btnWrapper">
				    <button type="button" class="btn btn-default registerBtn" id="submitBtn">동의하고 회원가입</button>
				    <button type="button" class="btn btn-default registerBtn" id="cancelBtn">처음으로</button>
			    </div>
			  </form>
		  </div>
	</div>
</div>


<jsp:include page="../footer.jsp" />
    