<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../managerHeader.jsp" />

<style>
#purchaseState {
	float: left;
	width: 75%;
	margin: 20px;
}

.divCell, .divContent {
	text-align: center;
}

div#pdListInfo {
	width: 60%; 
	text-align: left;
	border: solid 0px red;
	margin-top: 30px; 
	font-size: 13pt;
	line-height: 200%;
}

span.myli {
	display: inline-block;
	width: 90px;
	border: solid 0px blue;
}

/* ============================================= */
/* SMS 보내기 */
div#sms {
	margin: 0 auto; 
	/* border: solid 1px red; */ 
	overflow: hidden; 
	width: 50%;
	padding: 10px 0 10px 80px;
}

span#smsTitle {
	display: block;
	font-size: 13pt;
	font-weight: bold;
	margin-bottom: 10px;
}

textarea#smsContent {
	float: left;
	height: 100px;
}

button#btnSend {
	float: left;
	border: none;
	width: 50px;
	height: 100px;
	background-color: navy;
	color: white;
}

div#smsResult {
	clear: both;
	color: red;
	padding: 20px;
}
</style>

<script type="text/javascript">
	var goBackURL = "";

	$(document).ready(function(){
		var priceSum = 0;
		
		$("span.eachPrice").each(function(){
			priceSum += Number($(this).text());
			$("span#totalPrice").html(priceSum);
		});// end of $("span.eachPrice").each(function(){})-------------------------
		
		$("span.discountPrice").html(Number("${purcvo.totalprice}") - priceSum);
		
		goBackURL = "${goBackURL}";
		
		goBackURL = goBackURL.replace(/ /gi, "&");
	});// end of $(document).ready(function(){})-----------------------------
	
	function goMemberList() {
		location.href = "/Logitech/"+goBackURL;
	}// end of function goMemberList(){}-----------------------------
</script>

<div id="purchaseState">
	<div class="row">
		<div class="col-sm-12">
			<div class="well">
				<h4>주문 정보</h4> 
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="well divContent">
				<c:if test="${pdList.size() == 0}">
					존재하지 않는 주문입니다.<br>
				</c:if>
				
				<c:if test="${pdList.size() != 0}">
					<h3>:::  님의 회원 상세정보 :::</h3>
					<div id="pdListInfo">
						<c:forEach var="pdvo" items="pdList">
							<ol>	
						<%--	<li><span class="myli"></span><img src="${pdvo.imgfilename}" /></li> --%>
								<li><span class="myli">주문상세번호 : </span>${pdvo.purchasedetailid}</li>
								<li><span class="myli">제품판매아이디 : </span>${pdvo.fk_productserialid}</li>
								<li><span class="myli">수량 : </span>${pdvo.volume}</li>
								<li><span class="myli">가격 : </span><span class="eachPrice">${pdvo.pvo.price}</span></li>
								<li><span class="myli">진행상태 : </span>${pdvo.deliverystatus}</li>
							</ol>
							
							<hr style="width: 95%; color: black;">
						</c:forEach>
						
						<%-- 주문자 정보 --%>
						<ol>	
							<li><span class="myli">주문번호 : </span>${purcvo.purchaseno}</li>
							<li><span class="myli">주문자 : </span>${purcvo.mvo.name}</li>
							<li><span class="myli">수령인 : </span>${purcvo.receiver}</li>
							<li><span class="myli">우편번호 : </span>${purcvo.postcode}</li>
							<li><span class="myli">주소 : </span>${purcvo.address}&nbsp;${purcvo.detailaddress}&nbsp;${purcvo.extraaddress}</li>
							<li><span class="myli">주문일자 : </span>${purcvo.purchaseday}</li>
						</ol>
						
						<%-- 결제 정보 --%>
						<ol>	
							<li><span class="myli">제품금액 : </span><span id="totalPrice"></span>원</li>
							<li><span class="myli">할인금액 : </span><span id="discountPrice"></span>원</li>
							<li><span class="myli">결제금액 : </span>${purcvo.totalprice}원</li>
							<li><span class="myli">결제수단 : </span>${purcvo.payment}</li>
						</ol>
					</div>
				
					<div>
						<button type="button" style="margin: 50px;" onclick="javascript:goMemberList();">회원목록으로 이동</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../managerFooter.jsp" />