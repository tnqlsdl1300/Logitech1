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

	.submitBtn{
		display: block;
		width: 30%;
		margin: 0 auto;
	}
	
	#titleText{
		font-size: 20pt;
		font-weight: bold;
	}
	
	#comment{
		resize: none;
	}
	
</style>

<%-- Modal 로 띄울 페이지 - 로그인 --%>
<div class="container">
  
  <form action="/action_page.php">
 	<label id="titleText">화장품 무료 증정 이벤트(이벤트명)</label>
    <br><br>
  	<label>이름</label>
    <input id="name" type="text" class="form-control" name="name" placeholder="이름" disabled >
    <br>
    <label>전화번호</label>
    <input id="mobile" type="text" class="form-control" name="mobile" placeholder="전화번호" disabled >
    <br>
    <label for="comment">이벤트 참여 이유</label>
    <textarea class="form-control" rows="5" id="comment"></textarea>
    
    <br>
    
    <button type="submit" class="btn btn-default submitBtn">참여하기</button>
  </form>
  
  
</div>

    