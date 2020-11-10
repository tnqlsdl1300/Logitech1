<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>
	
	.container{
		width: 80%;
		margin: 0 auto;
		padding-top: 5%;
	}
	
	.emailText{
		list-style-type: none;
	}
	
	.loginBtn{
		display: block;
		width: 100%;
		margin: 0 auto;
	}
	
	
	#accountFind{
		list-style-type: none;
		float: left;
	}
	
	#accountFind li{
		display: inline-block;
		padding-right: 50px;
	}
	
	#accountFind li:last-child {
		padding-right: 0;
	}

	h4#loginTitle{
		font-size: 20pt;
		font-weight: bold;
		text-align: center;
		padding: 20px 0;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		
	});	
	
</script>

<%-- Modal 로 띄울 페이지 - 로그인 --%>
<div class="container">
  
  <form action="/action_page.php">
  
	<h4 id="loginTitle">로그인</h4>

    <div class="input-group">
      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
      <input id="email" type="text" class="form-control" name="email" placeholder="아이디">
    </div>
    <div class="input-group">
      <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
      <input id="password" type="password" class="form-control" name="password" placeholder="비밀번호">
    </div>
    <div class="checkbox">
      <label><input type="checkbox" name="remember"> 아이디 저장</label>
    </div>
    <ul id="accountFind">
    	<li><a href="/Logitech/idFind.jsp">아이디 찾기</a></li>
    	<li><a href="/Logitech/pwdFind.jsp">비밀번호 찾기</a></li>
    	<li><a href="<%= request.getContextPath() %>/member/memberRegister.up" target="_blank" id="registerBtn">회원가입1</a></li>
        <li style="cursor: pointer;" onclick="window.parent.goMemberRegister()">회원가입2</li>
    </ul>
    <br>
    <button type="button" class="btn btn-default loginBtn">로그인</button>
    <br>
    
    <br>
    <button type="button" class="btn btn-default loginBtn" onclick="window.parent.parentCall();">부모창호출</button>
    <br>
    
    
    <button type="button" class="btn btn-default loginBtn">카카오 로그인</button>
    <button type="button" class="btn btn-default loginBtn">네이버 로그인</button>
  </form>
  
  
</div>

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    