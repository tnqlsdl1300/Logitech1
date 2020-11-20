<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../header.jsp" />

<%
	String ctxPath = request.getContextPath();
%>



<style>




div.c_container {
	display: flex;
	font-family: "배달의민족 도현";
}

.item {
	
}


.item1 {
	width: 15%;
	margin-right: 2%;
}

.item2 {
	width: 83%;
	background-color: white;
}

div#header {
	display: flex;
}

header.item1 {
	width: 30%;
	margin-right: 2%;
}

header.item2 {
	width: 68%;

	/* 중간으로 오게하기. */
}





table {
	width: 100%;
	border: 1px solid black;
}

table, th, td {
	border: 1px solid black;
}

div.right {
	text-align: center;
	
	display : flex;
	flex-direction: column;
	justify-content:center;
	align-items:center;
	
	
	background-image: url("images/배경이미지.png");
	background-repeat: no-repeat;
	background-size: cover;
	width: 80%;
	height: 170px;
}

img.centerimage {
	height: 170px;
	width: 172.5px;
}


.btn-default {
	color: #333;
	background-color: #fff;
	border-color: #ccc;
	height: 34px;
}

.vertical-menu {

	text-decoration: none;
	
}

.vertical-menu a {
	
	background-color : #eee;
	color: black;
	display: block;
	padding: 12px;
	background-color: #eee;
}

.vertical-menu a:hover {
	background-color: #ccc;
	transition: all ease 1s 0s;
	
}

.vertical-menu a.active {
	background-color: #4CAF50;
	color: white;
}

/////////////////////////////////sidebar Dropdown

/* Fixed sidenav, full height */

.sidenav {
  
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  padding-top: 20px;
}


/* Style the sidenav links and the dropdown button */
.sidenav a, .dropdown-btn {

  padding: 6px 8px 6px 16px;
  text-decoration: none;
  padding: 20px;
  color: white;
  display: block;
  border: none;
  background-color: #111;
  width: 100%;
  text-align: left;
  cursor: pointer;
  outline: none;
  font-weight: 100;
  
	

}

/* On mouse-over */
.sidenav a:hover, .dropdown-btn:hover {
  color: black;
	background-color: white;
	transition: all ease 1s 0s;
	text-decoration: none;
}



/* Add an active class to the active dropdown button */
.active {
  background-color: green;
  color: white;
}



.dropdown-container {
  display: none;
  background-color: #262626;
  padding-left: 8px;
}


/* Optional: Style the caret down icon */
.fa-caret-down {
  float: right;
  padding-right: 8px;
}


.serch-result {
	cursor: pointer;
}

.table-condensed {
	margin-left: auto;
	margin-right: auto;
	text-align: center;
	
}



div#pageBar {
	
	display: solid 1px red; 
	
};


</style>


<script type="text/javascript">
	

	$(document).ready(function () {
		
		$("button#submitbtn").click(function () {
			

			
	
			
			});
		
		$("button#oneqbtn").click(function () {
			
			location.href = "<%= ctxPath%>/oneQueryForm.sg";
			
		});
		
		
		///////////////////////// SideBar 버튼함수 /////////////////////////

		  $("button.dropdown-btn").click(function (e) { 
				
				var dropdownContent=$("button.dropdown-btn").children()

				$(this).toggleClass("active");

				if($(".dropdown-container").css('display') === "block") {

					$(".dropdown-container").css('display', 'none');
					dropdownContent.css('display', 'none');
					$("i.fa-caret-down").show();

					
					
				}

				else {
					
					$(".dropdown-container").css('display', 'block');
					dropdownContent.css('display', 'block');
					
				}
				
			});

		///////////////////////// SideBar 버튼함수 /////////////////////////
		
		  $("button#submitbtn").click(function () {

				goSearch();
			
				});
			
			$("input#searchWord").bind("keyup", function(event) {
				if(event.keyCode == 13) {
					goSearch();
				}
				
			});	
			
			if("${searchWord}" != "") {
				
				$("input#searchWord").val("${searchWord}");
				
			} 
		
		
		
	}); // end of $(document).ready(function () {}
	
	
	function goSearch() {
		
		var frm=document.serchFrm;
		frm.action = "<%= ctxPath%>/customCenter.sg";
		frm.method="get";
		frm.submit();
		
	}
	
	
	<%--
	window.history.forward();

	function noBack() {

		window.history.forward();

	}
	--%>
	
	


</script>

<div id="wrap">



