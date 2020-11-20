<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<style type="text/css">
#title {
	text-align: center;
	font-size: 18pt;
	margin-bottom: 60px;
}

#seconddiv > li {
	display: block;
	height: 50px;
	vertical-align: middle;
	width: 500px;
	padding-left: 50px;
	padding-right: 50px;
}

#seconddiv > li > span {
	float:right;
	padding-top: 15px;
}

div#seconddiv {
	border: solid 1px #e6e6e6;
	width: 500px;
	margin-left: 300px;
}

label {
	padding-top: 15px;
}
#forediv{
	text-align: center;
}

#table1 {
	font-size: 10pt;
}

#sendbtn {
	padding: 10px;
	margin-left: 200px;
	margin-top: 20px;
	margin-bottom: 20px;
	border: 0px;

}
#register {
	text-align: center;
	
	padding: 20px;
}
#registtitle {
	margin-bottom: 10px;
	
	font-size: 10pt;
}
#registcontent {
	background-color: #f2f2f2;
	padding:20px;
}
#err {
	font-size: 6pt;
	margin-top: 10px;
}

</style>
<jsp:include page="../header.jsp" />

<div class="container">
	<div id="title">MY COUPON</div>

	<div id="seconddiv">		
			<li>
				<label>홍길동 님의 회원등급 : </label>
				<span>WELCOME</span>
			</li>
			<li>
				<label>WELCOME 쿠폰 팩:</label>
				<span>5000원 쿠폰 팩</span>
			</li>
			<div><button type="button" id="sendbtn">쿠폰 발급 받기</button></div>
	</div>
	<br><br><br>
	<h5 class="text-center">쿠폰내역보기</h5>
	<br>
	<div id="thirddiv" class="container">
		<table id="table1" class="table table-striped">
			<thead>
				<tr>
					<th>쿠폰명</th>
					<th>쿠폰 금액</th>
					<th>최소사용 금액</th>
					<th>사용여부</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>WELCOME 회원 쿠폰</td>
					<td>2,000원</td>
					<td>15,000원</td>
					<td>사용가능</td>
				</tr>
				<tr>
					<td>할로윈 이벤트 쿠폰</td>
					<td>1,000원</td>
					<td>10,000원</td>
					<td>기한만료</td>
				</tr>
			</tbody>
		</table>
		
<!-- 		<div id="forediv">
			<ul class="pager">
				<li><a href="#">Previous</a></li>
				<li><a href="#">Next</a></li>
			</ul>
		</div> -->
		
	</div>
	<hr />
	<div id="register">
		<div id="registtitle">쿠폰인증번호 등록하기</div>
		<div id="registcontent">
			<input type="text">
			<button>쿠폰번호인증</button>
			<div id="err">
				반드시 쇼핑몰에서 발생한 쿠폰번호만 입력해주세요. (10~35자 일련번호 "-" 제외)
			</div>
		</div>
		
	</div>
</div>

<jsp:include page="../footer.jsp" />




















