<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
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
	
	div.modal-content{
		background-color: #f5f5f5;
	}
	
	div.modal-body{
		border-top: dashed 3px #34495e;
	}
	
	h4.modal-title{
		font-size: 15pt;
		font-weight: bold;
		color: #34495e;
	}
	

.label-container{
	position:fixed;
	bottom:48px;
	right:105px;
	display:table;
	visibility: hidden;
}

.label-text{
	color:#FFF;
	background:rgba(51,51,51,0.5);
	display:table-cell;
	vertical-align:middle;
	padding:10px;
	border-radius:3px;
}

.label-arrow{
	display:table-cell;
	vertical-align:middle;
	color:#333;
	opacity:0.5;
}

.float{
	position:fixed;
	width:60px;
	height:60px;
	bottom:40px;
	right:40px;
	background-color: #00ead0;
	color:#FFF;
	border-radius:50px;
	text-align:center;
	box-shadow: 2px 2px 3px #999;
	z-index:1000;
	animation: bot-to-top 2s ease-out;
}

ul.floatingBtnBox{
	position:fixed;
	right:40px;
	padding-bottom:20px;
	bottom:80px;
	z-index:100;
}

ul.floatingBtnBox li{
	list-style:none;
	margin-bottom:10px;
}

ul.floatingBtnBox li a{
	background-color: #00ead0;
	color:#FFF;
	border-radius:50px;
	text-align:center;
	box-shadow: 2px 2px 3px #999;
	width:60px;
	height:60px;
	display:block;
}

ul.floatingBtnBox:hover{
	visibility:visible!important;
	opacity:1!important;
}


.my-float{
	font-size:24px;
	margin-top:18px;
}

a#menu-share + ul{
  visibility: hidden;
}

a#menu-share:hover + ul{
  visibility: visible;
  animation: scale-in 0.5s;
}

a#menu-share i{
	animation: rotate-in 0.5s;
}

a#menu-share:hover > i{
	animation: rotate-out 0.5s;
}

@keyframes bot-to-top {
    0%   {bottom:-40px}
    50%  {bottom:40px}
}

@keyframes scale-in {
    from {transform: scale(0);opacity: 0;}
    to {transform: scale(1);opacity: 1;}
}

@keyframes rotate-in {
    from {transform: rotate(0deg);}
    to {transform: rotate(360deg);}
}

@keyframes rotate-out {
    from {transform: rotate(360deg);}
    to {transform: rotate(0deg);}
}

</style>