<div class="c_container">

	<div class="item item1">



		<div>
			<img class="centerimage" src="<%=ctxPath%>/images/고객센터.png" alt="고객센터">

		</div>
		
		<br>
		<br>
		<br>
		
		<div class="sidenav">
		  <a href="<%=ctxPath%>/customCenter.sg" class="active">고객센터 홈</a>
			<button class="dropdown-btn">자주묻는 질문 
		    <i class="fa fa-caret-down"></i>
		  </button>
		  <div class="dropdown-container">
		  <c:forEach var="list" items="${categorylist}" varStatus="status">
		  
		  	<c:choose>
					    <c:when test="${list.category eq '10'}">
							<a href="<%=ctxPath%>/customCenter.sg?searchSub=${list.category}">회원정보/멤버십</a>
					 	</c:when>

						<c:when test="${list.category eq '20'}">
							<a href="<%=ctxPath%>/customCenter.sg?searchSub=${list.category}">주문/결제</a>
						</c:when>
	
						<c:when test="${list.category eq '30'}">
							<a href="<%=ctxPath%>/customCenter.sg?searchSub=${list.category}">거래증빙서류</a>
						</c:when>
						
						<c:otherwise>
							<a href="<%=ctxPath%>/customCenter.sg?searchSub=${list.category}">배송</a>
						</c:otherwise>
			</c:choose>
			
			
		    </c:forEach>
		    
		  </div>
		  <a href="<%=ctxPath%>/oneQueryForm.sg">1:1 문의하기</a>
		  
		  <a href="<%=ctxPath%>/oneQueryView.sg">1:1 문의내역 조회</a>

		  </div>
		
		
	</div>


	<div class="item item2">

		<div id="header">
			<div class="header itme1 left">
				<img src="<%=ctxPath%>/images/FAQ.png" alt="FAQ">
			</div>
			
			
			<div class="header itme2 right">
				<h1>무엇을 도와드릴까요?</h1>
				
			  
			    <div class="input-group">
			     <form name="serchFrm" class="serch-form">
			      <input type="text" id="searchWord"class="form-control" placeholder="Search" name="searchWord" style="width: 500px">
			      <button id="subMitBtn" class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
			      </form>
			   </div>
			  
			  
			  	 <DIV>
					<span>검색결과가 충분하지 못하면 1:1문의를 이용하세요</span> <button id="oneqbtn">1:1 문의</button>
				</DIV>    
			</div>
			  
		</div>
			
			
			<div>

			<br> <br>
			
			
			<table>
					<c:choose>
					<c:when test="${searchSub eq '10'}">
					<h2>자주 묻는 질문 (FAQ)</h2>
						<tr>
							<th>회원정보/멤버십</th>
						</tr>
						
						<tr>
							<td>
								<a href="<%=ctxPath%>/customCenter.sg?searchSub=${searchSub}">전체보기</a>		
								<c:forEach var="subcate" items="${scatelist}"  varStatus="status">
								<a href="<%=ctxPath%>/customCenter.sg?&searchSubcate=${subcate.subCategory}&searchSub=${searchSub}">${subcate.subCategory}</a>
								</c:forEach>
							</td>
						</tr>
						
					 		</c:when>

						<c:when test="${searchSub eq '20'}">
						<h2>자주 묻는 질문 (FAQ)</h2>
							<tr>
								<th>주문/결제</th>
							</tr>
						<tr>
						
							<td>
								<a href="<%=ctxPath%>/customCenter.sg?searchSub=${searchSub}">전체보기</a>		
								<c:forEach var="subcate" items="${scatelist}"  varStatus="status">
								<a href="<%=ctxPath%>/customCenter.sg?&searchSubcate=${subcate.subCategory}&searchSub=${searchSub}">${subcate.subCategory}</a>
								</c:forEach>
							</td>
						</tr>
						</c:when>
	
						<c:when test="${searchSub eq '30'}">
						<h2>자주 묻는 질문 (FAQ)</h2>
						<tr>
							<th>거래증빙서류</th>
						</tr>
						<tr>
							<td>
								<a href="<%=ctxPath%>/customCenter.sg?searchSub=${searchSub}">전체보기</a>		
								<c:forEach var="subcate" items="${scatelist}"  varStatus="status">
								<a href="<%=ctxPath%>/customCenter.sg?&searchSubcate=${subcate.subCategory}&searchSub=${searchSub}">${subcate.subCategory}</a>
								</c:forEach>
							</td>
						</tr>
						</c:when>
						
						<c:when test="${searchSub eq '40'}">
						<h2>자주 묻는 질문 (FAQ)</h2>
						<tr>
								<th>배송</th>
						</tr>
						<tr>
							<td>
								<a href="<%=ctxPath%>/customCenter.sg?searchSub=${searchSub}">전체보기</a>		
								<c:forEach var="subcate" items="${scatelist}"  varStatus="status">
								<a href="<%=ctxPath%>/customCenter.sg?&searchSubcate=${subcate.subCategory}&searchSub=${searchSub}">${subcate.subCategory}</a>
								</c:forEach>
							</td>
						</tr>
						</c:when>
						<c:otherwise>
						
						</c:otherwise>
					</c:choose>
				

				
			</table>
			
			</div>

			<br>
			
			 <table class="table table-condensed">

  				<h3>FAQ ${searchResult} 건</h3>
  				
				    <tbody>
				    
				<%-- 일단은 페이징처리를 안한 모든 faq를 조회하도록 한다. --%>
				
				<c:forEach var="faqvo" items="${faqList}" varStatus="status">

					<tr class="serch-result">
						<td><span><i class="glyphicon glyphicon-search"></i></span></td>
						<td><span>${faqvo.suq_category}</span></td>
						<td><span>${faqvo.title}</span> </td>
						<td><span><i class="fa fa-caret-down"></i></span> </td>
					</tr>
						
					<tr class="answe" id="" style="display:none;">
		                  <td class="type"><span>답변</span></td>
		                  <td colspan="3" class="substance"><p>&nbsp;</p><p>${faqvo.content}</p><p>&nbsp;</p></td>
		            </tr>
					
				</c:forEach>
								
				     </tbody>
				     
			  </table>
				<a href="<%= ctxPath%>/review.sg">리뷰보기</a>
				
				<div id="pageBar">
		    		${pageBar}
		    	</div>		
		</div>
	
		
	</div>

</div>
	


<jsp:include page="../footer.jsp" />