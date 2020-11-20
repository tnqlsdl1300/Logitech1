<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../managerHeader.jsp" />

<style>
#eventState {
	float: left;
	width: 75%;
	margin: 20px;
}

.divCell, .divContent {
	text-align: center;
}

#searchOption1, #searchOption2 {
	height: 30px;
	margin-right: 10px;
}

#searchKey1, #searchKey2 {
	width: 150px;
	height: 30px;
	margin-right: 20px;
}

#btnSearch {
	margin-right: 20px;
}

#searchSize {
	height: 30px;
}

#tblEvent {
	width: 100%;
}

#tblEvent, #tblEvent tr, #tblEvent th, #tblEvent td {
	border: solid 1px gray;
	text-align: center;
}

#tblEvent th, #tblEvent td {
	height: 70px;
}

#tHeadRow:hover {
	background-color: #e6ffe6;
	cursor: pointer;
}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$("span.hiddenVal").hide();
		$("span.hiddenSort").hide();
	
		if("${sortFlag}" != null) {
			$(".hiddenSort").html("${sortFlag}");
		}
		
		if("${searchKey1}" != "") {  // 처음에는 검색어가 있지 않기 때문에 if 문으로 경우를 나눈다.
			$("select#searchOption1").val("${searchOption1}");
			$("input#searchKey1").val("${searchKey1}");
		}// end of if("${searchKey1}" != ""){}---------------------
		
		if("${searchKey2}" != "") {  // 처음에는 검색어가 있지 않기 때문에 if 문으로 경우를 나눈다.
			$("select#searchOption2").val("${searchOption2}");
			$("input#searchKey2").val("${searchKey2}");
		}// end of if("${searchKey1}" != ""){}---------------------
		
		var searchKey1 = $("input#searchKey1").val().trim();
		
		if(searchKey1 == "") {
			$("input#searchKey2").prop("disabled", true);
		}// end of if(searchKey1 == ""){}------------------------
		
		$("input#searchKey1").blur(function(){
			if($(this).val().trim() != "") {
				$("input#searchKey2").prop("disabled", false);
			} else {
				$("input#searchKey2").prop("disabled", true);
			}// end of if($(this).val().trim() != ""){}------------------------
		})// end of $("input#searchKey1").blur(function(){})------------------------
		
		$("input#searchKey1").keyup(function(event){
			if(event.keyCode == 13) {  // 검색어에서 엔터를 치면 검색되도록 한다.
				goSearch();
			}// end of if(event.keyCode == 13){}-----------------
		});// end of $("input#searchKey1").keyup(function(){})--------------------
		
		$("input#searchKey2").keyup(function(event){
			if(event.keyCode == 13) {  // 검색어에서 엔터를 치면 검색되도록 한다.
				goSearch();
			}// end of if(event.keyCode == 13){}-----------------
		});// end of $("input#searchKey2").keyup(function(){})--------------------
				
		$("select#sizePerPage").bind("change", function(){
			goSearch();
		});// end of $("select#sizePerPage").bind("change", function(){})-------------------
		
		if("${sizePerPage}" != "") {
			$("select#sizePerPage").val("${sizePerPage}");
		}// end of if("${sizePerPage}" != ""){}------------------------
		
		$("tr#tHeadRow > th").click(function(){
			var selectedHead = $(this).children(".hiddenVal").text();
			var sortFlag = $(this).children(".hiddenSort").text();
			
			if(sortFlag == "asc") {
				sortFlag = "desc";
			} else {
				sortFlag = "asc";
			}// end of if(sortFlag == asc){}--------------------
			
			location.href = '<%= ctxPath%>/manager/product/productOptionList.sg?currentPageNo=1&sizePerPage='+"${sizePerPage}"+'&searchOption1='+"${searchOption1}"+'&searchKey1='+"${searchKey1}"+'&searchOption2='+"${searchOption2}"+'&searchKey2='+"${searchKey2}"+'&selectedHead='+selectedHead+'&sortFlag='+sortFlag;
		});// end of $("tr#tHeadRow > th").click(function(){})----------------------
		
		$("tr.ecouponInfo").click(function(){
			var seq_event = $(this).children(".seq_event").text();
			
			location.href = "<%= ctxPath%>/manager/promotion/eventOneDetail.sg?seq_event="+seq_event+"&goBackURL=${goBackURL}";
		});// end of $("tr.ecouponInfo").click(function(){})----------------------
	});// end of $(document).ready(function(){})--------------------------
	
	function goSearch() {
		var frm = document.frmList;
		frm.action = "<%= ctxPath%>/manager/promotion/.sg";
		frm.method = "get";
		frm.submit();
	}// end of function goSearch(){}------------------------
</script>

<form name="frmList">
	<div id="eventState">
		<div class="row">
			<div class="col-sm-12">
				<div class="well">
					<h4>이벤트 관리</h4> 
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well divCell">
					<select id="searchOption1" name="searchOption1">
						<option>옵션1</option>
						<option value="fk_productid">제품아이디</option>
						<option value="productserialid">제품판매아이디</option>
						<option value="fk_category">카테고리</option>
						<option value="color">색상</option>
						<option value="saleday">할인종료일</option>
						<option value="stock">재고</option>
					</select>
					
					<input type="text" id="searchKey1" name="searchKey1" placeholder="1차 검색 조건" />
					
					<select id="searchOption2" name="searchOption2">
						<option>옵션2</option>
						<option value="fk_productid">제품아이디</option>
						<option value="productserialid">제품판매아이디</option>
						<option value="fk_category">카테고리</option>
						<option value="color">색상</option>
						<option value="saleday">할인종료일</option>
						<option value="stock">재고</option>
					</select>
					
					<input type="text" id="searchKey2" name="searchKey2" placeholder="2차 검색 조건" />
					
					<button type="button" id="btnSearch" onclick="goSearch();">검색</button>
					
					<select id="sizePerPage" name="sizePerPage">
						<option value="5">5건씩 보기</option>
						<option value="10" selected="selected">10건씩 보기</option>
						<option value="20">20건씩 보기</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well divContent">
					<table id="tblEvent">
						<thead>
							<tr id="tHeadRow" align="center">
								<th>이벤트번호<span class="hiddenVal">seq_event</span><span class="hiddenSort">desc</span></th>
								<th>이벤트명<span class="hiddenVal">eventname</span><span class="hiddenSort">desc</span></th>
								<th>이벤트제품<span class="hiddenVal">fk_productid</span><span class="hiddenSort">desc</span></th>
								<th>시작일자<span class="hiddenVal">startday</span><span class="hiddenSort">desc</span></th>
								<th>종료일자<span class="hiddenVal">endday</span><span class="hiddenSort">desc</span></th>
								<th>선택<input type="checkbox" /></th>	
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="evo" items="${evoList}">
								<tr class="eventInfo">
									<td class="seq_event">${evo.seq_event}</td>
									<td>${evo.eventname}</td>
									<td>${evo.fk_productid}</td>
									<td>${evo.startday}</td>
									<td>${evo.endday}</td>
									<td><input type="checkbox" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div>
						${pageBar}
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<jsp:include page="../managerFooter.jsp" />