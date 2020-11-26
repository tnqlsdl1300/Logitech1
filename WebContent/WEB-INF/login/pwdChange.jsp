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
		padding-top: 8%;
	}

	button.pwdChangeBtn{
		height: 45px;
		background-color: #47555e;
		color: white;
		font-weight: bold;
		display: block;
		width: 100%;
		margin: 0 auto;
	}
	
	.pwdChangeBtn span {
	  cursor: pointer;
	  font-size: 13pt;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	.pwdChangeBtn span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	  color: #f1c40f;
	}
	
	.pwdChangeBtn:hover span {
	  padding-right: 25px;
	  color: #f1c40f;
	}
	
	.pwdChangeBtn:hover span:after {
	  opacity: 1;
	  right: 0;
	}
	
	div#titleText{
		font-size: 20pt;
		font-weight: bold;
		text-align: center;
		color: #3f5a75;
	}
	
	label.error{
		color: red;
	}

	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		// 에러메세지 숨겨둠
		$("label.error").hide();
		
	});
	
	// 비밀번호 변경 버튼을 눌렀을 때 실행
	function pwdChange() {
		
		$("label.error").hide();
		
		//// 비밀번호 정규식 검사 
		var newPwd = $("input[name=newPwd]").val().trim();
		var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		
		var bool = regExp.test(newPwd);
		if(!bool){
			// 불가
			$("input[name=newPwd]").val("");
			$("input[name=newPwd]").focus();
			$("input[name=newPwd]").next().show();
			return false;
		}
		
		//// 비밀번호체크 검사
		var newPwd = $("input[name=newPwd]").val().trim();
		var checkPwd = $("input[name=checkPwd]").val().trim();
		
		if (newPwd != checkPwd) {
			// 불가
			$("input[name=checkPwd]").val("");
			$("input[name=checkPwd]").focus();
			$("input[name=checkPwd]").next().show();
			return false;
		}
		
		// 비밀번호 변경을 위한 ajax
		$.ajax({
			url: "<%= request.getContextPath() %>/member/pwdChangeEnd.sg",
			type: "POST",
			data: { "userid":"${ userid }", "newPwd":newPwd },
			dataType: "json",
			success:function(json){
				if (json.pwd_change_success == true) {
					// 비밀번호 변경이 성공했을 시
					alert("비밀번호 변경을 완료하였습니다.");
					window.parent.closeModal();
					// index.sg 로 이동 => 그냥 모달만 닫기로 변경
					
				}else if(json.pwd_change_success == false){
					// 비밀번호 변경이 실패했을 시(DB문제)
					alert("DB 문제로 비밀번호 변경에 실패하였습니다.");
					
				}
			},
			error: function(request, status, error){ 
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		});
		
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
    <label id="invalidPwdError" class="error">영문자+숫자+특수문자 조합 6~15글자로 설정해주세요.</label>
    <br>
    <label>비밀번호 확인</label>
    <input id="checkPwd" type="password" class="form-control" name="checkPwd" placeholder="비밀번호 확인" >
    <label id="notSamePwdError" class="error">비밀번호가 일치하지 않습니다.</label>

	<br><br><br>

    
    <button type="button" class="btn pwdChangeBtn" onclick="pwdChange()"><span>변경</span></button>
  </form>
  
  
</div>

    