<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../managerHeader.jsp" />

<style>
#prodRegisterState {
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
	var goBackURL = "";

	$(document).ready(function(){
		goBackURL = "${goBackURL}";
		
		goBackURL = goBackURL.replace(/   /gi, "&");
	});// end of $(document).ready(function(){})-----------------------------
	
	function goProdOptionList() {
		location.href = "/Logitech/"+goBackURL;
	}// end of function goProdOptionList(){}-----------------------------
</script>

<div id="prodRegisterState">
	<div class="row">
		<div class="col-sm-12">
			<div class="well">
				<h4>제품 등록</h4> 
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="well divContent">
				<form name="registerFrm">
					<table id="tblMemberRegister">
						<thead>
							<tr>
								<th colspan="2" id="th">
									::: 쿠폰등록 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									제품 아이디&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="name" id="name" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									제품 일련번호&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="name" id="name" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									제품명&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="userid" id="userid" class="requiredInfo" />&nbsp;&nbsp;
									<!-- 아이디중복체크 -->
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									색상&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="name" id="name" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									카테고리&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<select>
										<option>마우스</option>
										<option>키보드</option>
										<option>헤드셋</option>
										<option>스피커</option>
									</select>
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									특징&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="checkbox" /><label>유선 마우스</label>
									<input type="checkbox" /><label>무선 마우스</label>
									<input type="checkbox" /><label>유선 마우스</label>
									<input type="checkbox" /><label>게이밍 마우스</label>
									<input type="checkbox" /><label>인체공학 마우스</label>
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									특징&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="checkbox" /><label>유선 마우스</label>
									<input type="checkbox" /><label>무선 마우스</label>
									<input type="checkbox" /><label>유선 마우스</label>
									<input type="checkbox" /><label>게이밍 마우스</label>
									<input type="checkbox" /><label>인체공학 마우스</label>
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									특징&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="checkbox" /><label>유선 마우스</label>
									<input type="checkbox" /><label>무선 마우스</label>
									<input type="checkbox" /><label>유선 마우스</label>
									<input type="checkbox" /><label>게이밍 마우스</label>
									<input type="checkbox" /><label>인체공학 마우스</label>
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									특징&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="checkbox" /><label>유선 마우스</label>
									<input type="checkbox" /><label>무선 마우스</label>
									<input type="checkbox" /><label>유선 마우스</label>
									<input type="checkbox" /><label>게이밍 마우스</label>
									<input type="checkbox" /><label>인체공학 마우스</label>
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									가격&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="name" id="name" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									썸네일 이미지 경로&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="name" id="name" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									제품 설명 이미지 경로&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="name" id="name" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									상세제품 이미지 경로&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="name" id="name" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									재고량&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<span>123개</span>
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td colspan="2" id="td">
									<button type="button">제품등록</button>
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