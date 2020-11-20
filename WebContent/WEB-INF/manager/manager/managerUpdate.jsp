<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../managerHeader.jsp" />

<style>
#managerRState {
	float: left;
	width: 75%;
	margin: 20px;
}

.divCell, .divContent {
	text-align: center;
}

span.myli {
	display: inline-block;
	width: 90px;
	border: solid 0px blue;
}

/* ============================================= */
/* SMS 보내기 */
div#sms {
	margin: 0 auto; 
	/* border: solid 1px red; */ 
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
</style>

<script type="text/javascript">
//	var flagIdDuplicateClick = false;

	$(document).ready(function(){
		var flagCheckIdExistClick = false; 
		
		$(".error").hide();
		
		if("${sessionScope.loginManager.managertype}" != "전체") {
			$("select#managertype").prop("disabled", true);
		} else {
			$("select#managertype").prop("disabled", false);
		}// end of if("${sessionScope.loginManager.managertype}" != "전체"){}-----------------------
	      
		$("#managerpwd").blur(function() {
		   var managerpwd = $(this).val();
		   
		   var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
		   // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
		   
		   var bool = regExp_PW.test(managerpwd);
		   
		   if(!bool) { // 암호가 정규표현식에 위배된 경우 
		      $(this).parent().find(".error").show();
		      $(this).focus();
		   }
		   else { // 암호가 정규표현식에 맞는 경우 
		      $(this).parent().find(".error").hide();
		   } 
		});// end of $("#managerpwd").blur()-------------------
		
		$("#pwdcheck").blur(function(){
		   var managerpwd = $("#managerpwd").val();
		   var pwdCheck = $(this).val();
		   
		   if(managerpwd != pwdCheck) { // 암호와 암호확인값이 틀린 경우 
		      $(this).parent().find(".error").show();
		      $(this).focus();
		   }
		   else { // 암호와 암호확인값이 같은 경우 
		      $(this).parent().find(".error").hide();
		   }
		   
		});// end of $("#pwdcheck").blur()--------------   
		
		$("#managertype").change(function(){
			
		});// end of $("#managertype").changer(function(){})-------------------------
		
		
		$("#email").blur(function(){
		   
		   var email = $(this).val();
		   
		   var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
		   
		   var bool = regExp_EMAIL.test(email);
		   
		   if(!bool) { // 이메일이 정규표현식에 위배된 경우
		      $(this).parent().find(".error").show();
		      $(":input").prop("disabled",true).addClass("bgcol");
		      $(this).prop("disabled",false).removeClass("bgcol"); 
		      $(this).focus();
		   }
		   else { // 이메일이 정규표현식에 맞는 경우
		      $(this).parent().find(".error").hide();
		      $(":input").prop("disabled",false).removeClass("bgcol");
		   }
		   
		});// end of $("#email").blur()--------------
		
		
		$("#hp2").blur(function(){
		   var hp2 = $(this).val();
		   
		   var regExp_HP2 = /^[1-9][0-9]{2,3}$/g;
		   // 숫자 3자리 또는 4자리만 들어오도록 검사해주는 정규표현식
		   
		   var bool = regExp_HP2.test(hp2);
		   
		   if(!bool) {
		      $(this).parent().find(".error").show();
		      $(":input").prop("disabled", true).addClass("bgcol");
		      $(this).prop("disabled", false).removeClass("bgcol");
		   }
		   else {
		      $(this).parent().find(".error").hide();
		      $(":input").prop("disabled", false).removeClass("bgcol");
		   }   
		});// end of $("#hp2").blur()-------------
		
		
		$("#hp3").blur(function(){
		   var hp3 = $(this).val();
		   
		   var regExp_HP3 = /^\d{4}$/g;
		   // 숫자 4자리만 들어오도록 검사해주는 정규표현식
		   
		   var bool = regExp_HP3.test(hp3);
		   
		   if(!bool) {
		      $(this).parent().find(".error").show();
		      $(":input").prop("disabled", true).addClass("bgcol");
		      $(this).prop("disabled", false).removeClass("bgcol");
		   }
		   else {
		      $(this).parent().find(".error").hide();
		      $(":input").prop("disabled", false).removeClass("bgcol");
		   }   
		});// end of $("#hp3").blur()-------------
		
		
		$("#zipcodeSearch").click(function(){
		   new daum.Postcode({
		         oncomplete: function(data) {
		             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		             // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		             var addr = ''; // 주소 변수
		             var extraAddr = ''; // 참고항목 변수
		
		             //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		             if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                 addr = data.roadAddress;
		             } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                 addr = data.jibunAddress;
		             }
		
		             // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		             if(data.userSelectedType === 'R'){
		                 // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                 // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                 if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                     extraAddr += data.bname;
		                 }
		                 // 건물명이 있고, 공동주택일 경우 추가한다.
		                 if(data.buildingName !== '' && data.apartment === 'Y'){
		                     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                 }
		                 // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                 if(extraAddr !== ''){
		                     extraAddr = ' (' + extraAddr + ')';
		                 }
		                 // 조합된 참고항목을 해당 필드에 넣는다.
		                 document.getElementById("extraAddress").value = extraAddr;
		             
		             } else {
		                 document.getElementById("extraAddress").value = '';
		             }
		
		             // 우편번호와 주소 정보를 해당 필드에 넣는다.
		             document.getElementById('postcode').value = data.zonecode;
		             document.getElementById("address").value = addr;
		             // 커서를 상세주소 필드로 이동한다.
		             document.getElementById("detailAddress").focus();
		         }
		     }).open();            
		});
		
		// 하나로 통일된 휴대폰 번호를 세 부분으로 나누어 텍스트 창에 넣어준다.
		var mobile = "${sessionScope.loginUser.mobile}";
		
		$("input#hp2").val(mobile.substring(3,7));
		$("input#hp3").val(mobile.substring(7));
	});// end of $(document).ready(function(){})-----------------------------
	
	function checkIdExist() {
		flagCheckIdExistClick = false;
		
		var updateid = $("#updateid").val();
		
		var frm = document.updateFrm;
		frm.action = "<%= ctxPath%>/manager/manager/managerUpdate.sg?&updateid="+updateid;
		frm.submit();
	}
	
	function goUpdate() {
		
	}// end of function goUpdate(){}----------------------------
