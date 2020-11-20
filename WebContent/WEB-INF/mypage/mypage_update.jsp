<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />
<style>
	ul#upul > li{
		display: block;
	}
	
	.updatelab {
		background-color: #f4f4f0;
		margin-right: 20px;
	}
	h6 {
		font-size: 12pt;
		text-align: center;
		margin-bottom: 50px;
	}
	th {
		padding-bottom: 20px;
	}
	td {
		padding: 10px;
		padding-right: 80px;
	}
	.second {
		border: solid 1px #e9e9e2;
		width: 100px;
	}
	input {
		border: solid 1px #d9d9d9;
	}
	#okbtn {
		font-size: 10pt;
		padding: 10px;
		background-color: #404040;
		color:white;
	}
	
	#deletebtn {
		font-size: 10pt;
		padding: 10px;
		background-color: #808080;
		border: solid 1px #808080;
		color:white;
	}
	#btn {
		padding: 20px;
		text-align: center;
	}
</style>
<div class="container">
		<h6>EDIT PROFILE</h6>
		<form name="registerFrm">

			<table id="tblMemberRegister">
				<thead>
					<tr>
						<th colspan="2" id="th">회원정보수정
						</th>
					</tr>
				</thead>
				<tbody>
					<tr> 
						<td style="width: 20%; font-weight: bold;" class="updatelab">성명&nbsp;<span
							class="star">*</span></td>
						<td style="width: 80%; text-align: left;" class="second"><input type="text"
							name="name" id="name" class="requiredInfo" /> <!-- <span
							class="error">성명은 필수입력 사항입니다.</span> --></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;" class="updatelab">아이디&nbsp;<span
							class="star">*</span></td>
						<td style="width: 80%; text-align: left;" class="second"><input type="text"
							name="userid" id="userid" class="requiredInfo" />&nbsp;&nbsp; <!-- 아이디중복체크 -->
							<img id="idcheck" src="../images/b_id_check.gif"
							style="vertical-align: middle;" /> <!-- <span id="idcheckResult"></span>
							<span class="error">아이디는 필수입력 사항입니다.</span> --></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;" class="updatelab">비밀번호&nbsp;<span
							class="star">*</span></td>
						<td style="width: 80%; text-align: left;" class="second"><input
							type="password" name="pwd" id="pwd" class="requiredInfo" /> <!--<span
							class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로 입력하세요.</span>--></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;" class="updatelab">비밀번호확인&nbsp;<span
							class="star">*</span></td>
						<td style="width: 80%; text-align: left;" class="second"><input
							type="password" id="pwdcheck" class="requiredInfo" /><!-- <span
							class="error">암호가 일치하지 않습니다.</span>--></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;" class="updatelab">이메일&nbsp;<span
							class="star">*</span></td>
						<td style="width: 80%; text-align: left;" class="second"><input type="text"
							name="email" id="email" class="requiredInfo"
							placeholder="abc@def.com" /> <!--<span class="error">이메일 형식에
								맞지 않습니다.</span>--> <%-- ==== 퀴즈 시작 ==== --%> <span
							style="display: inline-block; width: 80px; height: 30px; border: solid 1px gray; border-radius: 5px; font-size: 8pt; text-align: center; margin-left: 10px; cursor: pointer;"
							onclick="isExistEmailCheck();">이메일중복확인</span> <span
							id="emailCheckResult"></span> <%-- ==== 퀴즈 끝 ==== --%></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;" class="updatelab" >연락처</td>
						<td style="width: 80%; text-align: left;" class="second"><input type="text"
							id="hp1" name="hp1" size="6" maxlength="3" value="010" />&nbsp;-&nbsp;
							<input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;-&nbsp;
							<input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
							<!--<span class="error">휴대폰 형식이 아닙니다.</span>--></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;" class="updatelab">우편번호</td>
						<td style="width: 80%; text-align: left;" class="second"><input type="text"
							id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
							<%-- 우편번호 찾기 --%> <img id="zipcodeSearch"
							src="../images/b_zipcode.gif" style="vertical-align: middle;" />
							<!--<span class="error">우편번호 형식이 아닙니다.</span>--></td>
					</tr>
					<tr>
						<td style="width: 20%; font-weight: bold;" class="updatelab">주소</td>
						<td style="width: 80%; text-align: left;" class="second"><input type="text"
							id="address" name="address" size="40" placeholder="주소" /><br />
							<input type="text" id="detailAddress" name="detailAddress"
							size="40" placeholder="상세주소" />&nbsp;<input type="text"
							id="extraAddress" name="extraAddress" size="40"
							placeholder="참고항목" /> <!--<span class="error">주소를 입력하세요</span>--></td>
					</tr>

					<tr>
						<td style="width: 20%; font-weight: bold;" class="updatelab">생년월일</td>
						<td style="width: 80%; text-align: left;" class="second"><input
							type="number" id="birthyyyy" name="birthyyyy" min="1950"
							max="2050" step="1" value="1995" style="width: 80px;" required />

							<select id="birthmm" name="birthmm"
							style="margin-left: 2%; width: 60px; padding: 8px;">
								<%-- 
					               <option value ="01">01</option>
					               <option value ="02">02</option>
					               <option value ="03">03</option>
					               <option value ="04">04</option>
					               <option value ="05">05</option>
					               <option value ="06">06</option>
					               <option value ="07">07</option>
					               <option value ="08">08</option>
					               <option value ="09">09</option>
					               <option value ="10">10</option>
					               <option value ="11">11</option>
					               <option value ="12">12</option>
					               --%>
							</select> 
							<select id="birthdd" name="birthdd" style="margin-left: 2%; width: 60px; padding: 8px;">
								<%-- 
					               <option value ="01">01</option>
					               <option value ="02">02</option>
					               <option value ="03">03</option>
					               <option value ="04">04</option>
					               <option value ="05">05</option>
					               <option value ="06">06</option>
					               <option value ="07">07</option>
					               <option value ="08">08</option>
					               <option value ="09">09</option>
					               <option value ="10">10</option>
					               <option value ="11">11</option>
					               <option value ="12">12</option>
					               <option value ="13">13</option>
					               <option value ="14">14</option>
					               <option value ="15">15</option>
					               <option value ="16">16</option>
					               <option value ="17">17</option>
					               <option value ="18">18</option>
					               <option value ="19">19</option>
					               <option value ="20">20</option>
					               <option value ="21">21</option>
					               <option value ="22">22</option>
					               <option value ="23">23</option>
					               <option value ="24">24</option>
					               <option value ="25">25</option>
					               <option value ="26">26</option>
					               <option value ="27">27</option>
					               <option value ="28">28</option>
					               <option value ="29">29</option>
					               <option value ="30">30</option>
					               <option value ="31">31</option>
					             --%>
						</select></td>
					</tr>
				</tbody>
			</table>
			<div id="btn">
			<button type="button" id="okbtn">회원정보수정</button>
			<button type="button" id="deletebtn">취소</button>
			</div>
		</form>
</div>

<jsp:include page="../footer.jsp" />


