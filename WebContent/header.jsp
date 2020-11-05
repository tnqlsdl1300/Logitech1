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
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/css/style.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%=ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

<style type="text/css">
	nav.navbar {
		border: solid 0px blue;
		margin: 0;
		padding:0;
	}
	
	span.navText {
		font-size: 12pt;
	}
	
	ul.navbar-nav li {
		border: solid 0px white;
		padding: 0;
		margin: 0;
	}
	
	ul.navbar-left li:first-child{
		border: solid 0px white;
		margin-left: -10px;
		
	}
	
	ul.navbar-right li:last-child{
		border: solid 0px white;
		margin-right: -6px;
		
	}
	
	li#loginBtn{
		border: solid 0px white;
		margin-right: -5px;
	}
	
	div#navWrap{
		background-color: #222222;
	}
	
	div#menuWrap{
		background-color: #d4d4d4;
	}
	
	div#footerWrap{
		background-color: #222222;
	}
</style>

</head>
<body>

	<script type="text/javascript">
		$(document).ready(function() {
			// 로그아웃 상태
			$("li#logoutBtn").hide();
			$("li#mypageBtn").hide();

			// 로그인일 때 
			/*
			$("li#loginBtn").hide();
			$("li#logoutBtn").show();
			$("li#mypageBtn").show();
			 */

		});
	</script>
	<div class="totalWrap" id="navWrap">
		<div id="wrap">

			<nav class="navbar navbar-inverse">
				<div class="container-fluid">
					<ul class="nav navbar-nav navbar-left">
						<li><a href="#"><span class="navText">제휴1</span></a></li>
						<li><a href="#"><span class="navText">제휴2</span></a></li>
						<li><a href="#"><span class="navText">제휴3</span></a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li id="loginBtn" data-toggle="modal" data-target="#loginModal"><a
							href="#"><span class="glyphicon glyphicon-user"></span><span
								class="navText"> 내계정</span></a></li>
						<li id="mypageBtn"><a href="#"><span
								class="glyphicon glyphicon-user"></span><span class="navText">
									내계정</span></a></li>
						<li id="logoutBtn"><a href="#"><span
								class="glyphicon glyphicon-log-in"></span><span class="navText">
									로그아웃</span></a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	
	<div class="totalWrap" id="menuWrap">
		<div id="wrap">
			<header id="page_header">
				<div id="logo">
					<a href="./"><img alt="daum" src="<%=ctxPath%>/images/logitech_logo.png" width="170px"></a>
				</div>

				<ul id="menu">
					<li><a href="mouse.html">마우스</a></li>
					<li><a href="keyboard.html">키보드</a></li>
					<li><a href="headset.html">헤드셋</a></li>
					<li><a href="speaker.html">스피커</a></li>
					<li><a href="service.html">고객센터</a></li>
				</ul>

				<div id="div_search" data-toggle="modal" data-target="#searchModal">
					<span>검색</span> <i class="material-icons">search</i>
				</div>
			</header>
		</div>
	</div>


<%-- 아래는 Modal --%>

	
	<%-- 로그인 Modal --%>
<div id="loginModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">로그인</h4>
      </div>
      <div class="modal-body">
        <div id="login">
             <iframe style="border: none; width: 100%; height: 300px;" src="/Logitech/login.jsp">
             </iframe>
        </div>
      </div>
    </div>

  </div>
</div>

<%-- 검색 Modal --%>
<div id="searchModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">제품 검색</h4>
      </div>
      <div class="modal-body">
        <div id="register">
             <iframe style="border: none; width: 100%; height: 500px;" src="/Logitech/searchModal.jsp">
             </iframe>
        </div>
      </div>
    </div>

  </div>
</div>
	