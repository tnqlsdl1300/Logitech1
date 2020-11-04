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
	
	.mobile{
		display: inline-block;
		width: 31%;
	}
	
	.registerBtn{
		display:inline-block;
		width: 100px;
		margin: 0 auto;
	}
	
	#accountFind{
		list-style-type: none;
		
	}
	
	#accountFind li{
		display: inline-block;
		padding-right: 50px;
	}
	
	#accountFind li:last-child {
		padding-right: 0;
	}
	
	#birthText{
		padding-right: 10%;
	}
	
	#birthday{
		width: 300px;
		text-align: center;
	}
	
	#btnWrapper{
		text-align: center;
	}
	
	#submitBtn {
		width: 140px;
		margin-right: 5%;
	}
	
</style>

<%-- Modal 로 띄울 페이지 - 회원가입 --%>
<div class="container">
  
  <form action="/action_page.php">
    <div class="form-group">
      <input type="text" class="form-control input-group" id="name" placeholder="이름" name="name">
      <label>이름을 입력하시지 않았습니다.</label>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="userid" placeholder="아이디" name="userid">
      <label>띄어쓰기 없이 영문자+숫자 6~15글자 이하로 입력해주세요.</label>
    </div>
    <div class="form-group">
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호" name="pwd">
      <label>영문자+숫자+특수문자 조합 6~15글자로 설정해주세요.</label>
    </div>
    <div class="form-group">
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호 확인" name="pwd">
      <label>비밀번호가 일치하지 않습니다.</label>
    </div>
    
    <div class="form-group">
      <select class="form-control mobile" id="mobile1">
	    <option>010</option>
	    <option>011</option>
	    <option>070</option>
 	 </select> - 
 	 <input type="email" class="form-control mobile" id="mobile2" placeholder="휴대폰"> - 
 	 <input type="email" class="form-control mobile" id="mobile3" placeholder="번호">
    </div>
    <br>
    <div class="form-group">
      <input type="text" class="form-control" id="email" placeholder="이메일 주소" name="email">
      <label>이메일 형식에 맞춰 입력해주세요.</label>
    </div>
    <div class="form-group">
      <label id="birthText">생년월일</label>
      <input type="date" id="birthday" name="birthday">
    </div>

	<div id="btnWrapper">
	    <button type="button" class="btn btn-default registerBtn" id="submitBtn">회원가입</button>
	    <button type="button" class="btn btn-default registerBtn" id="cancelBtn">처음으로</button>
    </div>
  </form>
  
  
</div>

    