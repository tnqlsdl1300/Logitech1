<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<style>
	
	div#registerWrap{
		background-color: #f6f6f6;
	}
	
	h2#h2_registerTitle{
		font-weight: bold;
		text-align: center;
		color: #3f5a75;
	}
	
	div.innerContainer{
		padding: 5% 0;
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
	
	var useridFlag = false;
	var emailFlag = false;
	
	$(document).ready(function() {
		
		$("label.errorText").hide();
		
		
		
		
	});
	
	// 아이디 중복검사 버튼
	function isExistUseridCheck() {

		
		if ($("input#userid").val() == "") {
			alert("아이디를 입력해주세요.");
			return false;
		}
		
		// 버튼을 눌렀을 때 ajax(비동기)를 통해 data를 url 페이지로 post방식으로 보내준다
  		 $.ajax({
  			url:"<%= ctxPath %>/member/useridDuplicateCheck.sg",	// 보낼 주소
  			data:{"userid":$("input#userid").val()},				// 보낼 데이터(키:밸류)
  			type:"post",										// 메서드(post/get)
  			dataType:"json",									// "/MyMVC/member/idDuplicateCheck.up" 로부터 실행되어진 결과물을 받아오는 데이터 타입을 말한다
  			success:function(json){								// 성공했을 때 실행할 것	(data)는 결과물 json 객체를 말함(). 객체명은 아무거나 써도 객체는 들어옴
  				if(json.isExists){	// 객체명.key값 == value값
  					// 입력한 userid가 이미 사용중 이라면
  					//$("span#idcheckResult").html($("input#userid").val() + "은 사용불가능한 아이디입니다").css({"color":"red"});
  					alert("사용이 불가능한 아이디 입니다.");
  					$("input#userid").val("");
  					$("input#userid").focus();
  					useridFlag = false;
  				}else{
  					// 입력한 userid 가 DB 테이블에 존재하지 않는 경우라면
  					//$("span#idcheckResult").html("사용가능한 아이디입니다.").css({"color":"navy"});
  					alert("사용이 가능한 아이디입니다.");
  					useridFlag = true;
  				}
  			},
  			error: function(request, status, error){			// 실패했을 때 실행할 것(코딩 개떡같이 했을 때 => 정상적으로 받아온 데이터 true/false와 상관없음)
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }									
  		 });
	}
	
	// 이메일 중복검사 버튼
	function isExistEmailCheck() {
		
		if ($("input#email").val() == "") {
			alert("이메일을 입력해주세요.");
			return false;
		}

		// 버튼을 눌렀을 때 ajax(비동기)를 통해 data를 url 페이지로 post방식으로 보내준다
  		 $.ajax({
  			url:"<%= ctxPath %>/member/emailDuplicateCheck.sg",	// 보낼 주소
  			data:{"email":$("input#email").val()},				// 보낼 데이터(키:밸류)
  			type:"post",										// 메서드(post/get)
  			dataType:"json",									// "/MyMVC/member/idDuplicateCheck.up" 로부터 실행되어진 결과물을 받아오는 데이터 타입을 말한다
  			success:function(json){								// 성공했을 때 실행할 것	(data)는 결과물 json 객체를 말함(). 객체명은 아무거나 써도 객체는 들어옴
  				if(json.isExists){	// 객체명.key값 == value값
  					// 입력한 userid가 이미 사용중 이라면
  					//$("span#idcheckResult").html($("input#userid").val() + "은 사용불가능한 아이디입니다").css({"color":"red"});
  					alert("사용이 불가능한 이메일 입니다.");
  					$("input#email").val("");
  					$("input#email").focus();
  					emailFlag = false;
  				}else{
  					// 입력한 userid 가 DB 테이블에 존재하지 않는 경우라면
  					//$("span#idcheckResult").html("사용가능한 아이디입니다.").css({"color":"navy"});
  					alert("사용이 가능한 이메일 입니다.");
  					emailFlag = true;
  				}
  			},
  			error: function(request, status, error){			// 실패했을 때 실행할 것(코딩 개떡같이 했을 때 => 정상적으로 받아온 데이터 true/false와 상관없음)
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }									
  		 });
	}
	
	
	
	// 회원가입 버튼
	function goRegister() {
		
		$("label.errorText").hide();
		
		// 정규표현식 
		
		//// 아이디 검사
		var userid = $("input[name=userid]").val();
		var regExp = new RegExp(/^[a-z]+[a-z0-9]{5,14}$/g);
		
		var bool = regExp.test(userid);
		if (!bool) {
			// 불가
			$("input[name=userid]").val("");
			$("input[name=userid]").focus();
			$("input[name=userid]").next().show();
			return false;
		}
		
		
		//// 비밀번호검사 
		var pwd = $("input[name=pwd]").val();
		var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
		var bool = regExp.test(pwd);
		if(!bool){
			// 불가
			$("input[name=pwd]").val("");
			$("input[name=pwd]").focus();
			$("input[name=pwd]").next().show();
			return false;
		}
		
		//// 비밀번호체크 검사
		pwd = $("input[name=pwd]").val();
		var pwdcheck = $("input#pwdCheck").val();
		
		if (pwd != pwdcheck) {
			// 불가
			$("input[name=pwd]").val();
			$("input#pwdCheck").val("");
			$("input#pwdCheck").focus();
			$("input#pwdCheck").next().show();
			return false;
		}
		
		//// 전화번호 검사(숫자만)
		var mobile = $("input[name=mobile]").val();
		var regExp = new RegExp(/^[0-9]*$/);
		
		var bool = regExp.test(mobile);
		
		if (!bool) {
			$("input[name=mobile]").val("");
			$("input[name=mobile]").focus();
			$("input[name=mobile]").next().show();
			return false;
		}
		

		//// 이메일검사
		var email = $("input[name=email]").val().trim();
			
		var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
		var bool = regExp.test(email);
		
		if(!bool){
			// 불가
			$("input[name=email]").val("");
			$("input[name=email]").focus();
			$("input[name=email]").next().show();
			return false;
		}
		
		
		
		
		var bFlagRequiredInfo = false;
		
		$(".requireInput").each(function() {
			var data = $(this).val().trim();
			
			if(data == ""){
				bFlagRequiredInfo = true;
				$(this).next().show();
				return false;
			}
		});
		
		if(!useridFlag){
			alert("아이디 중복검사를 해주세요.");
			return false;
		}
		
		if(!emailFlag){
			alert("이메일 중복검사를 해주세요.");
			return false;
		}
		
		
		if(!bFlagRequiredInfo){
			var frm = document.registerFrm;
			frm.action = "memberRegisterDB.sg";
			frm.method = "post";
			frm.submit();
		}
		
	}
	
</script>
 
<%-- Modal 로 띄울 페이지 - 회원가입 --%>
<div class="totalWrap" id="registerWrap">
	<div id="wrap">
		
		<%-- .innerContainer은 form 중앙 배치를 위한 div --%>
		<div class="innerContainer">
		  
		  <h2 id="h2_registerTitle">회원가입</h2>
		  <br>
		  <form name="registerFrm">
		  
		    <div class="form-group">
		      <input type="text" class="form-control input-group requireInput" id="name" placeholder="이름" name="name">
		      <label class="errorText">이름을 입력하시지 않았습니다.</label>
		    </div>
		    <div class="form-group">
		      <input type="text" class="form-control requireInput" id="userid" placeholder="아이디" name="userid">
		      <label class="errorText">띄어쓰기 없이 6~15글자 이하로 입력해주세요.</label>
		      <button type="button" class="btn btn-default" onclick="isExistUseridCheck()">아이디 중복확인</button>
		    </div>
		    <div class="form-group">
		      <input type="password" class="form-control requireInput" id="pwd" placeholder="비밀번호" name="pwd">
		      <label class="errorText">영문자+숫자+특수문자 조합 6~15글자로 설정해주세요.</label>
		    </div>
		    <div class="form-group">
		      <input type="password" class="form-control requireInput" id="pwdCheck" placeholder="비밀번호 확인" name="pwdCheck">
		      <label class="errorText">비밀번호가 일치하지 않습니다.</label>
		    </div>
		    
		    <div class="form-group">
		    <input type="text" class="form-control requireInput" id="mobile" name="mobile" placeholder="전화번호 (-을 빼고 입력해주세요.)">
		    <label class="errorText">전화번호를 입력하지 않았습니다.</label>
		    </div>
		    <div class="form-group">
		      <input type="text" class="form-control requireInput" id="email" placeholder="이메일 주소" name="email">
		      <label class="errorText">이메일 형식에 맞춰 입력해주세요.</label>
		      <button type="button" class="btn btn-default" onclick="isExistEmailCheck()">이메일 중복확인</button>
		    </div>
		    <div class="form-group">
		      <label id="birthText">생년월일</label>
		      <input type="date" class="requireInput" id="birthday" name="birthday">
		      <label class="errorText">생년월일을 입력하지 않았습니다.</label>
		    </div>
		
			<br><br>
			<div id="btnWrapper">
			    <button type="button" class="btn btn-default registerBtn" id="submitBtn" onclick="goRegister()">회원가입</button>
			    <button type="button" class="btn btn-default registerBtn" id="cancelBtn">처음으로</button>
		    </div>
		    
		    <input type="hidden" name="agreethird" value="${ agreethird }">
		    <input type="hidden" name="agreesms" value="${ agreesms }">
		    <input type="hidden" name="agreeemail" value="${ agreeemail }">
		  </form>
		  
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />
    