</head>
<body>

	<script type="text/javascript">
	
		// 전체 모달 닫기(전역함수인듯)
		window.closeModal = function(){
		    $('.modal').modal('hide');
		    javascript:history.go(0);
		};
		
		// 임시 Modal을 위한 페이지 이동 함수(전역)
		window.href = function(loc) {
			location.href = loc;
		};

		
		$(document).ready(function() {
			
		});
		
		function goLogout() {
			location.href = "<%= ctxPath %>/member/logout.sg";
		}
		
		function goMemberRegister() {
			closeModal();
			location.href="<%= ctxPath %>/member/memberRegister.sg";
		}
		
		function goIndex() {
			closeModal();
			location.href="<%= ctxPath %>/index.sg";
		}
		
		function parentCall() {
			alert("부모창 함수 호출함");
		}
		
		// 최근 본 제품으로 이동하면서 get방식으로 로컬스토리지의 값을 가져감
		function goHistory() {
			var history = localStorage.getItem("history");
			
			if(history != null) {
			 history = history.substring(1, history.length);
			}
			else {
				history = "";
			}
			
			location.href = "<%= request.getContextPath() %>/history.sg?history=" + history; 
		}
		
		function goMypage() {
			
			if (${ sessionScope.loginuser != null }) {
				location.href="<%= request.getContextPath() %>/mypage/main.sg";
			}else{
				alert("로그인 시 이용가능한 컨텐츠입니다.");
			}
			
		}
		
		
	</script>
	<div class="totalWrap" id="navWrap">
		<div id="wrap">

			<nav class="navbar navbar-inverse">
				<div class="container-fluid">
					<ul class="nav navbar-nav navbar-left">
						<li><a href="https://www.logitechg.com/ko-kr" target="_blank"><span class="navText">LogitechG</span></a></li>
						<li><a href="https://www.jaybirdsport.com/ko-kr" target="_blank"><span class="navText">jaybird</span></a></li>
						<li><a href="https://www.bluemic.com/ko-kr/" target="_blank"><span class="navText">Blue</span></a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<c:if test="${ sessionScope.loginuser != null }">
						<li id="mypageBtn"><a href="<%= request.getContextPath() %>/mypage/main.sg"><span
								class="glyphicon glyphicon-user"></span><span class="navText">
									내계정</span></a></li>
						<li id="logoutBtn" onclick="goLogout()"><a href="#"><span
								class="glyphicon glyphicon-log-in"></span><span class="navText">
									로그아웃</span></a></li>
						</c:if>
						
						<c:if test="${ sessionScope.loginuser == null }">
							<li id="loginBtn" data-toggle="modal" data-target="#loginModal"><a
							href="#"><span class="glyphicon glyphicon-user"></span><span
								class="navText"> 내계정</span></a></li>
						</c:if>
						
						
					</ul>
				</div>
			</nav>
		</div>
	</div>
	
	<div class="totalWrap" id="menuWrap">
		<div id="wrap">
			<header id="page_header">
				<div id="logo">
					<a href="<%= request.getContextPath() %>/index.sg"><img src="<%=ctxPath%>/images/squadgLogo.png" width="200px"></a>
				</div>

				<ul id="menu">
					<li><a href="<%= request.getContextPath() %>/product/mouse.sg">마우스</a></li>
					<li><a href="<%= request.getContextPath() %>/product/keyboard.sg">키보드</a></li>
					<li><a href="<%= request.getContextPath() %>/product/headset.sg">헤드셋</a></li>
					<li><a href="<%= request.getContextPath() %>/product/speaker.sg">스피커</a></li>
					<li><a href="<%= request.getContextPath() %>/customCenter.sg">고객센터</a></li>
				</ul>

				<div id="div_search" data-toggle="modal" data-target="#searchModal" style="cursor: pointer;">
					<span>검색</span> <i class="material-icons">search</i>
				</div>
			</header>
		</div>
	</div>


<%-- 아래는 Modal --%>

	<%-- data-keyboard="false" data-backdrop="static" 는 esc와 바깥 클릭으로 modal이 닫히는 것을 방지 => 새로고침 적용때문에 넣음 --%>

	
	<%-- 로그인 Modal --%>
<div id="loginModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
        <h4 class="modal-title">내계정</h4>
      </div>
      <div class="modal-body">
        <div id="login">
        <%-- 임시 모달 꼭 변경 --%>
             <iframe style="border: none; width: 100%; height: 470px;" src="<%= request.getContextPath() %>/member/login.sg">
             </iframe>
        </div>
      </div>
    </div>

  </div>
</div>

<%-- 검색 Modal --%>
<div id="searchModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
        <h4 class="modal-title">제품 검색</h4>
      </div>
      <div class="modal-body">
        <div id="register">
             <iframe style="border: none; width: 100%; height: 500px; overflow: hidden;" src="<%= request.getContextPath() %>/product/searchModal.sg">
             </iframe>
        </div>
      </div>
    </div>

  </div>
</div>

<%-- 플로팅 아이콘 --%>
<a href="#" class="float" id="menu-share"> <i
	class="fa fa-plus my-float"></i>
</a>
<ul class="floatingBtnBox">
	<li style="cursor: pointer;"><a onclick="goHistory()" class="floatingBtn"> <i class="fa fa-history my-float"></i>
	</a></li>
	<li><a style="cursor: pointer;" class="floatingBtn" onclick="goMypage()"> <i class="fa fa-user my-float"></i>
	</a></li>
</ul>