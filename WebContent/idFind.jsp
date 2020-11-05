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
		
		// 찾은 아이디 보여주기/숨기기
		var bFlag = false;
		$(".idFindBtn").click(function() {
			if(!bFlag){
				$("div#resultDiv").hide();
				bFlag = true;
			}else{
				$("div#resultDiv").show();
				bFlag = false;
			}
			
		});
		
	});
	
</script>

<%-- Modal 로 띄울 페이지 - 아이디 찾기 --%>
<div class="container">
  
  <form action="/action_page.php">
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
		회원님의 아이디는 <span>tnqlsdl1300</span> 입니다.
	</div>

    <br><br><br>
    
    <button type="button" class="btn btn-default idFindBtn">찾기</button>
  </form>
  
  
</div>

    