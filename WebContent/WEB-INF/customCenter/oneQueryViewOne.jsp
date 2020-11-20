<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp" />

<style>
table#tblMemberRegister {
	width: 93%;
	border: solid;
	border-collapse: collapse;
	margin: 10px;
}

table#tblMemberRegister #th {
	height: 40px;
	text-align: center;
	background-color: silver;
	font-size: 14pt;
	border: 1px solid;
}

table#tblMemberRegister td {
	/* border: solid 1px gray;  */
	line-height: 30px;
	padding-top: 8px;
	padding-bottom: 8px;
	border: 1px solid;
	text-align: center;
}

table#tblMemberRegister {
	width: 93%;
	/* 선을 숨기는 것 */
	border-collapse: collapse;
}

table#tblMemberRegister #th {
	height: 40px;
	text-align: center;
	font-size: 14pt;
	border: 1px solid;
	background-color: gray;
}

table#tblMemberRegister td {
	border: solid 1px gray;
	line-height: 30px;
	padding-top: 8px;
	padding-bottom: 8px;
	text-align: center;
}

textarea {
	width: 96%;
	height: 97%;
	resize: none;
	
	margin-left: 2%;
	margin-right: 2%;
}

div#mid-header {
	text-align: left;
	margin-left: 5%;
}


</style>

<script type="text/javascript">
	
	
	$(document).ready(function () {
		
		var seq_oq="${seq_oq}";
		console.log(seq_oq);
		
		// 값 넣어주기
		$("select#h1").val('${h1}');
		$("#hp2").val("${h2}");
		$("#hp3").val("${h3}");
		$("input#eamil_id").val('${email_id}');
		$("select#email_domain").val('${email_domain}');
		
		$("input#category").val('${oqvo.category}');
		$("input#title").val('${oqvo.title}');
		$("textarea#content").val('${oqvo.content}');
		$("input#seq_oq").val('${seq_oq}');
		
		
		
		// 체크박스 
		if('${oqvo.answerform}' == "1") {
			
			$("input#check1").prop("checked", true);
			$("input#check2").prop("checked", false);
			
		} else {
			$("input#check1").prop("checked", false);
			$("input#check2").prop("checked", true);
		}
		
		// 태그 비활성화
		disable();
		
		// 중복체크 해제 이벤트
		$("input#check1").click(function () {
			
			$("input:checkbox[id='check2']").prop("checked", false);
			
		});
		
		$("input#check2").click(function () {
			
			$("input:checkbox[id='check1']").prop("checked", false);
			
		});
		
		
		
		
	}); // end of $(document).ready(function () {}
	
	// 태그 비활성화 함수
	function disable() {
		
		$("input").attr('disabled', true);
		$("select").attr('disabled', true);
		$("textarea").attr('disabled', true);
	}
	
	
	// 태그를 활성화 시켜주는 함수
	function able() {
		
		var seq_oq="${seq_oq}";
		
		$("input").attr('disabled', false);
		$("select").attr('disabled', false);
		$("textarea").attr('disabled', false);
		
		$("textarea#admin_content").attr('disabled', true);
		// 함수를 실행시키면 url이 ?seq_oq이 초기화 됨.
		// 따라서 별도의 이벤트가 필요함.
		// 이벤트를 불러일으키면 그게 바뀌고 페이지가 다시 로딩되는데 url이 초기화됨.
		
		
	}
	
	
	// 수정하기
	function modify() {
		var isclicked = true;
		able();
		
	}
	
	// 변경완료
	function commit() {
		alert("클릭하셨습니다.");
		
		var frm = document.oqviewFrm;
		frm.action = "/Logitech/oqModify.sg";
		frm.method = "post";
		frm.submit();
	}
	
	// 삭제하기
	function del() {
		
		
		var result = confirm('정말로 삭제하시겠습니까?'); 
		if(result) {
			//yes
			location.href="/Logitech/oqDelete.sg?seq_oq="+'${seq_oq}';
		} else { 
			// no 
		}

			
		
		// 따음표가 있을때는 '' 구분지어주어야함
		
		
	}
	
	// 목록보기
	function golist() {
		location.href="/Logitech/goOqList.sg";
	}
	
</script>

<%
	String ctxPath = request.getContextPath();
%>




<div id="wrap">
	
	 

<div class="row" id="divRegisterFrm">


	<div class="col-md-12" align="center">
		<div id="mid-header">
			<h2>내 문의 내역 상세보기</h2>

			<p>고객님께서 문의하신 1:1문의 상세 내역 및 답변 내역입니다.</p>
			
		</div>
		
		<form name="oqviewFrm">
			<hr>
			<br>
			<br>
			<table id="tblMemberRegister">
				<thead>
					<tr>
						<th colspan="2" id="th">::: 1:1 문의내용 <span
							style="font-size: 10pt; font-style: italic;"></span> :::
						</th>
					</tr>
			
				</thead>
				<tbody>
				
				<%-- 휴대폰번호와 이메일 의미 없을듯.
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
							class="disabled" id="eamil_id" style="margin-left: 2%;
							6" maxlength="4" disabled /> @&nbsp;<select id="email_domain"
							name="email" style="width: 130px; padding: 8px;" disabled>
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="hanmail.net">hanmail.net</option>
						</select></td>
					</tr>
					
				 --%> 
					

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
						<td style="width: 80%; text-align: left;"><input type="text" id="title"
							name="title" style="width: 90%; margin-left: 2%;" /></td>
					</tr>

					<tr>
						<td style="width: 20%; font-weight: bold;">내용</td>
						<td style="width: 80%; text-align: left;"><textarea
								id="content" name="content" cols="30" rows="10"></textarea></td>
					</tr>

					<tr>
						<td style="width: 20%; font-weight: bold;">답변 희망 형태</td>
						<td style="width: 80%; text-align: left;"><input id="check1"
							name="anform" type="checkbox" style="margin-left: 2%;" value="1">
							<label for="check1">이메일</label> <input id="check2" name="anform"
							type="checkbox" value="0"> <label for="check2">받지않음(마이페이지에서
								확인)</label></td>
					</tr>

					<tr>
						<td style="width: 20%; font-weight: bold;">등록일자</td>
						<td style="width: 80%; margin-left: 2%;">${oqvo.writeday} <!--  등록일 -->
						</td>
						<td style="display: none;"><input id="seq_oq" name="seq_oq"> </td>
						
					</tr>

				</tbody>
			</table>
			</form>
			
			<table id="tblMemberRegister">
				<thead>
					<tr>
						<th colspan="2" id="th">::: 답변내용 <span
							style="font-size: 10pt; font-style: italic;"></span> :::
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%; font-weight: bold;">내용</td>
						<td style="width: 80%; text-align: left;">
						<textarea id="admin_content" name="content" cols="30" rows="10"></textarea>
						</td>

					</tr>



				</tbody>

			</table>
			
		
		
			


			<button class="" onclick="modify();">수정하기</button>
			<button class="" onclick="commit();">변경완료</button>
			<button class="" onclick="del();">삭제</button>
			<button class="" onclick="golist();">목록</button>
	</div>



</div>
</div>
<jsp:include page="../footer.jsp" />




















