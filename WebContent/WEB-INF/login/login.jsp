<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>
	
	body{
		overflow: hidden;
		background-color: #f5f5f5;
	}
	
	.container{
		width: 80%;
		margin: 0 auto;
		padding-top: 5%;
	}
	
	.emailText{
		list-style-type: none;
	}
	

	button.loginBtn{
		height: 45px;
		background-color: #47555e;
		color: white;
		font-weight: bold;
		display: block;
		width: 100%;
		margin: 0 auto;
	}
	
	.loginBtn span {
	  cursor: pointer;
	  font-size: 13pt;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	.loginBtn span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	  color: #f1c40f;
	}
	
	.loginBtn:hover span {
	  padding-right: 25px;
	  color: #f1c40f;
	}
	
	.loginBtn:hover span:after {
	  opacity: 1;
	  right: 0;
	}
	
	
	#accountFind{
		list-style-type: none;
		float: left;
	}
	
	#accountFind li{
		color: #47555e;
		display: inline-block;
		padding-right: 50px;
	}
	#accountFind li a{
		color: #47555e;
		text-decoration: none;
	}
	
	#accountFind li:last-child {
		padding-right: 0;
	}

	h4#loginTitle{
		font-size: 30pt;
		font-weight: bold;
		text-align: center;
		padding: 20px 0;
		color: #3f5a75;
	}
	
	li#loginRegisterBtn{
		cursor: pointer;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		var loginUserid = localStorage.getItem("saveid");
		
		if (loginUserid != null) {
			// session 아이디가 저장되어 있을 때
			$("input#userid").val(loginUserid);
			$("input#saveid").prop("checked", true);
		}else{
			// session 아이디가 저장되어 없을 때
			$("input#userid").val("");
			$("input#saveid").prop("checked", false);
		}
		
		$("button#loginBtn").click(function() {
			goLogin();
		});
		
		$("input#password").keyup(function() {
			// 암호 입력란에 엔터를 입력했을 경우 goLogin() 함수 실행
			if(event.keyCode == 13){
				goLogin();
			}	
		});

	});	
	
	
	function goLogin() {
		var loginUserid = $("input[name=userid]").val();
		var loginPwd = $("input[name=password]").val();

		if (loginUserid == "") {
			alert("아이디를 입력해주세요.");
			$("input[name=email]").focus();
			$("input[name=email]").val("");
			return false;
		}else if (loginPwd == "") {
			alert("비밀번호를 입력해주세요.");
			$("input[name=password]").focus();
			$("input[name=password]").val("");
			return false;
		}
		
		if($("input#saveid:checked").length == 1){
			localStorage.setItem("saveid", $("input[name=userid]").val());
		}else{
			localStorage.removeItem("saveid");
		}

	    $.ajax({
	    	url:"/Logitech/member/login.sg",
	    	type:"POST",
	    	data:{"userid":loginUserid, "password":loginPwd},
	    	dataType: "JSON",
	    	success:function(json){ // json ==> {"login":"fail"}

	    		if(json.login == "loginSuccess"){
	    			window.parent.closeModal(); // 모달창 닫기
	    		}
	    		
				if(json.login == "loginFail") {
					alert("가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.");	
				}

	    		if(json.login == "pwdChange"){
	    			window.parent.closeModal(); // 모달창 닫기
	    			alert("비밀번호를 변경한지 3개월이 지났습니다. 비밀번호를 변경해주세요.");
	    		}
	    		
	    		if (json.login == "restAccount") {
	    			alert("1년동안 로그인을 하지 않아 휴면처리 된 계정입니다. 관리자에게 문의하세요.");
				}
	    		
	    		
	    	},
	    	error: function(request, status, error){ 
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }	
	    });
	
	}
	
</script>

<%-- Modal 로 띄울 페이지 - 로그인 --%>
<div class="container">
  
  <form name="loginFrm">
  
	<h4 id="loginTitle">SquadG</h4>

    <div class="input-group">
      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
      <input id="userid" type="text" class="form-control" name="userid" placeholder="아이디">
    </div>
    <div class="input-group">
      <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
      <input id="password" type="password" class="form-control" name="password" placeholder="비밀번호">
    </div>
    
    <div class="checkbox">
      <label><input type="checkbox" id="saveid" name="saveid">아이디 저장</label>
    </div>
    <ul id="accountFind">
    	<li><a href="<%= request.getContextPath() %>/member/idFind.sg">아이디 찾기</a></li>
    	<li><a href="<%= request.getContextPath() %>/member/pwdFind.sg">비밀번호 찾기</a></li>
        <li id="loginRegisterBtn" onclick="window.parent.goMemberRegister()">회원가입</li>
    </ul>
    <br><br><br><br>
    <button type="button" class="btn loginBtn" id="loginBtn"><span>로그인</span></button>
    <br>

  </form>
  
  
</div>

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    