<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
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
		$("span.error").hide();
		
		$("input#managerid").focus();
		
		// 아이디가 name인 것은 포커스를 잃어버렸을 경우 blur 이벤트를 처리해준다.
		$("input#managerid").blur(function(){
			
			var managerid = $(this).val();
			
			var regExp = new RegExp(/^[A-Za-z0-9]{5,12}$/g);
			// 영문자, 숫자 형태의 5~12 자리의 아이디 정규표현식 객체 생성
			var bool = regExp.test(managerid);
			
			if(!bool) {
				// 입력하지 않거나 공백만 입력한 경우
				$(this).parent().find(".error").show();
				$(this).focus();
			} else {
				// 공백이 아닌 글자를 제대로 입력한 경우
				$(this).next().hide();
			}// end of if(managerid == ""){}-----------------
			
		});// end of $("input#name").blur(function(){})-------------------
		
		// 아이디가 managerpwd인 것은 포커스를 잃어버렸을 경우 blur 이벤트를 처리해준다.
		$("input#managerpwd").blur(function(){
			
			var pwd = $(this).val();
			
			// var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			// 또는
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			var bool = regExp.test(pwd);
			
			if(!bool) {
				// 암호가 정규표현식에 위배된 경우
				$(this).parent().find(".error").show();
				$(this).focus();
			} else {
				// 암호가 정규표현식에 맞는 경우
				$(this).parent().find(".error").hide();
			}// end of if(!bool){}-----------------
			
		});// end of $("input#pwd").blur(function(){})-------------------
		
		
		// 아이디가 pwdcheck인 것은 포커스를 잃어버렸을 경우 blur 이벤트를 처리해준다.
		$("input#pwdcheck").blur(function(){
			
			var managerpwd = $("input#managerpwd").val();
			var pwdcheck = $(this).val();
			
			if(managerpwd != pwdcheck) {
				// 암호와 암호확인 값이 다른 경우
				$(this).parent().find(".error").show();
				$(this).focus();
			} else {
				// 암호와 암호확인 값이 같은 경우
				$(this).parent().find(".error").hide();
			}// end of if(managerpwd != pwdcheck){}-----------------
			
		});// end of $("input#pwdcheck").blur(function(){})-------------------
		
		
		// 아이디가 manageremail인 것은 포커스를 잃어버렸을 경우 blur 이벤트를 처리해준다.
		$("input#manageremail").blur(function(){
			
			var manageremail = $(this).val();
			
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			var bool = regExp.test(manageremail);
			
			if(!bool) {
				// 이메일 형식에 맞지 않는 경우
				$(this).parent().find(".error").show();
				$(this).focus();
			} else {
				// 이메일 형식에 맞는 경우
				$(this).parent().find(".error").hide();
			}// end of if(!bool){}-----------------
			
		});// end of $("input#manageremail").blur(function(){})-------------------
		
		
		// 아이디가 managermobile인 것은 포커스를 잃어버렸을 경우 blur 이벤트를 처리해준다.
		$("input#managermobile").blur(function(){
			
			var managermobile = $(this).val();
			
			var regExp = /^\d{8,15}$/g;
			var bool = regExp.test(managermobile);
			
			if(!bool) {
				// 가운데 번호(국번) 형식에 맞지 않는 경우
				$(this).parent().find(".error").show();
				$(this).focus();
			} else {
				// 가운데 번호 형식에 맞는 경우
				$(this).parent().find(".error").hide();
			}// end of if(!bool){}-----------------
			
		});// end of $("input#managermobile").blur(function(){})-------------------
		
     	// 아이디 중복 검사하기 //
		$("img#idcheck").click(function(){
			flagIdDuplicateClick = true;  // 가입하기 버튼 클릭 시 "아이디중복확인"을 클릭했는지 여부를 알아보기 위한 용도의 boolean형 변수
			
			// 입력하고자 하는 아이디가 데이터베이스 테이블에 존재하는지 확인해야 한다.
			/*
				Ajax (Asynchronous JavaScript and XML)란?
				==> 이름만 보면 알 수 있듯이 '비동기 방식의 자바스크립트와 XML' 로서
				Asynchronous JavaScript + XML 인 것이다.
				한마디로 말하면, Ajax 란? Client 와 Server 간에 XML 데이터를 JavaScript 를 사용하여 비동기 통신으로 주고 받는 기술이다.
				하지만 요즘에는 데이터 전송을 위한 데이터 포맷방법으로 XML 을 사용하기 보다는 JSON 을 더 많이 사용한다.
				참고로 HTML은 데이터 표현을 위한 포맷방법이다.
				그리고, 비동기식이란 어떤 하나의 웹페이지에서 여러가지 서로 다른 다양한 일처리가 개별적으로 발생한다는 뜻으로서, 
				어떤 하나의 웹페이지에서 서버와 통신하는 그 일처리가 발생하는 동안 일처리가 마무리 되기전에 또 다른 작업을 할 수 있다는 의미이다.
			*/
			// 첫 번째 방법 //
		<%--
			$.ajax({
				url:"<%= ctxPath%>/member/idDuplicateCheck.up",
				data:{"userid":$("input#userid").val()},  // data 는 /MyMVC/member/idDuplicateCheck.up로 전송해야할 데이터를 말한다.
				type:"post",
				dataType:"json",  // JavaScript Standard Object Notation. dataType 은  /MyMVC/member/idDuplicateCheck.up로부터 실행된 결과물을 받아오는 데이터타입을 말한다.
				success:function(data){  // data 는 받아온 결과물이 객체인 json 타입으로 저장되는 변수이다. (String 타입 X)
					if(data.isExists) {  // data.isExists --> 변수.key값
						// 입력한 userid 가 이미 사용 중인 경우
					//	alert($("input#userid").val() + " 은(는) 이미 사용 중인 아이디이므로 사용할 수 없습니다.");
						$("span#idcheckResult").html($("input#userid").val() + " 은(는) 중복된 ID로 사용할 수 없습니다").css("color","red");
						$("input#userid").val("");
					} else {
						// 입력한 userid 가 tbl_member 테이블에 존재하지 않는 경우
					//	alert($("input#userid").val() + " 은(는) 사용가능합니다.");
						$("span#idcheckResult").html($("input#userid").val() + " 은(는) 사용가능합니다").css("color","navy");
					}// end of if(data.isExists){}-------------------
				},
				error:function(request, status, error){  // error 는 결과를 받아올 수 없는 코드 상의 오류이다.
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});// end of $.ajax({})----------------------
		--%>	
			// 두 번째 방법 //
			$.ajax({
				url:"<%= ctxPath%>/member/idDuplicateCheck.up",
				data:{"userid":$("input#userid").val()},  // data 는 /MyMVC/member/idDuplicateCheck.up로 전송해야할 데이터를 말한다.
				type:"post",
			//	dataType:"json",  // JavaScript Standard Object Notation. dataType 은  /MyMVC/member/idDuplicateCheck.up로부터 실행된 결과물을 받아오는 데이터타입을 말한다.
				success:function(text){  // text 는 dataType:"json"을 생략하면 자바스크립트 객체(JSON)로 인식하지 않고 받아온 결과물 그대로 String 타입의 {"isExists":true} 또는 {"isExists":false} 로 인식한다.
					var json = JSON.parse(text);
					// JSON.parse(text); 은 JSON 형식으로 되어진 문자열을 자바스크립트 객체로 변환해주는 것이다.
		            // 조심할 것은 text 는 반드시 JSON 형식으로 되어진 문자열이어야 한다.
		            
					if(json.isExists) {  // json.isExists --> 변수.key값
						// 입력한 userid 가 이미 사용 중인 경우
					//	alert($("input#userid").val() + " 은(는) 이미 사용 중인 아이디이므로 사용할 수 없습니다.");
						$("span#idcheckResult").html($("input#userid").val() + " 은(는) 중복된 ID로 사용할 수 없습니다").css("color","orange");
						$("input#userid").val("");
					} else {
						// 입력한 userid 가 tbl_member 테이블에 존재하지 않는 경우
					//	alert($("input#userid").val() + " 은(는) 사용가능합니다.");
						$("span#idcheckResult").html($("input#userid").val() + " 은(는) 사용가능합니다").css("color","green");
					}// end of if(json.isExists){}-------------------
				},
				error:function(request, status, error){  // error 는 결과를 받아올 수 없는 코드 상의 오류이다.
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});// end of $.ajax({})----------------------
		});// end of $("img#idcheck").click(function(){})---------------------
	});// end of $(document).ready(function(){})-----------------------------
	
	function goRegister() {
		/*
		// 아이디 중복 검사 확인하기 //
		if(!flagIdDuplicateClick) {
			alert("아이디중복확인을 클릭하여 ID중복검사를 하세요!!");
			return;
		}
		*/
		
		// 필수입력사항 모두가 입력되었는지 검사하기 //
		var bFlagRequiredInfo = false;
		
		$(".requiredInfo").each(function(){
			var data = $(this).val();
			if(data == "") {
				bFlagRequiredInfo = true;
				alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
				return false;  // break
			}// end of if(data == ""){}----------------
		});// end of $(".requiredInfo").each(function(){})--------------------
		
		if(!bFlagRequiredInfo) {
			var frm = document.registerFrm;
			frm.action = "<%= ctxPath%>/manager/manager/managerRegister.sg";
			frm.method = "POST";
			frm.submit();
		}// end of if(!bFlagRequiredInfo){}------------------
	}// end of function goRegister(){}----------------------------
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
				<form name="registerFrm">
					<table id="tblManagerRegister">
						<thead>
							<tr>
								<th colspan="2" id="th">
									::: 관리자등록 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									관리자 아이디&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="managerid" id="managerid" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									관리자 비밀번호&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="password" name="managerpwd" id="managerpwd" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									비밀번호 확인&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="password" name="pwdcheck" id="pwdcheck" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									관리 범위&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<select name="managertype" id="managertype" class="requiredInfo">
										<option>전체</option>
										<option>회원</option>
										<option>제품</option>
										<option>주문</option>
										<option>판촉</option>
									</select>
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									담당 이메일&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="manageremail" id="manageremail" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									담당 전화번호&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="managermobile" id="managermobile" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="line-height: 90px;">
									<button type="button" id="btnRegister" onClick="goRegister();"></button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../managerFooter.jsp" />