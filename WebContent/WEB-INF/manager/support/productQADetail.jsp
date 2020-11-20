<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> --%>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
.divCell, .divContent {
	text-align: center;
}

div#productQAInfo {
	width: 60%; 
	text-align: left;
	border: solid 0px red;
	margin-top: 30px; 
	font-size: 13pt;
	line-height: 200%;
}

span.myli {
	display: inline-block;
	border: solid 0px blue;
}

/* ============================================= */
/* SMS 보내기 */

div#email, div#sms {
	margin: 0 auto; 
/*	border: solid 1px red; */
/*	overflow: hidden; */ 
	width: 90%;
	padding: 10px 0 10px 80px;
}

span#emailTitle, span#smsTitle {
	display: block;
	font-size: 13pt;
	font-weight: bold;
	margin-bottom: 10px;
}

textarea#emailContent, textarea#smsContent {
	height: 100px;
}

button#emailSend, button#smsSend {
	float: left;
	margin: 20px;
}

/* 버튼 디자인 */
@import url(https://fonts.googleapis.com/css?family=BenchNine:700);
.btnDesign {
  background-color: #c47135;
  border: none;
  color: #ffffff;
  cursor: pointer;
  display: inline-block;
  font-family: 'BenchNine', Arial, sans-serif;
  font-size: 1em;
  font-size: 18px;
  line-height: 1em;
  margin: 15px 40px;
  outline: none;
  padding: 12px 40px 10px;
  position: relative;
  text-transform: uppercase;
  font-weight: 700;
}

.btnDesign:before, .btnDesign:after {
  border-color: transparent;
  -webkit-transition: all 0.25s;
  transition: all 0.25s;
  border-style: solid;
  border-width: 0;
  content: "";
  height: 24px;
  position: absolute;
  width: 24px;
}

.btnDesign:before {
  border-color: #c47135;
  border-right-width: 2px;
  border-top-width: 2px;
  right: -5px;
  top: -5px;
}

.btnDesign:after {
  border-bottom-width: 2px;
  border-color: #c47135;
  border-left-width: 2px;
  bottom: -5px;
  left: -5px;
}

.btnDesign:hover {
  background-color: #c47135;
}

.btnDesign:hover:before,
.btnDesign.hover:before,
.btnDesign:hover:after,
.btnDesign.hover:after {
  height: 100%;
  width: 100%;
}
/*
div#smsResult {
	clear: both;
	color: red;
	padding: 20px;
}
*/
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$("input#answerType").val("");
		
		$('[data-toggle="popover"]').popover();
		
		// 답변 메일 발송하기
		$("button#emailSend").click(function(){
			// 메일 이벤트를 확인하기 위한 수단으로 value 값을 지정한다.
			$("input#answerType").val("email");
			
			var frm = document.queryAnswerFrm;
			frm.action = "<%= ctxPath%>/manager/support/oneQueryAnswerEmail.sg";
			frm.method = "post";
			frm.submit();
		});// end of $("button#emailSend").click(function(){})--------------------
		
		var method = "${method}";
		
		if(method == "POST" && "${answerType == 'email'}") {
			if(${sendMailSuccess == true}) {
				alert("메일 발송에 성공했습니다.");
			} else {
				alert("메일 발송에 실패했습니다.");
			}// end of if(${sendMailSuccess}){}----------------------
		}// end of if(method == "POST"){}---------------------
		
		$("button#smsSend").click(function(){
			$("input#answerType").val("sms");
			
			if($("#emailContent").val().length > 60) {
				alert("허용 길이를 초과하여 문자 전송이 불가합니다.");
				return;
			}
			
			$.ajax({
				url:"<%= ctxPath%>/manager/support/oneQueryAnswerSMS.sg",
				type:"POST",
				data:{"mobile":"${mbvo.mobile}",
					  "smsContent":$("textarea#emailContent").val()},
				dataType:"json",
				success:function(json){
					// json 은 {"group_id":"R2GNNcoUQhQBhgi8","success_count":1,"error_count":0} 의 형태처럼 보내어진다.
					if(json.success_count == 1) {
						alert("문자전송에 성공하였습니다.");
					} else if(json.error_count != 0 ) {
						alert("문자전송에 실패하였습니다.");
					}// end of if(json.success_count == 1){}----------------------
				},
				error:function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax({})----------------------
		});// end of $("button#smsSend").click(function(){})--------------------
		
		$("button#oqAnswerComplete").click(function(){
			alert("-");
			$.ajax({
				url:"<%= ctxPath%>/manager/support/productQAAnswer.sg",
				type:"POST",
				data:{"seq_qa":"${pqavo.seq_qa}",
					  "oq_content":$("#emailContent").val()},
				dataType:"json",
				success:function(json){
					// json 은 {"group_id":"R2GNNcoUQhQBhgi8","success_count":1,"error_count":0} 의 형태처럼 보내어진다.
					if(json.result == 1) {
						alert("답변 등록에 성공하였습니다.");
					} else if(json.result != 1 ) {
						alert("이미 답변 등록을 했거나, 답변 등록에 실패하였습니다.");
					}// end of if(json.success_count == 1){}----------------------
				},
				error:function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});// end of $.ajax({})----------------------
			
			location.href = "<%= ctxPath%>/manager/support/oneQueryAnswer.sg?seq_oq=${oqvo.seq_oq}&oq_content="+oq_content;
		})// end of $("button#oqAnswerComplete").click(function(){})-------------------------
	});// end of $(document).ready(function(){})-----------------------------
</script>
</head>
<body>

<form name="productQAFrm">
	<div id="productQAState">
		<div>
			<div class="row">
				<div class="col-sm-12">
					<div class="divContent">
						<c:if test="${empty pqavo}">
						존재하지 않는 문의입니다.<br>
					</c:if>
					
					<c:if test="${not empty pqavo}">
						<div id="productQAInfo">
							<ol>
								<li style="display: none;">${pqavo}</li>	
								<li><span class="myli">문의 번호:&nbsp;&nbsp;${pqavo.seq_qa}</span></li>
								<li><span class="myli">회원아이디:&nbsp;&nbsp;<a href='#' data-toggle='popover' title="이름 : ${mbvo.name}" data-content="이메일 수신 동의 : ${mbvo.agreeemail}<br>문자 수신 동의 : ${mbvo.agreesms}" data-html="true">${pqavo.mvo.userid}</a></span></li>
								<li><span class="myli">문의 제품:&nbsp;&nbsp;${pqavo.fk_productid}</span></li>
								<li><span class="myli">내용:&nbsp;&nbsp;${pqavo.content}</span></li>
							</ol>
							<input type="hidden" id="hiddenSeq_qa" name="seq_qa" value="${pqavo.seq_qa}" />
							<input type="hidden" id="hiddenName" name="name" value="${mbvo.name}" />
							<input type="hidden" id="hiddenEmail" name="email" value="${mbvo.email}" />
							<input type="hidden" id="hiddenMobile" name="mobile" value="${mbvo.mobile}" />
							<input type="hidden" id="answerType" name="answerType" value="" />
						</div>
						
						<hr style="background-color: #ccc; margin: 30px 0;">
						
						<%-- @@@ 답변 보내기 @@@ --%>
						<div id="email" align="left">
							<span id="emailTitle">&gt;&gt;답변 내용 입력란&lt;&lt;</span><br>
							<textarea rows="10" cols="50" id="emailContent" name="emailContent"></textarea><br>
							<button class="btnDesign" id="emailSend">메일 전송</button>
							<button class="btnDesign" id="smsSend">문자 전송</button>
						</div>
						
						<%-- @@@ 답변 완료 @@@ --%>
						<div id="sms">
							<button class="btnDesign" id="oqAnswerComplete" style="width: 100%; margin: 0 auto;">답변 완료</button>
						</div>
					</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

</body>
</html>