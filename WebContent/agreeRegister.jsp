<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp" />

<style>
	
	.container{
		width: 40%;
		margin: 0 auto; 
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

<%-- Modal 로 띄울 페이지 - 회원가입전 동의 --%>
<div class="container">
  
  <form action="/action_page.php">
  
  	<div class="checkbox">
	  <label><input type="checkbox" value="">전체동의</label>
	</div>
	
	<hr>
	
	<label>필수 동의 항목</label><br>
	<div class="checkbox">
	  <label><input type="checkbox" value="">개인정보 수집 및 이용</label><label><a href="/Logitech/iframeAgree/agree.html" target="_blank">약관 전체보기</a></label><br>
	  <label><input type="checkbox" value="">구매관련 회원 이용 약관</label><label><a href="/Logitech/iframeAgree/agree.html" target="_blank">약관 전체보기</a></label>
	</div>

	<br>
	<label>선택 동의 항목</label><br>
	<div class="checkbox">
	  <label><input type="checkbox" value="">개인정보 제3자 제공 동의</label><label><a href="/Logitech/iframeAgree/agree.html" target="_blank">약관 전체보기</a></label><br>
	  <label><input type="checkbox" value="">이메일 수신 동의</label><br>
	  <label><input type="checkbox" value="">SMS 수신 동의</label>
	</div>
	
	<label>단, 거래정보-결제/교환/환불 등과 관련된 내용은 거래안전을 위해 수신 동의와 관련없이 전송됩니다.</label><br>
	
	


	<div id="btnWrapper">
	    <button type="button" class="btn btn-default registerBtn" id="submitBtn"><a href="/Logitech/memberRegister.jsp">동의하고 회원가입</a></button>
	    <button type="button" class="btn btn-default registerBtn" id="cancelBtn">처음으로</button>
    </div>
  </form>
  
  
</div>

<jsp:include page="footer.jsp" />
    