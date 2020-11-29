<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp" />

<style>
	
	body{
		background-color: #f6f6f6;
	}
	
	div#searchResultWrap{
		min-height: 1000px;
		height: auto;
	}
	
	div#searchResultContainer{
		width: 100%;
		padding: 3% 0;
	}
	
	h1#searchResultTitle{
		color: #34495e;
		font-weight: bold;
		padding: 1% 0;
	}
	
	span#historyCnt{
		color: #887575;
	}
	
	div#resultItemContainer{
		clear: both;
		padding: 3% 0;
	}
	
	div#resultItemContainer .row{
		margin: 0 auto;
		padding-bottom: 2%;
	}
	
	div#resultItemContainer div.eachItem{
		border: solid 0px red;
		cursor: pointer;
		margin-bottom: 3%;
	}
	
	div#resultItemContainer .eachItemImg{
		text-align: center;
		border: solid 0px red;
		background-color: #f4f4f4;
		padding: 10% 0;
		width: 250px;
		height: 250px;
	}
	
	div#resultItemContainer div.eachItem img{
		border: solid 0px red;
		padding: 0;
		width: 100%;
		height: 130%;
	}
	
	p.productId{
		border: solid 0px red;
		margin-top: 15%;
		font-weight: bold;
		font-size: 16pt;
	}
	
	p.productName{
		font-style: italic;
		padding:0;
		margin: 0;
		padding-bottom: 1%;
		font-size: 11pt;
	}
	
	p.productPrice{
		font-weight: bold;
	}
	
	div#noResultItemContainer{
		text-align: center;
		padding-top: 15%;
	}
	
	div#noResultItemContainer span{
		font-size: 20pt;
		font-weight: bold;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function() {

	});
	
	// 검색한 제품을 클릭시 상세 페이지로 이동하는 함수
	function gotoDetail(proid) {
		location.href="<%= request.getContextPath() %>/product/productviewpage.sg?productid=" + proid;
	}

	
</script>

<div class="totalWrap" id="searchResultWrap">
	<div id="wrap">
		<div class="innerContainer" id="searchResultContainer">
		
			<h1 id="searchResultTitle">최근 본 상품(<span id="historyCnt">${ pvoList.size() }</span>)건</h1>
			<hr style="border-top: 4px dashed #34495e;">
			
			<div id="resultItemContainer">
			<%-- 물품 넣을 때 주소에 get방식으로 productid를 붙여서 보내주면 됨 --%>
			  <div class="row">
			
				<%-- 검색한 결과가 있을 때 --%>
			  	<c:if test="${ pvoList.size() != 0 }">
			  		<c:forEach var="pvo" items="${ pvoList }">
				  		<div class="col-sm-3 eachItem" onclick="gotoDetail('${ pvo.productid }')">
					    	<div class="eachItemImg">
					    		<img style="background-color: #ecebe9;" src="${ pvo.imgfilename }">
					    	</div>				    	
					    	<p class="productId">${ pvo.productid }</p>
					    	<p class="productName">${ pvo.productname }</p>
					    	<p class="productPrice"><fmt:formatNumber value="${pvo.price}" pattern="###,###" />원</p>
					    </div>
				  	</c:forEach>
			  	</c:if>
			  	
			  	<%-- 검색한 결과가 없을 때 --%>
			  	<c:if test="${ pvoList.size() == 0 }">
			  		<div id="noResultItemContainer">
						<span>최근 본 상품이 존재하지 않습니다.</span>
					</div>	
			  	</c:if>
  
			  </div>

			</div>
			
			
		    
				
		</div>
	</div>
</div>

<jsp:include page="footer.jsp" />