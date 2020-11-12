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

	.pwdBtn{
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
					$("button#pwdChangeBtn").show();
					$("button#pwdFindBtn").hide();
					
					// 인증번호 보내기
					$.ajax({
						url: "<%= request.getContextPath() %>/member/smsSend.sg",
						type: "POST",
						data: {"mobile":mobile},
						dataType: "json",
						success:function(json){
							if (json.success_count == 1) {
								// 메세지전송 성공 시
								alert("메세지 전송 성공");
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
					alert("일치하는 회원이 존재하지 않습니다.");
				}
			},
			error: function(request, status, error){ 
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }	
		});
		
	}
	
	// 임시 버튼(삭제 요망)
	function gotoChangeBtn(){       
		location.href="/Logitech/pwdChange.jsp"

	}
	
</script>

<%-- Modal 로 띄울 페이지 - 아이디 찾기 --%>
<div class="container">
  
  <form name = "pwdFindFrm">
  	<div id="titleText">
 		<label>비밀번호 찾기</label>
 	</div>
    <br><br>
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
   		<label class="error" id="codeNotFindError">잘못된 인증번호를 입력하였습니다.</label>
	</div>

    <br><br>
    
    <button type="button" id="pwdFindBtn" class="btn btn-default pwdBtn" onclick="goFindPwd()">찾기</button>
    <button type="button" id="pwdChangeBtn" class="btn btn-default pwdBtn" onclick="gotoChangeBtn()">비밀번호 변경</button>
  </form>
  
  
</div>

    