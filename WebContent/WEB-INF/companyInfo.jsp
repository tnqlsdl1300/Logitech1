<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="header.jsp" />

<style>
	
	div#companyInfoWrap{
		background-color: #f6f6f6;
		padding-bottom: 5%;
	}
	
	div#companyInfoContainer{
		width: 100%;
	}
	
	h1#companyInfoTitle{
		font-weight: bold;
		color: black;
	}
	
	h3.companyInfoSmallTitle{
		font-weight: bold;
		padding: 10px 0;
	}
	
	p.companyInfoText{
		padding: 10px 20px;
		font-style: italic;
	}

	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		

		
	});
	

</script>


<div class="totalWrap" id="companyInfoWrap">
	<div id="wrap">
		<div class="innerContainer" id="companyInfoContainer">
		
			<div class="row text-center">
			  <h1 id="companyInfoTitle">What's Logitech?</h1>
			  <br><br>
			
		      <div class="col-sm-4">
		        <div class="thumbnail">
		          <img src="/Logitech/images/companyInfoImg1.jpg" alt="Paris" width="400" height="300">
		          <h3 class="companyInfoSmallTitle">회사소개1</h3>
		          <p class="companyInfoText">할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.</p>
		          <p class="companyInfoText">할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.</p>
		          
		        </div>
		      </div>
		      <div class="col-sm-4">
		        <div class="thumbnail">
		          <img src="/Logitech/images/companyInfoImg2.jpg" alt="New York" width="400" height="300">
		          <h3 class="companyInfoSmallTitle">회사소개2</h3>
		          <p class="companyInfoText">할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.</p>
		          <p class="companyInfoText">할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.</p>
		        </div>
		      </div>
		      <div class="col-sm-4">
		        <div class="thumbnail">
		          <img src="/Logitech/images/companyInfoImg3.jpg" alt="San Francisco" width="400" height="300">
		          <h3 class="companyInfoSmallTitle">회사소개3</h3>
		          <p class="companyInfoText">할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.</p>
		          <p class="companyInfoText">할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.할말이 없다.</p>
		        </div>
		      </div>
		    </div>
		  </div>
		  
		</div>
	</div>


<jsp:include page="footer.jsp" />
    