<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.text.SimpleDateFormat, java.util.Calendar"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%
	String ctxPath = request.getContextPath();

	Calendar cal = Calendar.getInstance();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	String today = format.format(cal.getTime());
%>

<jsp:include page="managerHeader.jsp" />

<style type="text/css">
#dashboard {
	font-size: 30pt;
	font-weight: bold;
	letter-spacing: 4px;
	padding: 20px;
	padding-left: 50px;
}

#divUl {
	padding: 20px 50px;
}

#viewBox {
	display: table;
/*	float: left; */
	table-layout: fixed;
/*	list-style: none; */
	text-align: center;
	width: 100%;
	margin: 0px;
	padding: 0px;
}

#viewBox > li {
	display: table-cell;
	list-style: none;
	margin: 0px;
	padding: 0px;
}

.viewParty {
	text-align: center;
	line-height: 30px;
	margin: 0 auto;
}

li.boxForWhite {
	background-color: white;
}

#divUnbox {
	width: 43%;
	margin: 0 0 50px 50px;
	padding: 40px;
}

#currentState {
	width: 43%;
	margin: 0 0 50px 50px;
	padding: 40px;
}

.tblIndex {
	width: 90%;
	margin-left: auto;
	margin-right: auto;
}

.tblIndex > thead > tr {
	background-color: #bfbfbf;
}

.tblIndex, .tblIndex tr, .tblIndex th, .tblIndex td {
	border: solid 1px #ccc;
	text-align: center;
}

.tblIndex th, .tblIndex td {
	height: 50px;
}

.divTable {
	text-align: center;
	margin: 30px;
}

