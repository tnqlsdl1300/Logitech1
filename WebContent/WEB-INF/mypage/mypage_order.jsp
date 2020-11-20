<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<jsp:include page="../header.jsp" />

<style type="text/css">
	button {
	  background:none;
	  border:0;
	  outline:0;
	  cursor:pointer;
	}
	.tab_menu_container {
	  display:flex;
	}
	.tab_menu_btn {
	  width:120px;
	  height:40px;
	  transition:0.3s all;
	  font-size: 10pt;
	}
	.tab_menu_btn.on {
	  border-bottom:2px solid #df0000;
	  font-weight:700;
	  color:#FF6666;
	}
	.tab_menu_btn:hover {
	  color:#FF6666;
	}
	.tab_box {
	  display:none;
	  padding:20px;
	}
	.tab_box.on {
	  display:block;
	}
	#title {
	  font-weight: bold;
	  font-size: 18pt;
	}
	.container {
	border: solid 1px gray;
	padding-top: 40px;
	}
	
	tr#ordertr > td {
		padding: 10px;
		width: 150px;
		background-color: #f4f4f0;
		padding-top: 20px;
		padding-bottom: 20px;
		mar
	}
	
	#ordertable {
		border: solid 1px gray;
		margin-top: 70px;
	}
	
	span#info {
		font-weight: bold;
		font-size: 10pt;
	}
</style>
<script type="text/javascript">
$(document).ready(function() {
	//버튼 색 제거,추가
	$('.tab_menu_btn').on('click',function(){
	  $('.tab_menu_btn').removeClass('on');
	  $(this).addClass('on')
	});

	//1번 컨텐츠
	$('.tab_menu_btn1').on('click',function(){
	  $('.tab_box').hide();
	  $('.tab_box1').show();
	});

	//2번 컨텐츠
	$('.tab_menu_btn2').on('click',function(){
	  $('.tab_box').hide();
	  $('.tab_box2').show();
	});

	//3번 컨텐츠
	$('.tab_menu_btn3').on('click',function(){
	  $('.tab_box').hide();
	  $('.tab_box3').show();
	});
});
</script>

<head>
<span id="title" style="text-align: center;">ORDER</span>
</head>
<div class="container">
<div class="tab_wrap">
  <div class="tab_menu_container">
    <button class="tab_menu_btn1 tab_menu_btn on" type="button">${sessionScope.loginuser.name}주문내역조회 (0)</button>
    <button class="tab_menu_btn2 tab_menu_btn" type="button">취소내역 (0)</button>
    <button class="tab_menu_btn3 tab_menu_btn" type="button">과거주문내역 (0)</button>
  </div> <!-- tab_menu_container e -->

  <div class="tab_box_container">
    <div class="tab_box1 tab_box on">
		<div>
			기간별 주문 상태
		</div>
		<div>
			유의사항
		</div>
		<div id="ordertable">
			<span id="info">주문 상품 정보</span>
			<table>
				<tr id="ordertr">
					<td>주문일자</td>
					<td>이미지</td>
					<td>상품정보</td>
					<td>수량</td>
					<td>상품구매금액</td>
					<td>주문처리상태</td>
					<td>취소</td>
				</tr>
			</table>
		</div>
	</div>
    <div class="tab_box2 tab_box">
    	<div>
			기간별 주문 상태
		</div>
		<div>
			유의사항
		</div>
		<div id="ordertable">
			<span id="info">취소 상품 정보</span>
			<table>
				<tr id="ordertr">
					<td>주문일자</td>
					<td>이미지</td>
					<td>상품정보</td>
					<td>수량</td>
					<td>상품구매금액</td>
					<td>주문처리상태</td>
					<td>취소</td>
				</tr>
			</table>
		</div>
    </div>
    <div class="tab_box3 tab_box">
    <div>
			기간별 주문 상태
		</div>
		<div>
			유의사항
		</div>
		<div id="ordertable">
			<span id="info">과거 주문 내역</span>
			<table>
				<tr id="ordertr">
					<td>주문일자</td>
					<td>이미지</td>
					<td>상품정보</td>
					<td>수량</td>
					<td>상품구매금액</td>
					<td>주문처리상태</td>
					<td>취소</td>
				</tr>
			</table>
		</div>
    </div>

  </div> <!-- tab_box_container e -->
</div> <!-- tab_wrap e -->

</div>

<jsp:include page="../footer.jsp" />




















