<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../managerHeader.jsp" />

<style>
#eventState {
	float: left;
	width: 75%;
	margin: 20px;
}

.divCell, .divContent {
	text-align: center;
}

div#eventInfo {
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

<div id="eventState">
	<div class="row">
		<div class="col-sm-12">
			<div class="well">
				<h4>이벤트 정보</h4> 
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="well divContent">
				<c:if test="${jevoList.size() == 0}">
					존재하지 않는 주문입니다.<br>
				</c:if>
				
				<c:if test="${jevoList.size() != 0}">
					<h3>:::  님의 회원 상세정보 :::</h3>
					<div id="eventInfo">
						<c:forEach var="jevo" items="jevoList">
							<ol>	
								<li><span class="myli">이벤트참여번호 : </span>${jevo.seq_joinevent}</li>
								<li><span class="myli">참여회원 : </span>${jevo.mvo.userid}</li>
							</ol>
						</c:forEach>
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