</script>

<div id="managerRState">
	<div class="row">
		<div class="col-sm-12">
			<div class="well">
				<h4>관리자 등록</h4> 
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="well divContent">
				<form name="updateFrm">
					<table id="tblMemberUpdate">
						<c:choose>
							<c:when test="${sessionScope.loginManager.managerid == 'admin'}">
								<tr>
									<td style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
									<td style="width: 80%; text-align: left;">
										<input type="hidden" name="managerid" id="managerid" value="${sessionScope.loginManager.managerid}" class="requiredInfo" required />
										<input type="text" name="updateid" id="updateid" class="requiredInfo" required />
										<button type="button" onclick="checkIdExist();">계정 확인</button>
									</td>
								</tr>
							</c:when>
							
							<c:otherwise>
								<tr>
									<td style="width: 20%; font-weight: bold;">아이디&nbsp;<span class="star">*</span></td>
									<td style="width: 80%; text-align: left;">
										<input type="text" name="managerid" id="managerid" value="${sessionScope.loginManager.managerid}" class="requiredInfo" required disabled="disabled" />
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
						<tr>
							<td style="width: 20%; font-weight: bold;">비밀번호&nbsp;<span class="star">*</span></td>
							<td style="width: 80%; text-align: left;">
								<input type="password" name="managerpwd" id="managerpwd" class="requiredInfo" required />
								<span class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</span>
							</td>
						</tr>
						<tr>
							<td style="width: 20%; font-weight: bold;">비밀번호확인&nbsp;<span class="star">*</span></td>
							<td style="width: 80%; text-align: left;">
								<input type="password" id="pwdcheck" class="requiredInfo" required /> 
								<span class="error">암호가 일치하지 않습니다.</span>
							</td>
						</tr>
						<tr>
							<td style="width: 20%; font-weight: bold;">관리 범위</td>
							<td style="width: 80%; text-align: left;">
								<select name="managertype" id="managertype" class="requiredInfo">
									<option <c:if test="${sessionScope.loginManager.managertype == '전체'}">selected</c:if>>전체</option>
									<option <c:if test="${sessionScope.loginManager.managertype == '회원'}">selected</c:if>>회원</option>
									<option <c:if test="${sessionScope.loginManager.managertype == '제품'}">selected</c:if>>제품</option>
									<option <c:if test="${sessionScope.loginManager.managertype == '주문'}">selected</c:if>>주문</option>
									<option <c:if test="${sessionScope.loginManager.managertype == '판촉'}">selected</c:if>>판촉</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="width: 20%; font-weight: bold;">담당 이메일&nbsp;<span class="star">*</span></td>
							<td style="width: 80%; text-align: left;">
								<input type="text" name="email" id="email" value="${sessionScope.loginManager.manageremail}" class="requiredInfo" placeholder="admin@squadg.com" /> 
								<span class="error">이메일 형식에 맞지 않습니다.</span>
							</td>
						</tr>
						<tr>
							<td style="width: 20%; font-weight: bold;">담당 전화번호</td>
							<td style="width: 80%; text-align: left;">
								<input type="text" id="managermobile" name="managermobile" value="${sessionScope.loginManager.managermobile}" size="15" maxlength="15" />&nbsp;&nbsp;
								<span class="error">전화번호 형식이 아닙니다.</span>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" id="btnUpdate" style="margin-left: 40%; margin-top: 2%; width: 80px; height: 40px;" onClick="goUpdate();"><span style="font-size: 15pt;">확인</span></button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../managerFooter.jsp" />