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

	.pwdBtn{
		display: block;
		width: 100%;
		line-height: 30px;
		margin: 0 auto;
	}
	
	button.pwdBtn{
		height: 40px;
		background-color: #47555e;
		color: white;
		font-weight: bold;
		display: block;
		width: 100%;
		margin: 0 auto;
	}
	
	.pwdBtn span {
	  cursor: pointer;
	  font-size: 13pt;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	.pwdBtn span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	  color: #f1c40f;
	}
	
	.pwdBtn:hover span {
	  padding-right: 25px;
	  color: #f1c40f;
	}
	
	.pwdBtn:hover span:after {
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
		
		$("div#verificationDiv").hide();
		$("button#pwdChangeBtn").hide();
		$("label#memberNotFindError").hide();
		$("button#rePwdFindBtn").hide();
		$("label#codeNotFindError").hide();

	});
	
	// 인증코드 보내는 버튼[아이디, 전화번호 입력]
	function goFindPwd() {
		
		var userid = $("input[name=userid]").val().trim();
		var mobile = $("input[name=mobile]").val().trim();

		if (userid == "") {
			alert("아이디를 입력해주세요.");
			$("input[name=userid]").val("");
			$("input[name=userid]").focus();
			return;
		}
		
		if (mobile == "") {
			alert("전화번호를 입력해주세요.");
			$("input[name=mobile]").val("");
			$("input[name=mobile]").focus();
			return;
		}

		// 비밀번호를 찾을 회원의 정보를 DB에서 검색, 성공시 인증번호 ajax 실행
		$.ajax({
			url: "<%= request.getContextPath() %>/member/pwdFind.sg",
			type: "POST",
			data: {"userid":userid, "mobile":mobile},
			dataType: "json",
			success:function(json){
				
				if (json.isExist) {
					// 회원정보 있음, 인증번호 보내기
					
					// 인증번호 관련 div와 버튼으로 변경
					$("div#verificationDiv").show();
					
					$("button#pwdFindBtn").hide();
					$("button#rePwdFindBtn").show();
					$("button#pwdFindBtn").hide();
					
					// 인증번호를 보내는 ajax
					$.ajax({
						url: "<%= request.getContextPath() %>/member/smsSend.sg",
						type: "POST",
						data: {"mobile":mobile},
						dataType: "json",
						success:function(json){
							if (json.success_count == 1) {
								// 메세지전송 성공 시
								$("button#pwdChangeBtn").show();
								
							}else if(json.error_count != 0){
								// 메세지전송 실패 시
								alert("메세지 전송 실패");
							}
						},
						error: function(request, status, error){ 
			                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			            }
					});
					
					
				}else{
					// 회원정보 없음, 실패 alert() 띄우기
					alert("입력하신 정보와 일치하는 회원이 존재하지 않습니다.");
				}
			},
			error: function(request, status, error){ 
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }	
		});
		
	}
	
	
	// 비밀번호 변경 페이지로 이동하는 버튼(입력한 인증코드가 맞는지 확인)
	function gotoChangeBtn(){       
		
		var inputCode = $("input#verification").val().trim();
		var userid = $("input[name=userid]").val().trim();
		
		// 인증번호를 입력하지 않았을 시
		if (inputCode == "") {
			alert("인증번호 6자리를 정확하게 입력해주세요.");
			$("input#verification").val("");
			$("input#verification").focus();
			return;
		}
		
		// 인증번호를 입력했을 시 맞는지 확인해주는 ajax
		$.ajax({
			url: "<%= request.getContextPath() %>/member/pwdChange.sg",
			type: "POST",
			data: {"inputCode":inputCode},
			dataType: "json",
			success:function(json){
				if (json.code_success == true) {
					// 입력한 인증번호가 맞을 시
					// post방식으로 pwdChangeEnd.sg에 보내기(form데이터 같이 가져가서 userid로 db update)
					
					var frm = document.pwdFindFrm;
					frm.action = "<%= request.getContextPath() %>/member/goPwdChange.sg";
					frm.method = "POST";
					frm.submit();
					
				}else if(json.code_success == false){
					// 입력한 인증번호가 틀릴 시
					$("label#memberNotFindError").show();
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
  
  <form name = "pwdFindFrm">
  	<div id="titleText">
 		<label>비밀번호 찾기</label>
 	</div>
    <br>
  	<label>아이디</label>
    <input id="userid" type="text" class="form-control" name="userid" placeholder="아이디" >
    <br>
    <label>전화번호</label>
    <input id="mobile" type="text" class="form-control" name="mobile" placeholder="전화번호(-을 빼고 입력해주세요.)" >
    <label class="error" id="memberNotFindError">일치하는 회원이 없습니다.</label><%-- 인증코드를 잘못 입력했을 시 hidden 해제 --%>

	<br>
	<br>

	<div id="verificationDiv">
   		<input id="verification" type="text" class="form-control" name="verification" placeholder="인증번호" >
   		<label>인증번호를 발송했습니다. 문자메세지를 확인해주세요.</label>
   		<label class="error" id="codeNotFindError">잘못된 인증번호입니다. 인증번호를 확인한 다음 다시 입력해주세요.</label>
	</div>

    <br>
    
    <button type="button" id="pwdFindBtn" class="btn pwdBtn" onclick="goFindPwd()"><span>찾기</span></button>
    <button type="button" id="rePwdFindBtn" class="btn pwdBtn" style="margin-bottom: 1%;" onclick="goFindPwd()"><span>인증번호 재전송</span></button>
    <button type="button" id="pwdChangeBtn" class="btn pwdBtn" onclick="gotoChangeBtn()"><span>비밀번호 변경</span></button>
  </form>
  
  
</div>

    