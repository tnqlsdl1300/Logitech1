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
	
	#email{
		width: 100%;
	}
	
</style>

<%-- Modal 로 띄울 페이지 - 로그인 --%>
<div class="container">
  
  <form action="/action_page.php">
  	<label for="name">이름</label>
    <input id="name" type="text" class="form-control" name="name" placeholder="이름" disabled >
    <br>
    <label for="mobile">전화번호</label>
    <input id="mobile" type="text" class="form-control" name="mobile" placeholder="전화번호" disabled >
    <br>
    <label for="comment">이벤트 참여 이유</label>
    <textarea class="form-control" rows="5" id="comment"></textarea>
    
    <br>
    
    <button type="submit" class="btn btn-default loginBtn">카카오 로그인</button>
    <button type="submit" class="btn btn-default loginBtn">네이버 로그인</button>
  </form>
  
  
</div>

    