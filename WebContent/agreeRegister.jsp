<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp" />

<style>
	
	div#agreeRegisterWrap{
		
	}

	.registerBtn{
		display:inline-block;
		width: 100px;
		margin: 0 auto;
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
		});
		
	});
	

</script>

<%-- Modal 로 띄울 페이지 - 회원가입전 동의 --%>
<div class="totalWrap" id="agreeRegisterWrap">
	<div id="wrap">
		<div class="innerContainer">
			<form action="/action_page.php">
			  	<%-- ** 전체동의 체크 시 다른 체크박스 컨트롤 구현!!!!, 회사소개 페이지 구현 --%>
			  	<div class="checkbox">
				  <label><input type="checkbox" class="checkAll" value="">전체동의</label>
				</div>
				
				<hr>
				
				<label>필수 동의 항목</label><br>
				<div class="checkbox">
				  <label><input type="checkbox" class="checkAgree requireCheck" value="">개인정보 수집 및 이용</label><label><a href="/Logitech/iframeAgree/agree.html" target="_blank">약관 전체보기</a></label><br>
				  <label><input type="checkbox" class="checkAgree requireCheck" value="">구매관련 회원 이용 약관</label><label><a href="/Logitech/iframeAgree/agree.html" target="_blank">약관 전체보기</a></label>
				  <label class="errorText">필수 동의 항목을 체크하지 않으셨습니다.</label>
				</div>
			
				<br>
				<label>선택 동의 항목</label><br>
				<div class="checkbox">
				  <label><input type="checkbox" class="checkAgree" value="">개인정보 제3자 제공 동의</label><label><a href="/Logitech/iframeAgree/agree.html" target="_blank">약관 전체보기</a></label><br>
				  <label><input type="checkbox" class="checkAgree" value="">이메일 수신 동의</label><br>
				  <label><input type="checkbox" class="checkAgree" value="">SMS 수신 동의</label>
				</div>
				
				<label>단, 거래정보-결제/교환/환불 등과 관련된 내용은 거래안전을 위해 수신 동의와 관련없이 전송됩니다.</label><br>
				
	
				<div id="btnWrapper">
				    <button type="button" class="btn btn-default registerBtn" id="submitBtn"><a href="/Logitech/memberRegister.jsp">동의하고 회원가입</a></button>
				    <button type="button" class="btn btn-default registerBtn" id="cancelBtn">처음으로</button>
			    </div>
			  </form>
		  </div>
	</div>
</div>


<jsp:include page="footer.jsp" />
    