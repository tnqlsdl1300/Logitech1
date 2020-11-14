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
		padding-top: 8%;
	}

	.pwdChangeBtn{
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
		// 에러메세지 일단 숨겨둠
		$("label.error").hide();
		
		$("button.pwdChangeBtn").click(function() {
			window.parent.closeModal();
		});
		
	});
	
	// 비밀번호 변경 버튼을 눌렀을 때 실행
	function pwdChange() {
		
	}
	
</script>

<%-- Modal 로 띄울 페이지 - 아이디 찾기 --%>
<div class="container">
  
  <form action="/action_page.php">
  	<div id="titleText">
 		<label>비밀번호 변경</label>
 	</div>
    <br><br>
  	<label>새로운 비밀번호</label>
    <input id="newPwd" type="password" class="form-control" name="newPwd" placeholder="새로운 비밀번호" >
    <br>
    <label>비밀번호 확인</label>
    <input id="checkPwd" type="password" class="form-control" name="checkPwd" placeholder="비밀번호 확인" >
    <label id="notSamePwdError" class="error">비밀번호가 일치하지 않습니다.</label>

	<br><br><br>

    
    <button type="button" class="btn btn-default pwdChangeBtn" onclick="pwdChange()">변경</button>
  </form>
  
  
</div>

    