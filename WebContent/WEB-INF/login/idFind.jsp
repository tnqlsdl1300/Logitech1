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

	.idFindBtn{
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
	
	div#resultDiv{
		text-align: center;
		font-size: 15pt;
		font-weight: bold;
	}
	
	div#resultDiv span{
		color: blue;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		if ("${ method }" == "POST") {
			$("input[name=name]").val("${ name }");
			$("input[name=email]").val("${ email }");
		}
		
	});
	
	// 아이디찾기 버튼 클릭
	function idFind() {
		
		var name = $("input[name=name]").val().trim();
		var email = $("input[name=email]").val().trim();
		
		if (name == "") {
			alert("아이디를 입력해주세요.");
			$("input[name=name]").val("");
			$("input[name=name]").focus();
			return false;
		}
		
		if (email == "") {
			alert("이메일을 입력해주세요.");
			$("input[name=email]").val("");
			$("input[name=email]").focus();
			return false;
		}

		var frm = document.idFindFrm;
		frm.action = "<%= request.getContextPath() %>/member/idFind.sg";
		frm.method = "POST";
		frm.submit();
		
	}
	
</script>

<%-- Modal 로 띄울 페이지 - 아이디 찾기 --%>
<div class="container">
  
  <form name="idFindFrm">
  	<div id="titleText">
 		<label>아이디 찾기</label>
 	</div>
    <br><br>
  	<label>이름</label>
    <input id="name" type="text" class="form-control" name="name" placeholder="이름" >
    <br>
    <label>이메일</label>
    <input id="email" type="text" class="form-control" name="email" placeholder="이메일" >

	<br><br><br>

	<div id="resultDiv">
		<span>${ message }</span>
	</div>

    <br><br><br>
    
    <button type="button" class="btn btn-default idFindBtn" onclick="idFind()">찾기</button>
  </form>
  
  
</div>

    