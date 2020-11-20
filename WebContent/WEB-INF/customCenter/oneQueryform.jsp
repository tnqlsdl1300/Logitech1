<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../header.jsp" />

<style>

div.col-md-12 {

	margin-top: 50px;
	border: 1px solid black;
	background-color: white;
}
table#tblOneQueryRegister {

	width: 100%;
	border-collapse: collapse;
	



}

table#tblOneQueryRegister #th {
	height: 40px;
	text-align: left;
	font-size: 14pt;
	border-top: none;
	border-bottom: solid 1px black;
	margin-left: 20px;
	
}


table#tblOneQueryRegister td {
	border: none;
	line-height: 30px;
	padding-top: 8px;
	padding-bottom: 8px;
	text-align: center;
	border-bottom: solid 1px black;
	margin-left: 5px;
	background-color: gary;
}

textarea {
	width: 96%;
	height: 97%;
	resize: none;
	margin-left: 2%;
	margin-right: 2%;
}


button.btn {
	
	margin-right: 30px;
	margin: 5px 30px; 
	
}


</style>



<%
	String ctxPath = request.getContextPath();
%>

<script>
		
	$(document).ready(function() { 
		
		
		
		// customCenter function
		$("button#submitbtn").click(function () {

		alert("버튼 submit");
		var frm=document.oneQueryFrm;
		frm.action = "<%= ctxPath%>/oneQueryExcute.sg";
		frm.method="POST";
		frm.submit();
		}); 
		
		
		$("button#goback").click(function () {
			
			alert("뒤로가기를 클릭하셨습니다.");
			history.back();
		});
		
		
		// request에 넘겨준 값 넣기.
		$("input#customName").val('${name}');
		$("select#h1").val('${h1}');
		$("#hp2").val("${h2}");
		$("#hp3").val("${h3}");
		$("input#eamil_id").val('${email_id}');
		$("select#email_domain").val('${email_domain}');
		
		
		
		// 중복체크 해제 이벤트
		$("input#check1").click(function () {
			
			
			$("input:checkbox[id='check2']").prop("checked", false);
			
		});
		
		$("input#check2").click(function () {
			
			$("input:checkbox[id='check1']").prop("checked", false);
			
		});
		
		
		
		
		
		
		
		
		
		
		
		
		
	});
	

	
	
	</script>

<div id="wrap">

<div>
	<div class="col-md-12" align="center">
		<form name="oneQueryFrm">

			<table id="tblOneQueryRegister">
				<thead>
					<th colspan="2" id="th" style="font-size: 30pt;">1:1 문의</th>


					</thead>
				<tbody>
					<tr>
						<td style="width: 20%; font-weight: bold;">고객명&nbsp;</td>
						<td style="width: 80%; text-align: left;"><input type="text"
							class="disabled" id="customName" style="margin-left: 2%;"
							disabled /></td>
					</tr>


					<tr>
						<td style="width: 20%; font-weight: bold;">휴대폰 번호</td>

						<td style="width: 80%; text-align: left;"><select id="h1"
							class="disabled"
							style="margin-left: 2%; width: 100px; padding: 8px;" disabled>

								<option value="010">010</option>
								<option value="011">011</option>
								<option value="019">019</option>
						</select>&nbsp;-&nbsp; <input type="text" class="disabled" id="hp2"
							name="hp2" size="6" maxlength="4" disabled />&nbsp;-&nbsp; <input
							type="text" class="disabled" id="hp3" name="hp3" size="6"
							maxlength="4" disabled /></td>
					</tr>

					<tr>
						<td style="width: 20%; font-weight: bold;">이메일</td>
						<td style="width: 80%; text-align: left;"><input type="text"
							class="disabled" id="eamil_id" style="margin-left: 2%;"
							6" maxlength="4" disabled /> @&nbsp;<select id="email_domain"
							name="email" style="width: 130px; padding: 8px;" disabled>
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="hanmail.net">hanmail.net</option>
						</select></td>
					</tr>


					<tr>
						<td style="width: 20%; font-weight: bold;">문의유형</td>
						<td style="width: 80%; text-align: left;"><select
							id="category" name="category"
							style="margin-left: 2%; width: 100px; padding: 8px;">

								<option value="고객등급">고객등급</option>
								<option value="배송">배송</option>
								<option value="환불/교환">환불/교환</option>
								<option value="회원탈퇴">회원탈퇴</option>
						</select></td>
					</tr>

					<tr>
						<td style="width: 20%; font-weight: bold;">제목</td>
						<td style="width: 80%; text-align: left;"><input type="text"
							name="title" style="width: 98%; margin-left: 2%;" /></td>
					</tr>

					<tr>
						<td style="width: 20%; font-weight: bold;">내용</td>
						<td style="width: 80%; text-align: left;"><textarea
								name="content" cols="30" rows="10" style="width: 98%; margin-top: 8px"></textarea></td>
					</tr>

					<tr>
						<td style="width: 20%; font-weight: bold;">답변 희망 형태</td>
						<td style="width: 80%; text-align: left;"><input id="check1"
							name="anform" type="checkbox" style="margin-left: 2%;" value="1">
							<label for="check1">이메일</label> <input id="check2" name="anform"
							type="checkbox" value="0"> <label for="check2">받지않음(마이페이지에서
								확인)</label></td>
					</tr>

				</tbody>

			</table>

		</form>
		<button class="btn btn-primary" id="submitbtn">문의하기</button>
		<button class="btn btn-primary" id="goback">취소하기</button>
	</div>

</div>

</div>

<jsp:include page="../footer.jsp" />




















