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
	
	button.idFindBtn{
		height: 45px;
		background-color: #47555e;
		color: white;
		font-weight: bold;
		display: block;
		width: 100%;
		margin: 0 auto;
	}
	
	.idFindBtn span {
	  cursor: pointer;
	  font-size: 13pt;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	.idFindBtn span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	  color: #f1c40f;
	}
	
	.idFindBtn:hover span {
	  padding-right: 25px;
	  color: #f1c40f;
	}
	
	.idFindBtn:hover span:after {
	  opacity: 1;
	  right: 0;
	}
	
	div#titleText{
		font-size: 20pt;
		font-weight: bold;
		text-align: center;
		color: #3f5a75;
	}
	
	div#resultDiv{
		text-align: center;
		font-size: 15pt;
		font-weight: bold;
	}
	
	div#resultDiv span{
		color: #3f5a75;
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
			alert("이름을 입력해주세요.");
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
    
    <button type="button" class="btn idFindBtn" onclick="idFind()"><span>찾기</span></button>
  </form>
  
  
</div>

    