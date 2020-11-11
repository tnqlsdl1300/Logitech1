<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp" />

<style>
	
	div#searchResultWrap{
		background-color: #ffffff;	
	}
	
	div#searchResultContainer{
		width: 100%;
		padding: 3% 0;
	}
	
	h1#searchResultTitle{
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
		height: 100%;
	}
	
</style>

<script type="text/javascript">
	
</script>

<div class="totalWrap" id="searchResultWrap">
	<div id="wrap">
		<div class="innerContainer" id="searchResultContainer">
		
			<%-- '마우스' 부분은 검색어로 지정 --%>
			<h1 id="searchResultTitle">'마우스' 검색결과</h1>
			<hr style="border-top: 4px dashed black;">
			
			<select class="form-control" id="searchResultOrderBy">
		      <option value="" selected disabled hidden="hidden">정렬</option>
		      <%-- 여기 option의 value는 나중에 DB 컬럼과 일치하게 해야함 --%>
		      <option value="판매순">판매순</option>
		      <option value="인기순">인기순</option>
		      <option value="평점순">평점순</option>
		    </select>
			
			
			<div id="resultItemContainer">
			
				  <div class="row">
				    <div class="col-sm-3 eachItem" onclick="gotoDetail()">
				    	<div class="eachItemImg">
				    		<img src="https://resource.logitechg.com/e_trim/w_490,h_310,c_limit/c_lpad,ar_413:310,q_auto:best,f_auto,dpr_auto/content/dam/gaming/en/products/g703/g703-gallery-1.png?v=1">
				    	</div>				    	
				    	<p class="productName">제품명1</p>
				    	<p class="productText">설명1</p>
				    </div>
				    <div class="col-sm-3 eachItem" onclick="gotoDetail()">
				    	<div class="eachItemImg">
				    		<img src="https://resource.logitechg.com/e_trim/w_490,h_310,c_limit/c_lpad,ar_413:310,q_auto:best,f_auto,dpr_auto/content/dam/gaming/en/products/refreshed-g203/g203-black-gallery-1.png?v=1">
				    	</div>				    	
				    	<p class="productName">제품명2</p>
				    	<p class="productText">설명2</p>
				    </div>
				    <div class="col-sm-3 eachItem" onclick="gotoDetail()">
				    	<div class="eachItemImg">
				    		<img src="https://resource.logitechg.com/e_trim/w_490,h_310,c_limit/c_lpad,ar_413:310,q_auto:best,f_auto,dpr_auto/content/dam/gaming/en/products/g502-lightspeed-gaming-mouse/g502-lightspeed-gallery-1.png?v=1">
				    	</div>				    	
				    	<p class="productName">제품명3</p>
				    	<p class="productText">설명3</p>
				    </div>
				    <%-- 어차피 부트스트랩이 12가 한계라 자동으로 아래로 내려감 eachItemImg만 정렬해서 넣음 될듯 --%>
				    
				    <div class="col-sm-3 eachItem" onclick="gotoDetail()">
				    	<div class="eachItemImg">
				    		<img src="https://resource.logitechg.com/e_trim/w_490,h_310,c_limit/c_lpad,ar_413:310,q_auto:best,f_auto,dpr_auto/content/dam/gaming/en/products/g603/g603-gallery-1.png?v=1">
				    	</div>				    	
				    	<p class="productName">제품명4</p>
				    	<p class="productText">설명4</p>
				    </div>
				  </div>
				  
				  <%-- 상품 4개마다 밑으로 한칸 내려야 함 [row기준] --%>
				  
				  <div class="row">
				    <div class="col-sm-3 eachItem" onclick="gotoDetail()">
				    	<div class="eachItemImg">
				    		<img src="https://resource.logitechg.com/e_trim/w_490,h_310,c_limit/c_lpad,ar_413:310,q_auto:best,f_auto,dpr_auto/content/dam/products/gaming/mice/g402-hyperion-fury-fps-gaming-mouse/910-004068/g402-hyperion-fury-ultra-fast-fps-gaming-mouse30.png?v=1">
				    	</div>				    	
				    	<p class="productName">제품명1</p>
				    	<p class="productText">설명1</p>
				    </div>
				    <div class="col-sm-3 eachItem" onclick="gotoDetail()">
				    	<div class="eachItemImg">
				    		<img src="https://www.logitech.com/assets/53435/7/wireless-mouse-m325c.png">
				    	</div>				    	
				    	<p class="productName">제품명2</p>
				    	<p class="productText">설명2</p>
				    </div>
				    <div class="col-sm-3 eachItem" onclick="gotoDetail()">
				    	<div class="eachItemImg">
				    		<img src="https://www.logitech.com/content/dam/logitech/en/products/mice/mx-anywhere-3-for-mac/gallery/glamour-pale-gray-lg-2.png">
				    	</div>				    	
				    	<p class="productName">제품명3</p>
				    	<p class="productText">설명3</p>
				    </div>
				    <div class="col-sm-3 eachItem" onclick="gotoDetail()">
				    	<div class="eachItemImg">
				    		<img src="https://assets.logitech.com/assets/65245/7/wireless-desktop-mk320-combo.png">
				    	</div>				    	
				    	<p class="productName">제품명4</p>
				    	<p class="productText">설명4</p>
				    </div>
				  </div>
				  

			</div>
			
			<div id="noResultItemContainer">
				<span>검색된 결과가 없습니다.</span>
			</div>	
		    
				
		</div>
	</div>
</div>

<jsp:include page="footer.jsp" />