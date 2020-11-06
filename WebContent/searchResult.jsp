<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp" />

<style>

	div#searchResultContainer{
		width: 100%;
	}
	
</style>

<script type="text/javascript">
	
</script>

<div class="totalWrap" id="searchResultWrap">
	<div id="wrap">
		<div class="innerContainer" id="searchResultContainer">
		
			검색결과 페이지
			
		</div>
	</div>
</div>

<jsp:include page="footer.jsp" />