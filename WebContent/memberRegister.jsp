<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp" />

<style>
	
	div#registerWrap{

	}
	
	h2{
		font-weight: bold;
	}
	
	.emailText{
		list-style-type: none;
	}
	
	.mobile{
		display: inline-block;
		width: 31%;
	}
	
	.registerBtn{
		display:inline-block;
		width: 100px;
		margin: 0 auto;
	}
	
	.form-group{
		text-align: left;
		padding-bottom: 2%;
	}
	
	.form-control{
		height: 50px;
	}

	#birthText{
		padding-right: 10%;
	}
	
	#birthday{
		width: 300px;
		text-align: center;
	}
	
	#btnWrapper{
		text-align: center;
	}
	
	#submitBtn {
		width: 140px;
		margin-right: 5%;
	}
	
	#birthday{
		height: 40px;
		font-size: 12pt;
	}
	
	#birthText{
		font-size: 12pt;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("label.errorText").hide();
		
	});
	
</script>
 
<%-- Modal 로 띄울 페이지 - 회원가입 --%>
<div class="totalWrap" id="registerWrap">
	<div id="wrap">
		
		<%-- .innerContainer은 form 중앙 배치를 위한 div --%>
		<div class="innerContainer">
		  
		  <h2>회원가입</h2>
		  <br>
		  <form action="/action_page.php">
		  
		    <div class="form-group">
		      <input type="text" class="form-control input-group" id="name" placeholder="이름" name="name">
		      <label class="errorText">이름을 입력하시지 않았습니다.</label>
		    </div>
		    <div class="form-group">
		      <input type="text" class="form-control" id="userid" placeholder="아이디" name="userid">
		      <label class="errorText">띄어쓰기 없이 영문자+숫자 6~15글자 이하로 입력해주세요.</label>
		    </div>
		    <div class="form-group">
		      <input type="password" class="form-control" id="pwd" placeholder="비밀번호" name="pwd">
		      <label class="errorText">영문자+숫자+특수문자 조합 6~15글자로 설정해주세요.</label>
		    </div>
		    <div class="form-group">
		      <input type="password" class="form-control" id="pwd" placeholder="비밀번호 확인" name="pwd">
		      <label class="errorText">비밀번호가 일치하지 않습니다.</label>
		    </div>
		    
		    <div class="form-group">
		     <input type="email" class="form-control mobile" id="mobile1" placeholder="번호" readonly="readonly" value="010"> - 
		 	 <input type="email" class="form-control mobile" id="mobile2" placeholder="휴대폰"> - 
		 	 <input type="email" class="form-control mobile" id="mobile3" placeholder="번호">
		    </div>
		    <br>
		    <div class="form-group">
		      <input type="text" class="form-control" id="email" placeholder="이메일 주소" name="email">
		      <label class="errorText">이메일 형식에 맞춰 입력해주세요.</label>
		    </div>
		    <div class="form-group">
		      <label id="birthText">생년월일</label>
		      <input type="date" id="birthday" name="birthday">
		    </div>
		
			<br><br>
			<div id="btnWrapper">
			    <button type="button" class="btn btn-default registerBtn" id="submitBtn">회원가입</button>
			    <button type="button" class="btn btn-default registerBtn" id="cancelBtn">처음으로</button>
		    </div>
		  </form>
		  
		</div>
	</div>
</div>

<jsp:include page="footer.jsp" />
    