<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<jsp:include page="../header.jsp" />

<style type="text/css">
#title {
	text-align: center;
	font-size: 18pt;
	margin-bottom: 60px;
}

button.btn1 {
	background: none;
	border: 0;
	outline: 0;
	cursor: pointer;
}

.tab_menu_container {
	display: flex;
}

.tab_menu_btn {
	width: 120px;
	height: 40px;
	transition: 0.3s all;
	font-size: 10pt;
}

.tab_menu_btn.on {
	border-bottom: 2px solid #df0000;
	font-weight: 700;
	color: #FF6666;
}

.tab_menu_btn:hover {
	color: #FF6666;
}

.tab_box {
	display: none;
	padding: 20px;
}

.tab_box.on {
	display: block;
}

img {
	width: 100px;
}

th {
	text-align: center;
}

td {
	text-align: center;
}

tr {
	vertical-align: middle;
}

.checked {
	color: orange;
}

#status {
	color:red;
}
#titlehead > td{
	padding:10px;
	margin-bottom: 10px;
	background-color: #e6e6e6;
}
#titlehead2 > td {
	padding: 10px;
	font-size: 10pt;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		//버튼 색 제거,추가
		$('.tab_menu_btn').on('click', function() {
			$('.tab_menu_btn').removeClass('on');
			$(this).addClass('on')
		});

		//1번 컨텐츠
		$('.tab_menu_btn1').on('click', function() {
			$('.tab_box').hide();
			$('.tab_box1').show();
		});

		//2번 컨텐츠
		$('.tab_menu_btn2').on('click', function() {
			$('.tab_box').hide();
			$('.tab_box2').show();
		});
	});
</script>

<div class="container">
	<div class="tab_wrap">
		<div class="tab_menu_container">
			<button class="tab_menu_btn1 tab_menu_btn on btn1" type="button">리뷰쓰기
				(0)</button>
			<button class="tab_menu_btn2 tab_menu_btn btn1" type="button">작성한
				리뷰 (0)</button>
		</div>
		<!-- tab_menu_container e -->

		<div class="tab_box_container">
			<div class="tab_box1 tab_box on">
				<table id="table1" class="table table-striped">
					<thead>
						<tr>
							<th>주문날짜</th>
							<th>상품이미지</th>
							<th>상품명</th>
							<th>리뷰</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="noimg">2019-07-12</td>
							<td><img class="store img-thumbnail"
								src="<%=ctxPath%>/images/mouse.png"></td>
							<td class="noimg">MX Anywhere 3 <br> 로지텍 마스터 시리즈
							</td>
							<td class="noimg">
								<button type="button" class="btn btn-info btn-lg"
									data-toggle="modal" data-target="#myModal">리뷰쓰기</button> <!-- Modal -->
								<div id="myModal" class="modal fade" role="dialog">
									<div class="modal-dialog">

										<!-- Modal content-->
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
												<h4 class="modal-title">리뷰쓰기</h4>
											</div>
											<div class="modal-body">
												<from>
												<p style="font-weight: bold;">구매하신 상품은 만족하셨나요?</p>
												<span class="fa fa-star checked"></span> <span
													class="fa fa-star checked"></span> <span
													class="fa fa-star checked"></span> <span class="fa fa-star"></span>
												<span class="fa fa-star"></span>
												<hr>
												<label for="reviewComment" class="title">리뷰를 작성해주세요.</label>
												<textarea rows="10" cols="60" id="reviewComment"
													name="reviewComment"
													placeholder="텍스트 리뷰는 200pt 포토 리뷰는 500pt를 드려요!"></textarea>
												<hr>
												<label for="addFile" class="title">사진첨부</label> <input
													type="file" id="addFile" /> </from>
											</div>
											<div class="modal-footer">
												<button type="submit" class="btn btn-default"
													data-dismiss="modal">리뷰 등록하기</button>
												<button type="button" class="btn btn-default"
													data-dismiss="modal">닫기</button>
											</div>
										</div>

									</div>
								</div>

							</td>
						</tr>

					</tbody>
				</table>
			</div>
			<div class="tab_box2 tab_box">
				<div>
					<table class="table table-striped">
						<thead>
						<tr id="titlehead">
							<th>리뷰형태</th>
							<th>이미지</th>
							<th>상품정보</th>
							<th>리뷰내용</th>
							<th>포인트 적립</th>
							<th>선택</th>
						</tr>
						</thead>
						<Tbody>
						<tr id="titlehead2">
							<td>텍스트 리뷰</td>
							<td><img class="store img-thumbnail" src="<%=ctxPath%>/images/mouse.png"></td>
							<td><span>Logitech Pebble M350 <br>슬림한 디자인의
									무소음 무선 마우스</span> <br> <br>
							<td>마우스가 가볍고, 그립감도 좋고 색상도 딱 원하던 색상이예요!<br>
							<td><span id="status">포인트 적립 미완료</span></td>
							<td>
								<button style="width: 100px;">x 삭제</button>
							</td>
						</tr>
						</Tbody>
					</table>
				</div>
			</div>

		</div>
		<!-- tab_box_container e -->
	</div>
	<!-- tab_wrap e -->

</div>

<jsp:include page="../footer.jsp" />




















