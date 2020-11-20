<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../managerHeader.jsp" />

<style>
#prodOptionState {
	float: left;
	width: 95%;
	margin: 20px;
}

.divCell, .divContent {
}

div#povoInfo {
	width: 95%;
	text-align: left;
	border: solid 0px red;
	margin-top: 30px; 
	font-size: 13pt;
	line-height: 200%;
}

#tblProduct {
	width: 100%;
	height: 500px;
	margin: 20px 25px;
}

#tblProduct > tr > td {
	height: 100px;
}

.liInfo {
	display: inline-block;
	width: 3px;
	height: 35px;
	background-color: #ccc;
	vertical-align: middle;
	margin-right: 50px;
}

/* ============================================= */
/* SMS 보내기 */
/*
div#sms {
	margin: 0 auto; 
	/* border: solid 1px red;
	overflow: hidden; 
	width: 50%;
	padding: 10px 0 10px 80px;
}

span#smsTitle {
	display: block;
	font-size: 13pt;
	font-weight: bold;
	margin-bottom: 10px;
}

textarea#smsContent {
	float: left;
	height: 100px;
}

button#btnSend {
	float: left;
	border: none;
	width: 50px;
	height: 100px;
	background-color: navy;
	color: white;
}

div#smsResult {
	clear: both;
	color: red;
	padding: 20px;
}
*/
</style>

<script type="text/javascript">
	var goBackURL = "";

	$(document).ready(function(){
		$(".error").hide();
		
		goBackURL = "${goBackURL}";
		
		goBackURL = goBackURL.replace(/   /gi, "&");
	});// end of $(document).ready(function(){})-----------------------------
	
	function goProdUpdate() {
		var queryString = $("form[name=prodUpdateFrm]").serialize();
		
		$.ajax({
			url:"/Logitech/manager/product/productUpdate.sg",
			type:"POST",
			data:queryString,
			success:function(){
				$("span#updateResult").html("수정에 성공하였습니다.");
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}// end of function goProdUpdate() {}----------------------------
	
	function goProdOptionList() {
		location.href = "/Logitech/"+goBackURL;
	}// end of function goProdOptionList(){}-----------------------------
</script>

<form name="prodUpdateFrm">
<div id="prodOptionState">
	<div class="row">
		<div class="col-sm-12">
			<div class="well" style="background-color: white;">
				<h4>제품 정보</h4> 
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="well divContent" style="background-color: white;">
				<c:if test="${empty povo}">
					존재하지 않는 제품입니다.<br>
				</c:if>
				
				<c:if test="${not empty povo}">
					<h3 style="margin-left: 40px;">${povo.productserialid} 의 상세 정보</h3>
					<hr style="height: 8px; background-color: #ccc; margin: 30px 0;">
					<div id="povoInfo" style="background-color: white;">
						<table id="tblProduct">
							<tr>
							   <td class="myli" style="font-weight: bold;">제품아이디&nbsp;<span class="star">*</span></td>
							   <td style="text-align: left;">
								   <div class="liInfo"></div>
								   <input type="text" name="productid" id="productid" value="${povo.pvo.productid}" class="requiredInfo" size="30" required /> 
								   <span class="error">제품아이디는 필수 입력사항입니다.</span>
							   </td>
							</tr>
							<tr>
								<td class="myli" style="font-weight: bold;">제품 일련번호&nbsp;<span class="star">*</span></td>
								<td style="text-align: left;">
									<div class="liInfo"></div>
									<input type="text" name="productserialid" id="productserialid" value="${povo.productserialid}" class="requiredInfo" size="30" required />
									<span class="error">제품 일련번호는 필수 입력사항입니다.</span>
								</td>
							</tr>
							<tr>
								<td class="myli" style="font-weight: bold;">제품명&nbsp;<span class="star">*</span></td>
								<td style="text-align: left;">
									<div class="liInfo"></div>
									<input type="text" name="productname" id="productname" value="${povo.pvo.productname}" class="requiredInfo" size="30" required />
									<span class="error">제품명은 필수 입력사항입니다.</span>
								</td>
							</tr>
							<tr>
								<td class="myli" style="font-weight: bold;">색상&nbsp;<span class="star">*</span></td>
								<td style="text-align: left;">
									<div class="liInfo"></div>
									<input type="text" name="color" id="color" value="${povo.color}" class="requiredInfo" size="30" required />
									<span class="error">색상은 필수 입력사항입니다.</span>
								</td>
							</tr>
							<tr>
								<td class="myli" style="font-weight: bold;">특징&nbsp;<span class="star">*</span></td>
								<td style="text-align: left;">
									<div class="liInfo"></div>
									<input type="text" name="character" id="character" value="${povo.pvo.character}" class="requiredInfo" size="30" required />
									<span class="error">특징은 필수 입력사항입니다.</span>
								</td>
							</tr>
							<tr>
								<td class="myli" style="font-weight: bold;">가격&nbsp;<span class="star">*</span></td>
								<td style="text-align: left;">
									<div class="liInfo"></div>
									<input type="text" name="price" id="price" value="${povo.pvo.price}" class="requiredInfo" size="30" required />
									<span class="error">가격은 필수 입력사항입니다.</span>
								</td>
							</tr>
							<tr>
								<td class="myli" style="font-weight: bold;">재고량&nbsp;<span class="star">*</span></td>
								<td style="text-align: left;">
									<div class="liInfo"></div>
									<input type="text" name="stock" id="stock" value="${povo.stock}" class="requiredInfo" size="30" required />
									<span class="error">재고량은 필수 입력사항입니다.</span>
								</td>
							</tr>
							<tr>
								<td class="myli" style="font-weight: bold;">할인 종료일&nbsp;<span class="star">*</span></td>
								<td style="text-align: left;">
									<div class="liInfo"></div>
									<input type="text" name="saleday" id="saleday" value="${povo.saleday}" class="requiredInfo" size="30" disabled="disabled" required />
									<span class="error">할인 종료일은 필수 입력사항입니다.</span>
								</td>
							</tr>
						</table>
						
						<button type="button" style="margin: 50px 100px; border: none; width: 150px; height: 50px; background-color: #1a1a1a; color: white; text-align: center;" onclick="goProdUpdate();">제품 수정</button>
						<span id="updateResult" style="font-size: 15pt; font-weight: bold; background-color: white;"></span>
					</div>
				</c:if>
				
				<div style="background-color: white; margin: 0 100px;">
					<button type="button" style="border: none; width: 150px; height: 50px; background-color: #1a1a1a; color: white; text-align: center;" onclick="javascript:goProdOptionList();">제품목록으로 이동</button>
				</div>
			</div>
		</div>
	</div>
</div>
</form>

<jsp:include page="../managerFooter.jsp" />