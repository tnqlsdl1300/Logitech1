<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="../managerHeader.jsp" />

<style>
#eventRegisterState {
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
		$(function() {
            //모든 datepicker에 대한 공통 옵션 설정
            $.datepicker.setDefaults({
	            dateFormat: 'yy-mm-dd' //Input Display Format 변경
	            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	            ,changeYear: true //콤보박스에서 년 선택 가능
	            ,changeMonth: true //콤보박스에서 월 선택 가능                
	            ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	            ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	            ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	            ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	            // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	            // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
            });
   
            //input을 datepicker로 선언
            $("#startday").datepicker();                    
            $("#endday").datepicker();
              
            //From의 초기값을 오늘 날짜로 설정
            $('#startday').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
            //To의 초기값을 내일로 설정
            $('#endday').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
          });// end of $(function(){})------------------------
	});// end of $(document).ready(function(){})-----------------------------
</script>

<div id="eventRegisterState">
	<div class="row">
		<div class="col-sm-12">
			<div class="well">
				<h4>이벤트 등록</h4> 
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="well divContent">
				<form name="registerFrm">
					<table id="tblEventRegister">
						<thead>
							<tr>
								<th colspan="2" id="th">
									::: 이벤트등록 (<span style="font-size: 10pt; font-style: italic;"><span class="star">*</span>표시는 필수입력사항</span>) :::
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									이벤트명&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="eventname" id="eventname" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									제품아이디&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="fk_productid" id="fk_productid" class="requiredInfo" />
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									시작일&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="startday" id="startday" class="requiredInfo" />&nbsp;&nbsp;
									<!-- 아이디중복체크 -->
									<span class="error"></span>
								</td>
							</tr>
							<tr>
								<td style="width: 20%; font-weight: bold;">
									종료일&nbsp;<span class="star">*</span>
								</td>
								<td style="width: 80%; text-align: left;">
									<input type="text" name="endday" id="endday" class="requiredInfo" />
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