<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../managerHeader.jsp" />

<style>
#memberState {
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

#tblMember {
	width: 100%;
}

#tblMember > thead > tr {
	background-color: #bfbfbf;
}

#tblMember, #tblMember tr, #tblMember th, #tblMember td {
	border: solid 1px #ccc;
	text-align: center;
}

#tblMember th, #tblMember td {
	height: 70px;
}

#tHeadRow > th:hover {
	background-color: #e6ffe6;
	cursor: pointer;
}

tr.memberInfo:hover {
	background-color: #e6e6e6;
	cursor: pointer;
}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		func_height();
		
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
			
			location.href = '<%= ctxPath%>/manager/member/memberList.sg?currentPageNo=1&sizePerPage='+"${sizePerPage}"+'&searchOption1='+"${searchOption1}"+'&searchKey1='+"${searchKey1}"+'&searchOption2='+"${searchOption2}"+'&searchKey2='+"${searchKey2}"+'&selectedHead='+selectedHead+'&sortFlag='+sortFlag;
		});// end of $("tr.memberInfo").click(function(){})----------------------
		
		$("tr.memberInfo > td.memberRow").click(function(){
			var memberno = $(this).parent().children(".memberno").text();
			
			location.href = "<%= ctxPath%>/manager/member/memberOneDetail.sg?memberno="+memberno+"&goBackURL=${goBackURL}";
		});// end of $("tr.memberInfo").click(function(){})----------------------
		
		// @@ 전체선택/해제 @@ //
		$("#allCheck").click(function(){
			var bool = $("#allCheck").prop("checked");
			
			$(".memberCheck").each(function(){
				$(this).prop("checked", bool);
			});
		})// end of $("#allCheck").click(function(){})-----------------------
		
		// @@ 전체선택과 개별선택의 체크박스를 일치 @@ //
		$(".memberCheck").click(function(){
			var bFlag = false;
			
			$(".memberCheck").each(function(){
				if(!$(".memberCheck").prop("checked")) {
					bFlag = true;
					return;
				}
			});
			
			if(bFlag) {
				// 중국산 체크박스 6개 중 1개라도 체크가 해제된 경우라면
				$("#allCheck").prop("checked", false);
			} else {
				// 중국산 체크박스 6개 모두가 체크가 된 경우라면
				$("#allCheck").prop("checked", true);
			}
		});// end of $(".memberCheck").click(function(){})-------------------------
		
		$("#statusAllHandle").click(function(){
			location.href = "<%= ctxPath%>/manager/member/statusUpdate.sg?goBackURL=${goBackURL}";
		});
	});// end of $(document).ready(function(){})--------------------------
	
	function goSearch() {
		var frm = document.frmList;
		frm.action = "<%= ctxPath%>/manager/member/memberList.sg";
		frm.method = "get";
		frm.submit();
	}// end of function goSearch(){}------------------------
</script>

<form name="frmList">
	<div id="memberState">
		<div class="row">
			<div class="col-sm-12">
				<div class="well" style="background-color: white;">
					<h4>회원 현황</h4> 
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well divCell" style="background-color: white;">
					<select id="searchOption1" name="searchOption1">
						<option>옵션1</option>
						<option value="birthday">생년월일</option>
						<option value="agreeemail">이메일동의</option>
						<option value="agreesms">문자동의</option>
						<option value="fk_membershipname">회원등급</option>
						<option value="registerday">가입일자</option>
						<option value="idle">휴면</option>
						<option value="status">탈퇴</option>
					</select>
					
					<input type="text" id="searchKey1" name="searchKey1" placeholder="1차 검색 조건" />
					
					<select id="searchOption2" name="searchOption2">
						<option>옵션2</option>
						<option value="birthday">생년월일</option>
						<option value="agreeemail">이메일동의</option>
						<option value="agreesms">문자동의</option>
						<option value="fk_membershipname">회원등급</option>
						<option value="registerday">가입일자</option>
						<option value="idle">휴면</option>
						<option value="status">탈퇴</option>
					</select>
					
					<input type="text" id="searchKey2" name="searchKey2" placeholder="2차 검색 조건" />
					
					<button type="button" id="btnSearch" onclick="goSearch();">검색</button>
					
					<select id="sizePerPage" name="sizePerPage">
						<option value="5">5명씩 보기</option>
						<option value="10" selected="selected">10명씩 보기</option>
						<option value="20">20명씩 보기</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="well divContent" style="background-color: white;">
					<table id="tblMember">
						<thead>
							<tr id="tHeadRow" align="center">
								<th>회원번호<span class="hiddenVal">memberno</span><span class="hiddenSort">desc</span></th>
								<th>아이디<span class="hiddenVal">userid</span><span class="hiddenSort">desc</span></th>
								<th>생년월일<span class="hiddenVal">birthday</span><span class="hiddenSort">desc</span></th>
								<th>이메일동의<span class="hiddenVal">agreeemail</span><span class="hiddenSort">desc</span></th>
								<th>문자동의<span class="hiddenVal">agreesms</span><span class="hiddenSort">desc</span></th>
								<th>회원등급<span class="hiddenVal">fk_membershipname</span><span class="hiddenSort">desc</span></th>
								<th>가입일자<span class="hiddenVal">registerday</span><span class="hiddenSort">desc</span></th>
								<th>휴면<span class="hiddenVal">idle</span><span class="hiddenSort">desc</span></th>
								<th>탈퇴<span class="hiddenVal">status</span><span class="hiddenSort">desc</span></th>
								<td style="font-weight:bold; background-color: #bfbfbf;">선택<input type="checkbox" id="allCheck"/></td>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="mvo" items="${memberList}">
								<tr class="memberInfo">
									<td class="memberno memberRow">${mvo.memberno}</td>
									<td class="memberRow">${mvo.userid}</td>
									<td class="memberRow">${mvo.birthday}</td>
									<c:choose>
										<c:when test="${mvo.agreeemail eq '1'}">
											<td>O</td>
										</c:when>
										<c:otherwise>
											<td>X</td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${mvo.agreesms eq '1'}">
											<td>O</td>
										</c:when>
										<c:otherwise>
											<td>X</td>
										</c:otherwise>
									</c:choose>
									<td class="memberRow">${mvo.fk_membershipname}</td>
									<td class="memberRow">${mvo.registerday}</td>
									<c:choose>
										<c:when test="${mvo.idle eq 0}">
											<td>정상</td>
										</c:when>
										<c:otherwise>
											<td>휴면</td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${mvo.status eq 0}">
											<td>정상</td>
										</c:when>
										<c:when test="${mvo.status eq 1}">
											<td>예정</td>
										</c:when>
										<c:otherwise>
											<td>탈퇴</td>
										</c:otherwise>
									</c:choose>
									<td><input type="checkbox" class="memberCheck" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<div id="divBar" style="background-color: white; margin: 30px;">
						${pageBar}
						
						<div style="float: right;">
							<button type="button" id="idleAllHandle">휴면 처리</button>
							<button type="button" id="statusAllHandle">탈퇴 처리</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<jsp:include page="../managerFooter.jsp" />