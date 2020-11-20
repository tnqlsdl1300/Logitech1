<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../managerHeader.jsp" />

<style>
#productState {
	float: left;
	width: 95%;
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

#sizePerPage {
	height: 30px;
}

#tblProduct {
	width: 100%;
}

#tblProduct > thead > tr {
	background-color: #bfbfbf;
}

#tblProduct, #tblProduct tr, #tblProduct th, #tblProduct td {
	border: solid 1px #ccc;
	text-align: center;
}

#tblProduct th, #tblProduct td {
	height: 70px;
}

#tHeadRow > th:hover {
	background-color: #e6ffe6;
	cursor: pointer;
}

tr.poptionInfo:hover {
	background-color: #e6e6e6;
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
		});// end of $("tr.memberInfo").click(function(){})----------------------
		
		$("tr.poptionInfo > td.productRow").click(function(){
			var productserialid = $(this).parent().children(".productserialid").text();
			
			location.href = "<%= ctxPath%>/manager/product/prodOptionOneDetail.sg?productserialid="+productserialid+"&goBackURL=${goBackURL}";
		});// end of $("tr.memberInfo").click(function(){})----------------------
		
		
		// @@ 재고량 update @@ //
		$("button#stockHandle").click(function(){
			var flag = false;
			
			$(".stockUpdate").each(function(){
				var stockUpdate = $(this).val().trim();
				
				if(stockUpdate != null) {
					var regExp = /^-?\d*(.\d+)?$/;
					// console.log(regExp.test(stockUpdate));
					if(!regExp.test(stockUpdate)) {
						flag = true;
						return;
					}
				}
			});
			
			if(flag) {
				alert("재고 관리를 위한 올바른 숫자만 입력해주세요.");
				return;
			} else {
				goSearch();
			}
		});// end of $("button#stockHandle").click(function(){})------------------------
	});// end of $(document).ready(function(){})--------------------------
	
	function goSearch() {
		var frm = document.frmList;
		frm.action = "<%= ctxPath%>/manager/product/productOptionList.sg";
		frm.method = "get";
		frm.submit();
	}// end of function goSearch(){}------------------------
</script>

<form name="frmList">
	<div id="productState">
		<div class="row">
			<div class="col-sm-12">
				<div class="well" style="background-color: white;">
					<h4>제품 목록</h4> 
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well divCell" style="background-color: white;">
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
						<option value="5">5개씩 보기</option>
						<option value="10" selected="selected">10개씩 보기</option>
						<option value="20">20개씩 보기</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well divContent" style="background-color: white;">
					<table id="tblProduct">
						<thead>
							<tr id="tHeadRow" align="center">
								<th>제품아이디<span class="hiddenVal">fk_productid</span><span class="hiddenSort">desc</span></th>
								<th>제품판매아이디<span class="hiddenVal">productserialid</span><span class="hiddenSort">desc</span></th>
								<th>카테고리<span class="hiddenVal">fk_category</span><span class="hiddenSort">desc</span></th>
								<th>색상<span class="hiddenVal">color</span><span class="hiddenSort">desc</span></th>
								<th>할인종료일<span class="hiddenVal">saleday</span><span class="hiddenSort">desc</span></th>
								<th>재고<span class="hiddenVal">stock</span><span class="hiddenSort">desc</span></th>
								<th>재고수정</th>	
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="povo" items="${poList}">
								<tr class="poptionInfo">
									<td class="productRow">${povo.fk_productid}</td>
									<td class="productserialid productRow">${povo.productserialid}<input type="hidden" name="productserialid" value="${povo.productserialid}" /></td>
									<td class="productRow">${povo.pvo.fk_category}</td>
									<td class="productRow">${povo.color}</td>
									<td class="productRow">${povo.saleday}</td>
									<td class="productRow">${povo.stock}</td>
									<td><input class="stockUpdate" name="stockUpdate" size="10" placeholder="부호 포함(+1/-1)" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div id="divBar" style="background-color: white; margin: 30px;">
						${pageBar}
						
						<div style="float: right;">
							<button type="button" id="stockHandle" style="border: none; width: 150px; height: 50px; background-color: #1a1a1a; color: white; text-align: center;">재고량 관리</button>
							<span id="resultConfirm"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<jsp:include page="../managerFooter.jsp" />