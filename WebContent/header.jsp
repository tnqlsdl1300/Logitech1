<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>
<!DOCTYPE html>
<html>
<head>

<title>주변기기 쇼핑몰</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

</head>
<body>

<div id="wrap">
		
	<!-- 시작: page_header ------------------------------------------------ -->
	<header id="page_header">
		<div id="logo">
			<img alt="daum" src="<%= ctxPath %>/images/daum.png" width="170px">
		</div>
		
		<ul id="menu">
			<li><a href="mouse.html">마우스</a></li>
			<li><a href="keyboard.html">키보드</a></li>
			<li><a href="headset.html">헤드셋</a></li>
			<li><a href="speaker.html">스피커</a></li>
			<li><a href="service.html">고객센터</a></li>
		</ul>
		
		<%-- c:if 로 로그인시(마이페이지), 로그아웃시(로그인, 회원가입) 상태 구분 --%>
		<div id="loginBtn">
			<button type="button" class="btn btn-default" id="loginBtn" data-toggle="modal" data-target="#loginModal">로그인</button>
			<button type="button" class="btn btn-default" id="registerBtn" data-toggle="modal" data-target="#registerModal">회원가입</button>
		</div>
		
		<div id="search">
			<input type="text" class="form-control" placeholder="검색" style="width: 230px; height: 30px;" />
		</div>
	</header>