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

	.pwdFindBtn{
		display: block;
		width: 100%;
		line-height: 30px;
		margin: 0 auto;
	}
	
	div#titleText{
		font-size: 20pt;
		font-weight: bold;
		text-align: center;
	}
	
	label.error{
		color: red;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("div#verificationDiv").hide();
		$("button#pwdChangeBtn").hide();
		$("label#memberNotFindError").hide();
		
		// 인증코드 input 보여주기
		var bFlag = false;
		$("button#testBtn").click(function() {
			if(!bFlag){
				// [이름/이메일이 DB에 있을 때]
				$("div#verificationDiv").show();
				$("button#pwdChangeBtn").show();
				$(this).hide();
				bFlag = true;
			}else{
				//[이름/이메일이 DB에 없을 때]
				$("div#verificationDiv").hide();
				$("label#memberNotFindError").show();
				bFlag = false;
			}
			
		});
		
	});
	
</script>

<%-- Modal 로 띄울 페이지 - 아이디 찾기 --%>
<div class="container">
  
  <form action="/action_page.php">
  	<div id="titleText">
 		<label>비밀번호 찾기</label>
 	</div>
    <br><br>
  	<label>아이디</label>
    <input id="userid" type="text" class="form-control" name="userid" placeholder="아이디" >
    <br>
    <label>이메일</label>
    <input id="email" type="text" class="form-control" name="email" placeholder="이메일" >
    <label class="error" id="memberNotFindError">일치하는 회원이 없습니다.</label><%-- 인증코드를 잘못 입력했을 시 hidden 해제 --%>

	<br>
	<br>

	<div id="verificationDiv">
   		<input id="verification" type="text" class="form-control" name="verification" placeholder="인증코드" >
   		<label>메일을 발송했습니다. 인증코드를 입력해주세요.</label>
   		<label class="error" hidden="hidden">잘못된 인증코드를 입력하였습니다.</label><%-- 인증코드를 잘못 입력했을 시 hidden 해제 --%>
	</div>

    <br><br>
    
    <button type="button" id="testBtn" class="btn btn-default pwdFindBtn">찾기</button>
    <button type="button" id="pwdChangeBtn" class="btn btn-default pwdFindBtn">비밀번호 변경</button>
  </form>
  
  
</div>

    