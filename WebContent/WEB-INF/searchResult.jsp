<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp" />

<style>
	
	div#searchResultWrap{
		background-color: #f5f5f5;	
		min-height: 1000px;
		height: auto;
	}
	
	div#searchResultContainer{
		width: 100%;
		padding: 3% 0;
	}
	
	h1.searchResultTitle{
		color: #34495e;
		font-weight: bold;
		padding: 1% 0;
	}
	
	select#searchResultOrderBy{
		float: right;
		
	}
	
	div#resultItemContainer{
		clear: both;
		padding: 3% 0;
	}
	
	div#searchResultContainer select{
		width: 10%;
	}
	
	div#resultItemContainer .row{
		margin: 0 auto;
		padding-bottom: 2%;
	}
	
	div#resultItemContainer div.eachItem{
		cursor: pointer;
		margin-bottom: 5%;
	}
	
	div#resultItemContainer .eachItemImg{
		text-align: center;
		border: solid 0px red;
		background-color: #ecebe9;
		padding: 0 0;
		width: 250px;
		height: 250px;
	}
	
	div#resultItemContainer div.eachItem img{
		border: solid 0px red;
		padding: 0;
		margin-top: 3%;
		width: 90%;
		height: 90%;
	}
	
	p.productId{
		border: solid 0px red;
		margin-top: 1%;
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
		
		// select 값 변경시 로드후에도 고정
		if (!"${ select }" == "") {
			$("select#searchResultOrderBy").val("${ select }").prop("selected", true);	
		}
	
		// select 값 변경 시 DB에서 데이터를 다시 가져옴
		$("select#searchResultOrderBy").change(function() {
			location.href = "<%= request.getContextPath() %>/product/searchResult.sg?keyword=${ keyword }&select=" + $(this).val() + "&type=${ type }";
		});
		
	});

	// 검색한 제품을 클릭시 상세 페이지로 이동하는 함수
	function gotoDetail(proid) {
		location.href="<%= request.getContextPath() %>/product/productviewpage.sg?productid=" + proid;
	}

	
</script>

<div class="totalWrap" id="searchResultWrap">
	<div id="wrap">
		<div class="innerContainer" id="searchResultContainer">
		
			<c:if test="${ all != 'all' }">
				<h1 class="searchResultTitle">"${ keyword }" 검색결과</h1>
			</c:if>
			
			<c:if test="${ all == 'all' }">
				<h1 class="searchResultTitle">Best Items</h1>
			</c:if>
			
			<hr style="border-top: 4px dashed #34495e;">
			
			<c:if test="${ all != 'all' }">
				<select class="form-control" id="searchResultOrderBy" style="width: 120px;">
			      <option value="" selected disabled hidden="hidden">정렬</option>
			      <%-- 여기 option의 value는 나중에 DB 컬럼과 일치하게 해야함 --%>
			      <option value="highPrice">가격높은순</option>
			      <option value="lowPrice">가격낮은순</option>
			      <option value="favorite">인기순</option>
			      <option value="sale">판매순</option>
			    </select>
			</c:if>
			
			<div id="resultItemContainer">
			<%-- 물품 넣을 때 주소에 get방식으로 productid를 붙여서 보내주면 됨 --%>
			  <div class="row">

				<%-- 검색한 결과가 있을 때 --%>
			  	<c:if test="${ pList.size() != 0 }">
			  		<c:forEach var="pvo" items="${ pList }">
				  		<div class="col-sm-3 eachItem" onclick="gotoDetail('${ pvo.productid }')">
					    	<div class="eachItemImg">
					    		<img src="${ pvo.imgfilename }">
					    	</div>				    	
					    	<p class="productId">${ pvo.productid }</p>
					    	<p class="productName">${ pvo.productname }</p>
					    	<p class="productPrice"><fmt:formatNumber value="${pvo.price}" pattern="###,###" />원</p>
					    </div>
				  		
				  	</c:forEach>
			  	</c:if>
			  	
			  	<%-- 검색한 결과가 없을 때 --%>
			  	<c:if test="${ pList.size() == 0 }">
			  		<div id="noResultItemContainer">
						<span>검색된 결과가 없습니다.</span>
					</div>	
			  	</c:if>
  
			  </div>

			</div>
			
			
		    
				
		</div>
	</div>
</div>

<jsp:include page="footer.jsp" />