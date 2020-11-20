<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../managerHeader.jsp" />

<style>
#couponState {
	float: left;
	width: 75%;
	margin: 20px;
}

.divCell, .divContent {
	text-align: center;
}

div#couponInfo {
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
		goBackURL = "${goBackURL}";
		
		goBackURL = goBackURL.replace(/ /gi, "&");
	});// end of $(document).ready(function(){})-----------------------------
	
	function goMemberList() {
		location.href = "/Logitech/"+goBackURL;
	}// end of function goMemberList(){}-----------------------------
</script>

<div id="couponState">
	<div class="row">
		<div class="col-sm-12">
			<div class="well">
				<h4>쿠폰 정보</h4> 
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="well divContent">
				<c:if test="${empty ecvo}">
					존재하지 않는 주문입니다.<br>
				</c:if>
				
				<c:if test="${not empty ecvo}">
					<h3>:::  님의 회원 상세정보 :::</h3>
					<div id="couponInfo">
						<ol>	
							<li><span class="myli">쿠폰아이디 : </span>${ecvo.fk_couponcode}</li>
							<li><span class="myli">개별쿠폰번호 : </span>${ecvo.eachcouponcode}</li>
							<li><span class="myli">쿠폰명 : </span>${ecvo.coupvo.couponname}</li>
							<li><span class="myli">할인액 : </span>${ecvo.coupvo.discount}</li>
							<li><span class="myli">최소주문금액 : </span>${ecvo.coupvo.minprice}</li>
							<li><span class="myli">적용회원등급 : </span>${ecvo.coupvo.fk_membershipname}</li>
							<li><span class="myli">발급회원 : </span>${ecvo.fk_memberno}</li>
							<li><span class="myli">상태 : </span>${ecvo.status}</li>
							<li><span class="myli">만료일자 : </span>${ecvo.endday}</li>
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