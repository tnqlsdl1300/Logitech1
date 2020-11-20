<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../managerHeader.jsp" />

<style>
#couponRegisterState {
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
	$(document).ready(function(){
		$("input#discount").blur(function(){
			var discount = $(this).val().trim();
			
			if(discount == "") {
				
			} else {
				$("input#minprice").val(Number(discount) * 10);
			}// end of if(minprice == ""){}------------------------------
		});// end of $("input#minprice").blur(function()})-------------------------
	});// end of $(document).ready(function(){})-----------------------------
</script>

<div id="couponRegisterState">
	<div class="row">
		<div class="col-sm-12">
			<div class="well">
				<h4>쿠폰 등록</h4> 
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="well divContent">
				<form name="registerFrm">
					<table id="tblCouponRegister">
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
									쿠폰 코드&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="couponcode" id="couponcode" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									쿠폰명&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="couponname" id="couponname" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									할인액&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="discount" id="discount" class="requiredInfo" />&nbsp;&nbsp;
									<!-- 아이디중복체크 -->
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									최소사용금액&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="minprice" id="minprice" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									적용회원등급&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="fk_membershipname" id="fk_membershipname" class="requiredInfo" />
									<span class="error"></span>
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