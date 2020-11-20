<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />
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
</style>

<script type="text/javascript">

	$(document).ready(function() {
		var min = parseInt($("#sumpoint").text()) - parseInt($("#usedpoint").text());
		$("#okpoint").text(min);
	});
</script>

<div class="container">
	<div id="title">POINT</div>

	<div id="seconddiv">		
			<li>
				<label>총 적립금:</label>
				<span id="sumpoint">${totalpt}</span>
			</li>
			<li>
				<label>사용가능 적립금:</label>
				<span id="okpoint">0원</span>
			</li>
			<li>
				<label>사용된 적립금:</label>
				<span id="usedpoint">${usedpoint}</span>
			</li>
	</div>
	<br><br><br>
	<h5 class="text-center">적립내역보기</h5>
	<br>
	<div id="thirddiv" class="container">
		<table id="table1" class="table table-striped">
			<thead>
				<tr>
					<th>적립날짜</th>
					<th>적립금</th>
					<th>관련주문</th>
					<th>내용</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="pcvo" items="${pointlist}" varStatus="status">
					<tr>
						<td>${pcvo.purchaseday}</td>
						<td id="ptnum${status.index}" class="allptnum">${pcvo.pointvo.pointnum}원</td>
						<td>${pcvo.ordernum}</td>
						<td>${pcvo.pointvo.reason}</td>
					</tr>
					<input type="text" value="${pcvo.pointvo.usedpointnum}" id="usedpt${status.index}" hidden="true"/>				
				</c:forEach>
			</tbody>
		</table>
		<input type="text" value="${usedpoint}" id="usedpt" hidden="true"/>
		<hr />
		<div>
			${pageBar} 	
		</div>	
	</div>
	
</div>

<jsp:include page="../footer.jsp" />




















