<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp" />

<%
	String ctxPath = request.getContextPath();
	%>

<script type="text/javascript">
 
 
	$(document).ready(function() { 
		
			
		$("tr.thing").click(function () {
			
			alert("oneQueryView.jsp tr이벤트");
			var seq_oq=$(this).children().first().text();
			
			location.href="/Logitech/oqViewOne.sg?seq_oq="+seq_oq;
			
		});
	
		
		
		
		
		
		
    });

	<%--
	// 뒤로가기 방지
	window.history.forward();
	
	function noBack() {

		window.history.forward();

	}
	--%>
	
	
	
     </script>


<style>


td {
	text-align: center;
}

th.hd {
	text-align: center;
}
</style>


<div class="container">
	<h2>내 문의 내역보기</h2>

	<p>최근 6개월 동안 접수하신 1:1문의내역 및 답변 내용을 확인하실 수 있습니다.</p>

	<hr>
	
	<table class="table table-hover">

		<thead>
			<tr>
				<th class="hd">번호</th>
				<th class="hd">제목</th>
				<th class="hd">등록일자</th>
				<th class="hd">처리상태</th>
			</tr>
		</thead>
		<tbody>
			
			
			<c:if test="${empty oqlist}">
				
				<tr class="none">
					<td colspan="4">최근 문의하신 내역이 없습니다.</td>
				</tr>
			</c:if>

			<c:if test="${not empty oqlist}">

				<c:forEach var="oqvo" items="${oqlist}" varStatus="status">
			
					<tr class="thing">
						<td style="display: none;">${oqvo.seq_eq}</td>
						<td>${status.count}</td>
						<td>${oqvo.title}</td>
						<td>${oqvo.writeday}</td>
						<td>
							<c:choose>
								<c:when test="${oqvo.answerstatus eq '0'}">
				                             답변 준비중
				        		</c:when>
								<c:otherwise>
				                             답변 완료
				                </c:otherwise>
							</c:choose>
						</td>
					</tr>	
					
					
					
					
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>

<jsp:include page="../footer.jsp" />