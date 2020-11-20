<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../managerHeader.jsp" />

<style>
#purchaseState {
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

#searchSize {
	height: 30px;
}

#tblPurchase {
	width: 100%;
}

#tblPurchase > thead > tr {
	background-color: #bfbfbf;
}

#tblPurchase, #tblPurchase tr, #tblPurchase th, #tblPurchase td {
	border: solid 1px gray;
	text-align: center;
}

#tblPurchase th, #tblPurchase td {
	height: 70px;
}

#tHeadRow > th:hover {
	background-color: #e6ffe6;
	cursor: pointer;
}

tr.pdetailInfo:hover {
	background-color: #e6e6e6;
	cursor: pointer;
}

ol {
	list-style: none;
}

li {
	line-height: 30px;
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
		
		$("tr.pdetailInfo > td.purchaseRow").click(function(){
			var fk_purchaseno = $(this).parent().children(".fk_purchaseno").text();
			var detailtotalpay = $(this).parent().children(".detailtotalpay").text();
			var discount = $(this).parent().children(".discount").text();
			
			$.ajax({
				url:"/Logitech/manager/purchase/purchaseOneDetail.sg",
				type:"GET",
				data:{"fk_purchaseno":fk_purchaseno,
					"detailtotalpay":detailtotalpay,
					"discount":discount},
				dataType:"json",
				success:function(json){
					var html = "<h3 style='width:100%; height: 50px; background-color: #999; padding-top: 13px;'>상품 내역</h3>";
					
					if(json.length > 0) {
						$.each(json, function(index, item){
							html += "<div style='float: left; background-color: white; margin: 20px 100px;'><img src='"+item.imgfilename+"' style='width: 150px; height: 150px;' /></div>" +
									"<div style='float: left; width: 400px; background-color: white; margin: 20px 100px;'>" +
										"<ol>" +	
										"<li><span class='myli'>주문상세번호 : </span><span class='purchasedetailid'>"+item.purchasedetailid+"</span></li>" +
										"<li><span class='myli'>제품판매아이디 : </span><span class='productserialid'>"+item.fk_productserialid+"</span></li>" +
										"<li><span class='myli'>주문량 : </span><span class='stock'>"+item.volume+"</span></li>" +
										"<li><span class='myli'>제품가격 : </span>"+item.price+"</li>" +
										"<li><span class='myli'>상태 : </span>"+item.deliverystatus+"</li>" +
									"</ol>" +
									"</div>" +
									"<div style='float: right; background-color: white; margin: 85px 20px;'>" +
										"<label for='eachSelect"+index+"'>선택</label>&nbsp;&nbsp;<input type='checkbox' name='' class='eachSelect' id='eachSelect"+index+"' />" +
									"</div>" +
									"<div style='clear: both; width: 100%; height: 3px; background-color: #b3b3b3;'></div>";
						});
					}// end of if(json.length > 0) {}-------------------------
					
					$("div.pdListInfo").html(html);
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   }
			});
			
			// 주문자 정보
			$.ajax({
				url:"/Logitech/manager/purchase/purchaseMember.sg",
				type:"GET",
				data:{"fk_purchaseno":fk_purchaseno,
					"detailtotalpay":detailtotalpay,
					"discount":discount},
				dataType:"json",
				success:function(json){
					var html = "<div style='float: left; width: 40%; background-color: white; margin: 20px 30px;'>" +
							"<h3 style='width:100%; height: 50px; background-color: #999; padding-top: 13px;'>주문 내역</h3>" +
							"<ol>" +
								"<li><span class='myli'>주문번호 : </span>"+json.purchaseno+"</li>" +
								"<li><span class='myli'>주문인 : </span>"+json.name+"</li>" +
								"<li><span class='myli'>수령인 : </span>"+json.receiver+"</li>" +
								"<li><span class='myli'>우편번호 : </span>"+json.postcode+"</li>" +
								"<li><span class='myli'>주소 : </span>"+json.address+"&nbsp;"+json.detailaddress+"&nbsp;"+json.extraaddress+"</li>" +
								"<li><span class='myli'>주문일자 : </span>"+json.purchaseday+"</li>" +
							"</ol>" +
							"</div>" +
							
							"<div style='float: right; width: 40%; background-color: white; margin: 20px 30px;'>" +
							"<h3 style='width:100%; height: 50px; background-color: #999; padding-top: 13px;'>결제 내역</h3>" +
							"<ol>" +	
								"<li><span class='myli'>제품금액 : </span>"+json.totalprice+"원</li>" +
								"<li><span class='myli'>할인금액 : </span>"+json.discount+"원</li>" +
								"<li><span class='myli'>결제금액 : </span>"+json.totalprice+"원</li>" +
								"<li><span class='myli'>결제수단 : </span>"+json.payment+"</li>" +
							"</ol>" +
							"</div>";
					
					$("div.pdMember").html(html);	
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
			var collapseStatus = $("span#collapseStatus").text();
			
			if(collapseStatus == "hide") {
				collapseStatus = "show";
			} else {
				collapseStatus = "hide";
			}// end of if(sortFlag == asc){}--------------------
			
		});// end of $("tr.memberInfo").click(function(){})----------------------
		
		// collapse 영역이 열린 후 이벤트
		$(".collapse").on("shown.bs.collapse", function(){
			$("button#purchaseHandle").hide();
		});
		
		// collapse 영역이 닫힌 후 이벤트
		$(".collapse").on("hidden.bs.collapse", function(){
			$("button#purchaseHandle").show();
		});
		
		// 개별 상품 배송하기
		$("button#btnDelivery").click(function(){
			var $target = $(this).parent().find(".eachSelect");
			
			$target.each(function(){
				if($(this).prop("checked")) {
					var purchasedetailid = $(this).parent().parent().find(".purchasedetailid").text();
					var productserialid = $(this).parent().parent().find(".productserialid").text();
					var stock = $(this).parent().parent().find(".stock").text();
					
					console.log(purchasedetailid);
					
					$.ajax({
						url:"/Logitech/manager/purchase/deliverProduct.sg",
						type:"POST",
						data:{"purchasedetailid":purchasedetailid,
							"productserialid":productserialid,
							"stock":stock},
						success:function(){
							alert("배송 처리에 성공하였습니다.");
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
					});
				}
			});// end of $target.each(function(){})-------------------------
		});// end of $("button#btnDelivery").click(function(){})------------------------
		
		$("button#purchaseHandle").click(function(){
			$("input.purchaseCheck").each(function(){
				
			});
		});// end of $("button#purchaseHandle").click(function(){})----------------------------
	});// end of $(document).ready(function(){})--------------------------
	
	function goSearch() {
		var frm = document.frmList;
		frm.action = "<%= ctxPath%>/manager/purchase/purchaseList.sg";
		frm.method = "get";
		frm.submit();
	}// end of function goSearch(){}------------------------
</script>

<form name="frmList">
	<div id="purchaseState">
		<div class="row">
			<div class="col-sm-12">
				<div class="well" style="background-color: white;">
					<h4>주문 현황</h4> 
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well divCell" style="background-color: white;">
					<select id="searchOption1" name="searchOption1">
						<option>옵션1</option>
						<option value="productserialid">제품판매아이디</option>
						<option value="fk_category">카테고리</option>
						<option value="color">색상</option>
						<option value="saleday">할인종료일</option>
						<option value="stock">재고</option>
					</select>
					
					<input type="text" id="searchKey1" name="searchKey1" placeholder="1차 검색 조건" />
					
					<select id="searchOption2" name="searchOption2">
						<option>옵션2</option>
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
				<div class="well divContent" style="background-color: white;">
					<table id="tblPurchase">
						<thead>
							<tr id="tHeadRow" align="center">
								<th>주문번호<span class="hiddenVal">fk_purchaseno</span><span class="hiddenSort">desc</span></th>
								<th>주문회원번호<span class="hiddenVal">fk_memberno</span><span class="hiddenSort">desc</span></th>
								<th>결제수단<span class="hiddenVal">payment</span><span class="hiddenSort">desc</span></th>
								<th>주문일자<span class="hiddenVal">purchaseday</span><span class="hiddenSort">desc</span></th>
								<th>총 금액<span class="hiddenVal">detailtotalpay</span><span class="hiddenSort">desc</span></th>
								<th>결제금액<span class="hiddenVal">totalprice</span><span class="hiddenSort">desc</span></th>
								<th>할인금액<span class="hiddenVal">discount</span><span class="hiddenSort">desc</span></th>
								<th>상태<span class="hiddenVal">totalstatus</span><span class="hiddenSort">desc</span></th>
						<%--		<td style="font-weight:bold; background-color: #bfbfbf;"></td> --%>	
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="pdvo" items="${pdList}">
								<tr class="pdetailInfo" data-toggle="collapse" data-target="#demo">
									<td class="fk_purchaseno purchaseRow">${pdvo.fk_purchaseno}</td>
									<td class="purchaseRow">${pdvo.purcvo.fk_memberno}</td>
									<td class="purchaseRow">${pdvo.purcvo.payment}</td>
									<td class="purchaseRow">${pdvo.purcvo.purchaseday}</td>
									<td class="detailtotalpay purchaseRow">${pdvo.detailtotalpay}</td>
									<td class="purchaseRow">${pdvo.purcvo.totalprice}</td>
									<td class="discount purchaseRow">${pdvo.purcvo.discount}</td>
									<td class="purchaseRow">${pdvo.purcvo.totalstatus}</td>
							<%--		<td><input type="checkbox" class="purchaseCheck" /></td> --%>
								</tr>
								
								<tr id="demo" class="collapse">
									<td colspan="8">
										<div class="bundle" style="background-color: white; margin: 20px;">
											<div class="pdListInfo" style="background-color: white;">
											</div>
											
											<div class="pdMember" style="background-color: white;">
											</div>
											
											<button type='button' id='btnDelivery' style='border: none; margin-left: 265px; width: 150px; height: 50px; background-color: #333; color: white; text-align: center;'>배송</button>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div id="divBar" style="background-color: white; margin: 30px;">
						${pageBar}
						
						<div style="float: right;">
							<button type="button" id="purchaseHandle">주문 확인/배송</button>
						</div>
					</div>
					<%--
					<div id="bundle" style="background-color: white; margin: 30px;">
						<div id="pdListInfo">
							<c:forEach var="pdvo" items="pdList">
								<ol>	
									<li><span class="myli"></span><img src="${pdvo.imgfilename}" /></li>
									<li><span class="myli">주문상세번호 : </span>${pdvo.purchasedetailid}</li>
									<li><span class="myli">제품판매아이디 : </span>${pdvo.fk_productserialid}</li>
									<li><span class="myli">수량 : </span>${pdvo.volume}</li>
									<li><span class="myli">가격 : </span><span class="eachPrice">${pdvo.pvo.price}</span></li>
									<li><span class="myli">진행상태 : </span>${pdvo.deliverystatus}</li>
								</ol>
								 
								<hr style="width: 95%; color: black;">
							</c:forEach>
							--%>
							<%-- 주문자 정보
							<ol>	
								<li><span class="myli">주문번호 : </span>${purcvo.purchaseno}</li>
								<li><span class="myli">주문자 : </span>${purcvo.mvo.name}</li>
								<li><span class="myli">수령인 : </span>${purcvo.receiver}</li>
								<li><span class="myli">우편번호 : </span>${purcvo.postcode}</li>
								<li><span class="myli">주소 : </span>${purcvo.address}&nbsp;${purcvo.detailaddress}&nbsp;${purcvo.extraaddress}</li>
								<li><span class="myli">주문일자 : </span>${purcvo.purchaseday}</li>
							</ol>
							 --%>
							<%-- 결제 정보
							<ol>	
								<li><span class="myli">제품금액 : </span><span id="totalPrice"></span>원</li>
								<li><span class="myli">할인금액 : </span><span id="discountPrice"></span>원</li>
								<li><span class="myli">결제금액 : </span>${purcvo.totalprice}원</li>
								<li><span class="myli">결제수단 : </span>${purcvo.payment}</li>
							</ol>
						</div>
						--%>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<jsp:include page="../managerFooter.jsp" />