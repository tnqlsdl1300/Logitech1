<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
	
	.container{
		width: 100%;
		margin: 0 auto;
	}
	
	div#searchRankingBox{
		padding-top: 30px;
	}
	
	div#searchRankingBox h3{
		font-weight: bold;
	}
	
	div.input-group{
		
		margin-bottom: 0;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		// 검색시 검색결과 페이지로 이동(임시구현)
		$("button#M_searchBtn").click(function() {
			
			window.parent.closeModal();
			window.parent.href("/Logitech/searchResult.jsp");
			
		});
		
	});

</script>

  
  <form action="/action_page.php">
  	
    <div class="container">
    	
	   	<div class="input-group">
	   		<input hidden="hidden" /><%-- 엔터 누를 시 자동 submit 방지 --%>
	  	 	<input type="text" class="form-control" placeholder="Search">
		    	<div class="input-group-btn">
		       	 <button class="btn btn-default" type="button" id="M_searchBtn">
		       	 <i class="glyphicon glyphicon-search"></i>
		      </button>
		    </div>
	    </div>
	    
    	<div id="searchRankingBox">
    		
    		<h3>인기검색어</h3>
    	
	    	<div class="list-group">
	    	  <c:forEach var="keywordVO" items="${ rankingList }" varStatus="status">
	    	  	<a href="#" class="list-group-item">${status.index+1}. ${ keywordVO.keyword }</a>
	    	  </c:forEach>
			</div>
		</div>
    </div>
    
  </form>

    