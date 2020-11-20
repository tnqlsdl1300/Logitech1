<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%
	String ctxPath = request.getContextPath();
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 페이지</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

<style>
.layer {
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	font-size: 20px;
	position: absolute;
	text-align: center;
}

.layer .content {
	display: inline-block;
	vertical-align: middle;
}

td {
	/*height: 50px;*/
	padding: 10px;
}

.inputLabel {
	text-align: left;
}

.inputSignIn {
	height: 30px;
}

.inputCheckbox {
	margin: 10px;
}

.layer .blank {
	display: inline-block;
	width: 0;
	height: 100%;
	vertical-align: middle;
}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$("div#goIndex").hide();
		
		if($("div#goIndex").text() == "로그인 중") {
			location.href = "<%= ctxPath%>/manager/managerIndex.sg";
		}
		
		$("input#managerId").focus();
		
		// @@ localStorage 에 저장된 key가 "saveId"인 memberId 값을 불러와서 input 태그 managerId 에 넣어주기
		var managerId = localStorage.getItem('saveId');
		if(managerId != null) {
			$("input#managerId").val(managerId);
			$("input:checkbox[id=saveId]").prop("checked", true);
		}// end of if(loginUserid != null){}-------------------------
		
		$("input#managerPwd").keyup(function(event){
			if(event.keyCode == 13) {
				goSignIn();
			}// end of if(event.keyCode == 13){}----------------------
		});// end of $("input#managerPwd").keyup(function(){})-------------------------
		
		$("#btnSignIn").click(function(){
			goSignIn();
		});// end of $("btnSignIn").click(function(){})---------------------
	});// end of $(document).ready(function(){})---------------------------
	
	function goSignIn() {
		var managerId = $("input#managerId").val().trim();
		var managerPwd = $("input#managerPwd").val().trim();
		
		if(managerId == "") {
			alert("아이디를 입력해주세요.");
			$("input#managerId").val("");
			$("input#managerId").focus();
			return;
		}// end of if(managerId == ""){}----------------------
		
		if(managerPwd == "") {
			alert("비밀번호를 입력해주세요.");
			$("input#managerPwd").val("");
			$("input#managerPwd").focus();
			return;
		}// end of if(managerPwd == ""){}----------------------
		
		if($("input:checkbox[id=saveId]").prop("checked")) {
			localStorage.setItem('saveId', $("input#managerId").val());
		} else {
			localStorage.removeItem('saveId');
		}// end of if($("input:checkbox[id=saveid]").prop("checked")){}--------------------------
		
		var frm = document.frmSignIn;
		frm.action = "<%= request.getContextPath()%>/manager/signIn.sg";
		frm.method = "POST";
		frm.submit();
	}
</script>

</head>
<body>

<c:choose>
	<c:when test="${empty sessionScope.loginManager}">
		<form name="frmSignIn">
			<div class="layer">
				<div class="content">
					<img src="" width="72" height="72">
					
					<h1>Please sign in</h1>
					
					<table>
						<tbody>
							<tr>
								<td class="inputLabel">
									<label for="managerId">관리자 아이디</label>
								</td>
								<td>
									<input type="text" class="inputSignIn" id="managerId" name="managerId" placeholder="Id" required autofocus>
								</td>
							</tr>
						</tbody>
						
						<tbody>
							<tr>
								<td class="inputLabel">
									<label for="managerPwd">비밀번호</label>
								</td>
								<td>
									<input type="password" class="inputSignIn" id="managerPwd" name="managerPwd" placeholder="Password" required>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="inputCheckbox">
						<label>
							<input type="checkbox" id="saveId">&nbsp;계정 기억하기
						</label>
					</div>
					
					<button type="button" id="btnSignIn">로그인</button>
					
					<p>&copy; 2020</p>
				</div>
				<div class="blank"></div>
			</div>
		</form>
	</c:when>

	<c:otherwise>
		<div id="goIndex">로그인 중</div>
	</c:otherwise>
</c:choose>

</body>
</html>
