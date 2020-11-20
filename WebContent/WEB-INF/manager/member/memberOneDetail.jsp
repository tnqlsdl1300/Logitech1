<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../managerHeader.jsp" />

<style>
#memberState {
	float: left;
	width: 95%;
	margin: 20px;
}

.divCell, .divContent {
}

div#mvoInfo {
	width: 95%;
	text-align: left;
	border: solid 0px red;
	margin-top: 30px; 
	font-size: 13pt;
	line-height: 200%;
}

span.myli {
	display: inline-block;
	width: 200px;
	font-weight: bold;
	margin-top: 20px;
}

/* ============================================= */
/* SMS 보내기 */
/*
div#sms {
	margin: 0 auto; 
	/* border: solid 1px red;
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
*/
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

<div id="memberState">
	<div class="row">
		<div class="col-sm-12">
			<div class="well" style="background-color: white;">
				<h4>회원 정보</h4>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="well divContent" style="background-color: white;">
				<c:if test="${empty mvo}">
					존재하지 않는 회원입니다.<br>
				</c:if>
				
				<c:if test="${not empty mvo}">
					<h3 style="margin-left: 40px;">${mvo.name} 님의 상세 회원 정보</h3>
					<hr style="height: 8px; background-color: #ccc; margin: 30px 0;">
					<div id="mvoInfo" style="background-color: white;">
						<ol style="list-style: none;">	
							<li><span class="myli">회원번호 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.memberno}</li>
							<li><span class="myli">아이디 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.userid}</li>
							<li><span class="myli">회원명 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.name}</li>
							<li><span class="myli">이메일 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.email}</li>
							<li><span class="myli">휴대폰 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${fn:substring(mvo.mobile, 0, 3)}-${fn:substring(mvo.mobile, 3, 7)}-${fn:substring(mvo.mobile, 7, 11)}</li>
							<li><span class="myli">생년월일 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.birthday}</li>
							<li><span class="myli">우편번호 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.postcode}</li>
							<li><span class="myli">주소 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.address}&nbsp;${mvo.detailaddress}&nbsp;${mvo.extraaddress}</li>
							<li><span class="myli">이메일 수신 동의 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.agreeemail}</li>
							<li><span class="myli">문자 수신 동의 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.agreesms}</li>
							<li><span class="myli">제 3자 정보 제공 동의 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.agreethird}</li>
							<li><span class="myli">회원등급 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.fk_membershipname}</li> 
							<li><span class="myli">포인트 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div><fmt:formatNumber value="${mvo.point}" pattern="###,###" /> POINT</li>
							<li><span class="myli">가입일자 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.registerday}</li>
							<li><span class="myli">탈퇴 예정일 </span><div style="display: inline-block; width: 3px; height: 35px; background-color: #ccc; vertical-align: middle; margin-right: 50px;"></div>${mvo.dropday}</li>
						</ol>
					</div>
				</c:if>
				
				<div style="background-color: white; margin: 50px 100px;">
					<button type="button" style="border: none; width: 150px; height: 50px; background-color: #1a1a1a; color: white; text-align: center;" onclick="javascript:goMemberList();">회원목록으로 이동</button>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../managerFooter.jsp" />