#displayOneQuery > tr:hover, #displayProductQA > tr:hover {
	background-color: #f2f2f2;
	cursor: pointer;
}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$("span#totalHITCountOQ").hide();
		$("span#countHITOQ").hide();
		$("span#totalHITCountPQA").hide();
		$("span#countHITPQA").hide();
		
		displayOneQuery("1");  // 문서가 로딩되면 1~8 까지 상품이 보여야 한다.
		displayProductQA("1");
		
		// 일대일 문의 게시물을 더 보기 위하여 "더 보기" 버튼 클릭액션 이벤트 등록하기
		$("button#btnMoreOneQuery").click(function(){
			if($(this).text() == "처음으로") {
				$("div#displayOneQuery").empty();
				$("span#oqend").empty();
				displayOneQuery("1");
				$(this).text("더 보기");
			} else {
				displayOneQuery($(this).val());
			}// end of if($(this).text() == "처음으로"){}--------------------------
		});// end of $("button#btnMoreOneQuery").click(function(){})----------------------
		
		// 제품 문의 게시물을 더 보기 위하여 "더 보기" 버튼 클릭액션 이벤트 등록하기
		$("button#btnMoreProdQA").click(function(){
			if($(this).text() == "처음으로") {
				$("div#displayProductQA").empty();
				$("span#pqaend").empty();
				displayProductQA("1");
				$(this).text("더 보기");
			} else {
				displayProductQA($(this).val());
			}// end of if($(this).text() == "처음으로"){}--------------------------
		});// end of $("button#btnMoreProdQA").click(function(){})----------------------
		
		
		// 일대일 문의 행 클릭 시 modal 창에 상세 정보 띄우기
		$(document).on("click", "#displayOneQuery > tr", function(){
			var seq_oq = $(this).children(".seq_oq").text();
			var userid = $(this).children(".userid").text();
			// alert(seq_oq);
			
			var html = "<iframe style='border: none; width: 100%; height: 280px;' src='/Logitech/manager/support/oneQueryDetail.sg?seq_oq="+seq_oq+"&userid="+userid+"'></iframe>";
			
			$("div.oqmodal-body").html(html);
			
			$("#oneQueryModal").modal('show');
		});// end of $(document).on("click", "#displayOneQuery > tr", function(){})-----------------
		
		$(document).on("click", "#displayProductQA > tr", function(){
			var seq_qa = $(this).children(".seq_qa").text();
			var userid = $(this).children(".userid").text();
			// alert(seq_oq);
			
			var html = "<iframe style='border: none; width: 100%; height: 280px;' src='/Logitech/manager/support/productQADetail.sg?seq_qa="+seq_qa+"&userid="+userid+"'></iframe>";
			
			$("div.oqmodal-body").html(html);
			
			$("#oneQueryModal").modal('show');
		});// end of $(document).on("click", "#displayOneQuery > tr", function(){})-----------------
	});// end of $(document).ready(function(){})-----------------------------
	
	var lenHIT = 5;  // HIT 상품 "더보기..." 버튼을 클릭할 보여줄 상품의 개수(단위) 
	
	// display 할 일대일 문의 정보를 추가 요청하는 함수(Ajax 로 처리한다)
	function displayOneQuery(start) {
		$.ajax({
			url:"<%= ctxPath%>/manager/displayOneQueryJSON.sg",
		//	type:"GET",
			data:{"today":"<%= today%>"
				, "start":start
				, "len":lenHIT},
			dataType:"JSON",
			success:function(json){
				var html = "";
				
				if(json.length > 0) {  // 배열.length -> 배열의 요소가 있는지 없는지를 확인하는 방법이다.
					// 데이터가 존재하는 경우
					$.each(json, function(index, item){  // $.each(배열명, function(index, item){})
						
						html += "<tr class='moreOQInfo'>"
							+ "<td class='seq_oq'>"+item.seq_oq+"</td>"
							+ "<td class='userid'>"+item.userid+"</td>"
							+ "<td>"+item.category+"</td>"
							+ "<td>"+item.title+"</td>"
							+ "<td>"+item.answerstatus+"</td>"
							+ "</tr>";
					});// end of $.each(json, function(index, item){})-----------------------------
					
					// HIT 상품 결과를 출력하기(차곡차곡 쌓는다)
					$("tbody#displayOneQuery").append(html);
					
					// ★★★ 중요 !!! 더보기 버튼의 value 속성에 값을 지정하기 ★★★ //
					$("button#btnMoreOneQuery").val(Number(start) + lenHIT);
					
					// countHIT 에 지금까지 출력된 상품의 개수를 누적하여 기록한다. -> 마지막 페이지를 확인하기 위해서이다.
					$("span#countHITOQ").text( Number($("span#countHITOQ").text()) + json.length);  // 현재 기록된 개수에 불러온 개수(배열의 길이 == 개수)를 더한다.
					
					// 더보기 버튼을 계속해서 클릭해 countHIT 값과 totalHITCount 값이 일치하는 경우
					if($("span#countHITOQ").text() == $("span#totalHITCountOQ").text()) {
						$("span#oqend").html("더 이상 조회할 문의가 없습니다.");
						$("button#btnMoreOneQuery").text("처음으로");
						$("span#countHITOQ").text("0");
					}// end of if($("span#countHIT").text() == $("span#totalHITCount").text()){}-----
				}// end of if(json.length > 0){}------------------------------
			},
			error:function(request, status, error){  // error 는 결과를 받아올 수 없는 코드 상의 오류이다.
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});// end of $.ajax({})-----------------------------
	}// end of function displayOneQuery(){}-----------------------------------
	
	// display 할 제품 문의 정보를 추가 요청하는 함수(Ajax 로 처리한다)
	function displayProductQA(start) {
		$.ajax({
			url:"<%= ctxPath%>/manager/displayProductQAJSON.sg",
		//	type:"GET",
			data:{"today":"<%= today%>"
				, "start":start
				, "len":lenHIT},
			dataType:"JSON",
			success:function(json){
				var html = "";
				
				if(json.length > 0) {  // 배열.length -> 배열의 요소가 있는지 없는지를 확인하는 방법이다.
					// 데이터가 존재하는 경우
					$.each(json, function(index, item){  // $.each(배열명, function(index, item){})
						html += "<tr class='morePQAInfo'>"
							+ "<td class='seq_qa'>"+item.seq_qa+"</td>"
							+ "<td class='userid'>"+item.userid+"</td>"
							+ "<td>"+item.fk_productid+"</td>"
							+ "<td>"+item.content+"</td>"
							+ "<td>"+item.status+"</td>"
							+ "</tr>";
					});// end of $.each(json, function(index, item){})-----------------------------
					
					// HIT 상품 결과를 출력하기(차곡차곡 쌓는다)
					$("tbody#displayProductQA").append(html);
					
					// ★★★ 중요 !!! 더보기 버튼의 value 속성에 값을 지정하기 ★★★ //
					$("button#btnMoreProdQA").val(Number(start) + lenHIT);
					
					// countHIT 에 지금까지 출력된 상품의 개수를 누적하여 기록한다. -> 마지막 페이지를 확인하기 위해서이다.
					$("span#countHITPQA").text( Number($("span#countHITPQA").text()) + json.length);  // 현재 기록된 개수에 불러온 개수(배열의 길이 == 개수)를 더한다.
					
					// 더보기 버튼을 계속해서 클릭해 countHIT 값과 totalHITCount 값이 일치하는 경우
					if($("span#countHITPQA").text() == $("span#totalHITCountPQA").text()) {
						$("span#pqaend").html("더 이상 조회할 문의가 없습니다.");
						$("button#btnMoreProdQA").text("처음으로");
						$("span#countHITPQA").text("0");
					}// end of if($("span#countHIT").text() == $("span#totalHITCount").text()){}-----
				}// end of if(json.length > 0){}------------------------------
			},
			error:function(request, status, error){  // error 는 결과를 받아올 수 없는 코드 상의 오류이다.
	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});// end of $.ajax({})-----------------------------
	}// end of function displayProductQA(){}-----------------------------------
</script>

	<div style="width: 100%;">
		<div id="dashboard">Overview</div>
		
		<div id="divUl">
			<ul id="viewBox">
				<li class="viewParty boxForWhite">
					134<br>회원 현황
				</li>
				<li></li>
				<li class="viewParty boxForWhite">
					134<br>제품 현황
				</li>
				<li></li>
				<li class="viewParty boxForWhite">
					134<br>주문 현황
				</li>
				<li></li>
				<li class="viewParty boxForWhite">
					134<br>판촉 현황
				</li>
			</ul>
		</div>
		
		<div id="divUnbox" style="float: left; background-color: white;">
			<span>Current State</span><br>
			<hr>
			<img src="images/icon_graph bar.png" width="300px;" height="200px;" />
		</div>
		
		<div id="currentState" style="float: left; background-color: white;">
			<span>Current State</span><br>
			<hr>
			<img src="images/icon_graph bar.png" width="300px;" height="200px;" />
		</div>
		
		<div style="clear:both; float:left; width: 43%; margin: 0 0 50px 50px; background-color: white;">
			<span>일대일 문의 상황</span>
			<hr>
			<table class="tblIndex">
				<thead class="tHeadRow" align="center">
					<tr class="tHeadRow">
						<th>번호</th>
						<th>작성자</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>답변상태</th>
					</tr>
				</thead>
				
				<tbody id="displayOneQuery"></tbody>
			</table>
	
			<div class="divTable" style="background-color: white;">
				<span id="oqend" style="font-size: 12pt; font-weight: bold; color: red;"></span><br/> 
				<button type="button" id="btnMoreOneQuery" value="">더 보기</button>
				<span id="totalHITCountOQ">${totalOQCount}</span>
				<span id="countHITOQ">0</span>
			</div>
		</div>
		
		<div style="float: left; width: 43%; margin: 0 0 50px 50px; background-color: white;">	
			<span>제품 문의 상황</span>
			<hr>
			<table class="tblIndex">
				<thead class="tHeadRow" align="center">
					<tr>
						<th>번호</th>
						<th>작성자</th>
						<th>제품아이디</th>
						<th>내용</th>
						<th>답변상태</th>
					</tr>
				</thead>
				
				<tbody id="displayProductQA"></tbody>
			</table>
	
			<div class="divTable" style="background-color: white;">
				<span id="pqaend" style="font-size: 12pt; font-weight: bold; color: red;"></span><br/> 
				<button type="button" id="btnMoreProdQA" value=""">더 보기</button>
				<span id="totalHITCountPQA">${totalPQACount}</span>
				<span id="countHITPQA">0</span>
			</div>
		</div>
	</div>

<!-- 일대일 문의 Modal -->
<div id="oneQueryModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">상세 문의 정보</h4>
      </div>
      <div class="modal-body oqmodal-body">
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='javascript:history.go(0);'">Close</button>
      </div>
    </div>

  </div>
</div>

<jsp:include page="managerFooter.jsp" />