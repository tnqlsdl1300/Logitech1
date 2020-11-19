<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<style>
	
	div#likeItemWrap{
		background-color: #ffffff;	
		min-height: 1000px;
		height: auto;
	}
	
	div#likeItemContainer{
		width: 100%;
		padding: 3% 0;
	}
	
	h1#likeItemTitle{
		font-weight: bold;
		padding: 1% 0;
	}
	

	
</style>

<script type="text/javascript">
	
	$(document).ready(function() {

	});

	
</script>

<div class="totalWrap" id="likeItemWrap">
	<div id="wrap">
		<div class="innerContainer" id="likeItemContainer">
		
			<c:if test="${ sessionScope.loginuser.name != null }">
				<h1 id="likeItemTitle">${ sessionScope.loginuser.name }님을 위한 취향 맞춤 추천 서비스</h1>
			</c:if>
			<c:if test="${ sessionScope.loginuser.name == null }">
				<h1 id="likeItemTitle">고객님을 위한 취향 맞춤 추천 서비스</h1>
			</c:if>
			
			<hr style="border-top: 4px dashed black;">
			
			<div id="resultItemContainer">
			

			</div>
			
			
		    
				
		</div>
	</div>
</div>

<jsp:include page="../footer.jsp" />