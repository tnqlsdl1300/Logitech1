<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<style type="text/css">
	body{
		border: solid 0px red;
		margin: 0;
		padding: 0;
		
		font-family: Arial, "MS Trebuchet", sans-serif;
		word-break: break-all;
	}
	div {
		border: solid 1px gray;
	}
	div#container {
		text-align: center;
	}
	
	tr{
		border: solid 1px red;
	}
	
	.iconstr > td {
		border: solid 1px gray;
		width: 230px;
		height: 250px;
		text-align: center;
	}
	
	#ordershorttr1 > td{
		border: solid 1px gray;
		width: 180px;
		height: 100px;
		text-align: center;
	}
	
	#ordershorttr2 > td{
		border: solid 1px gray;
		color: red;
		text-align: center;
	}

	div > span {
		border: solid 1px gray;
	}
	
	#input {
		width: 100px;
		hegith: 80px;
	}

	.indiv {
		display: inline;
	}
	
	#grade2, #history2 {
		margin-left: 200px;
	}
</style>
<jsp:include page="../header.jsp" />

<div class="container">
		<span>MY PAGE</span>
		<div id="grade">
			<div id="grade1" class="indiv">
				홍길동 님은 [WELCOME] 등급입니다.
			</div>
			<div id="grade2" class="indiv">
				다음달 예상 등급
			</div>
		</div>
		<div id="history">
			<div id="history1" class="indiv">
				홍길동님 반갑습니다.
			</div>
			<div id="history2" class="indiv">
				포인트와 할인쿠폰 간단히 보여줌.
			</div>
		</div>
		<div id="ordershort">
			<div>나의 주문 처리 현황</div>
			<div id="ordershort1">
				<table>
					<tr id="ordershorttr1">
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
						<td>0</td>
					</tr>
					<tr id="ordershorttr2">
						<td>주문접수</td>
						<td>결제완료</td>
						<td>상품준비중</td>
						<td>배송중</td>
						<td>배송완료</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="icons">마이페이지에 들어가는 텝들이 들어가는 </div>
		<table>
			<Tr class="iconstr"> 
				<td><div><a href="<%= ctxPath %>/mypage/ordercheck.sg">주문/배송 조회</a></div></td>
				<td><div><a href="<%= ctxPath %>/mypage/ordercart.sg">장바구니</a></div></td>
				<td><div><a href="<%= ctxPath %>/mypage/orderheart.sg">찜목록</a></div></td>
				<td><div><a href="<%= ctxPath %>/mypage/orderreview.sg">리뷰작성</a></div></td>
			</Tr>
			<tr class="iconstr">
				<td><div><a href="<%= ctxPath %>/mypage/mypoint.sg">포인트</a></div></td>
				<td><div><a href="<%= ctxPath %>/mypage/mycoupon.sg">쿠폰</a></div></td>
				<td><div><a href="<%= ctxPath %>/mypage/editmyinfo.sg">회원정보 수정/탈퇴</a></div></td>
				<td><div>1:1 문의 내역</div></td>
			</tr>
		</table>
</div>

<jsp:include page="../footer.jsp" />

