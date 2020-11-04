<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	
	div.input-group{
		
		margin-bottom: 30%;
	}
	
</style>

  
  <form action="/action_page.php">
  	
    <div class="container">
    	
	   	<div class="input-group">
	  	 	<input type="text" class="form-control" placeholder="Search">
		    	<div class="input-group-btn">
		       	 <button class="btn btn-default" type="submit">
		       	 <i class="glyphicon glyphicon-search"></i>
		      </button>
		    </div>
	    </div>
	    
    
    	<div class="list-group">
		  <a href="#" class="list-group-item">1. 인체공학</a>
		  <a href="#" class="list-group-item">2. 게이밍</a>
		  <a href="#" class="list-group-item">3. 무선</a>
		  <a href="#" class="list-group-item">4. 블루투스</a>
		  <a href="#" class="list-group-item">5. 업무용</a>
		</div>
    </div>
    
  </form>

    