<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>
<jsp:include page="../header.jsp" />

<style type="text/css">
div.gallery {
	margin: 10px;
	width: 200px;
	display: inline-block;
	height: 300px;
	border: solid 1px gray;
}

div.gallery:hover {
	border: 1px solid #777;
}

div.desc {
	text-align: center;
	font-weight: bold;
}

div.price {
	text-align: center;
}

#product {
	border: solid 1px red;
	width: 1100px;
	text-align: center;
}

#container {
	border: solid 1px green;
	text-align: center;
}

#optiondiv {
	border: solid 1px red;
	margin-top: 10px;
}

#title {
	text-align: center;
	font-size: 18pt;
	margin-bottom: 60px;
}

#finaldiv {
	clear: both;
	border: solid 1px gray;
	text-align: center;
	padding-top: 20px;
}

#finaldiv>button {
	padding: 13px;
	margin-left: 10px;
}

.colorspan {
	display: inline-block;
	border: solid 1px gray;
	width: 20px;
	height: 10px;
}

#colordiv {
	text-align: left;
}

.uloption>li {
	border: solid 1px red;
}

tr.trcl > td {
	padding : 10px;
	text-align: center;
	font-size: 10pt;
	width: 230px;
}

#headtr {
	background-color: #f2f2f2;
	font-size: 10pt;
}

#imgaj {
	width:70px;
	height:70px;
}
#body {
	text-align: center;
}

#addcartbtn {
	background-color: #f2f2f2;
	color: black;
	border: none;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		
		$("button#allcheck").click(function() {

			var bool = $("input.chkbtn").eq(0).prop("checked");

			$("input.chkbtn").prop("checked", !bool); // 체크박스에 모두 체크를 해준것

		});
		
		$("#dialog").dialog({
			autoOpen: false,
			width: 400,
			height: 400,
			modal: true,
			// 버튼 종류
			buttons:[
				{
					text: "확인",
					click:function(){
						location.href = "<%= ctxPath%>/mypage/ordercart.sg";
					}
				},
				{
					text: "취소",
					click:function(){
						$(this).dialog("close");
					}
				}
			]
		});
		
		console.log("hi~");
		console.log($("#td1").text());
		
		var arrselect = $(".inputhidden");
		arrselect.each(function(index, item){
			$("#colorselec"+index).on('change', function() {
				$("#optionselec"+index).text($("#colorselec"+index+" option:selected").val())
				//alert($("#colorselec"+index+" option:selected").val());
			});
		});
		
	});
	
	function goRegister(){
	// id 보내고 color 보내고 가격 보내고 
		var flag = true;
		var arrObj = new Array();
		var checkarr = $("input.chkbtn:checked");
		var arr = $("input.chkbtn");
		arr.each(function(index, item){
			checkarr.each(function(index2, item2){
				
				if(item == item2){
					//alert($("#colorselec"+index+" option:selected").val());
					
					if($("#colorselec"+index+" option:selected").val() != "none"){
					//none
					//alert(("#colorselec"+index+" option:selected").val());
					var product = {
						"fk_productid" : $("#inproid"+index).val(),
						"price" : $("#inprice"+index).val(),
						"selectcolor" : $("#colorselec"+index+" option:selected").val()
					};
					arrObj.push(product);
					}
					else{
						//alert("선택키키");
						flag = false;
					}
				
				}
			});
		});
		
		if(flag){
	    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
		var str_arrObj = JSON.stringify(arrObj); // [{},{},{}] 객체배열을 String 타입으로 바꾸어주는 것 	
		
        $.ajax({
        	url:"<%= ctxPath%>/mypage/orderheart.sg",
        	dataType: "json",
        	data:{"str_arrObj":str_arrObj},	// data는 위의 url로 전송해야할 데이터를 말한다. 
        	type:"post", 
        	success:function(json){
        		if(json.bl == true){
        			<%-- if (confirm("선택한 제품이 장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?") == true){
        				location.href = "<%= ctxPath%>/mypage/ordercart.sg";
        			}
        			else{
        				location.href = "<%= ctxPath%>/mypage/orderheart.sg";
        				$("input.chkbtn").prop("checked", false);
        			} --%>
        			$("#modaltitle").text("선택하신 상품이 장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?");
        			$("#btnoks").click(function() {
        				location.href = "<%= ctxPath%>/mypage/ordercart.sg";
        			});
        			$("#btncancel").click(function() {
        				//alert("dd");
        				location.reload();
        				<%-- $("input.chkbtn").prop("checked", false);
        				location.href = "<%= ctxPath%>/mypage/orderheart.sg"; --%>
        				
        			});
        			
        		}
        		else{
        			$("#modaltitle").text("선택하신 상품 중 아래의 상품은 이미 장바구니에 존재합니다. 장바구니로 이동하시겠습니까?");
        
        			$("#td1").text(json.id);
        			var arr = $("#td1").text().split(",");
        			$("#td2").text(json.color);
        			var arr2 = $("#td2").text().split(",");
        			$("#td3").text(json.img);
        			var arr3 = $("#td3").text().split(",");
        			//alert(arr[0] + arr2[0]);
        			
        			
        			//$("#td1").text(arr[0]);
        			//$("#td2").text(arr2[0]);
        			$("#td1").hide();
        			$("#td2").hide();
        			$("#td3").hide();
        			
        			//alert(arr3[0]);
        			var html = "<table><tr class='trcl' id='headtr'><td>이미지</td><td>상품명</td><td>옵션</td></tr>";
        			arr.forEach(function(item, index){
        				html += "<tr class='trcl'><td><img id='imgaj' src='"+arr3[index]+"'/></td><td>"+item+"</td><td>"+arr2[index]+"</td></tr>";
        			});
        			html += "</table>";
        			
        			$("#body").html(html);
        			
        			$("#btnoks").click(function() {
        				location.href = "<%= ctxPath%>/mypage/ordercart.sg";
        			});
        			
        			$("#btncancel").click(function() {
        				<%--location.href = "<%= ctxPath%>/mypage/orderheart.sg";
        				$("input.chkbtn").prop("checked", false);--%>
        				location.reload();
        			});
        			//$("#dialog").dialog("open"); 
        		}
        		
        	},
        	error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
             }
        });	
		}
		else{
			$("#modaltitle").text("선택하신 제품중에 옵션을 선택하지 않은 상품이 존재합니다. 옵션을 선택해주세요.");
			$("#body").hide();
		}

	}
	
	function cancel() {
		var arrcheck = $(".chkbtn");
		var seq = "";
		arrcheck.each(function(index, item){
			if($("#checkoption"+index).is(":checked")==true){
				seq += $("#seq"+index).val();
				if(arrcheck.length-1 > index){
					seq += ",";
				}
			}
		});
		
		  location.href="/Logitech/mypage/orderheart.sg?seq="+seq;
	      alert("선택하신 상품이 장바구니에서 삭제되었습니다.");
	      location.reload();
		//alert(seq);
	}
	

</script>

<div class="container">
	<form name="registerFrm">
	<div id="title">LIKE</div>
	<c:forEach var="pvo" items="${likelist}" varStatus="status">
		<div id="product">
			<div class="gallery">
				<span> 
					<a href="img_5terre.jpg"> 
						<img class="store img-thumbnail" src="${pvo.imgfilename}">
					</a> 
					<input type="checkbox" id="checkoption${status.index}" class="chkbtn" value="chk${status.index}"/><br>
					<input type="text" value="${pvo.productid}" name="fk_productid" id="inproid${status.index}" hidden="true" class="inputhidden" />
					<input type="text"value="${pvo.price}" name="price" id="inprice${status.index}" hidden="true" class="inputhidden"/>
					<input type="text" value="${pvo.lpvo.seq_like}" id="seq${status.index}" hidden="true"/>
					
					<div id="colordiv">
						<c:forEach var="list" items="${colorlist.get(status.index)}">
							<span class="colorspan" style="background-color: ${list};"></span>
						</c:forEach>
					</div>
					<div class="desc">
						 ${pvo.productid}
				    <br> ${pvo.productname}
					</div>
					<div class="price">${pvo.price}</div> 

					<div class="dropdown" id="optiondiv">
						 <button onclick="optionbtn();" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" id="optionselec${status.index}">
							옵션선택<span class="caret"></span>
						 </button> 
						<ul class="dropdown-menu" class="uloption">
							<li>
								<form>
									<select name="selectcolor" id="colorselec${status.index}" class="inputhidden">
										<option value="none">color</option>
										<c:forEach var="list" items="${colorlist.get(status.index)}">
											<option value="${list}">${list}</option>	
										</c:forEach>
									</select>
								</form>
							</li>
							<%-- 
							<li>
								<button type="button">확인</button>
							</li>
							--%>
						</ul>
					</div> 
				</span>
			</div>
		</div>
	</c:forEach>
	
	<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h6 class="modal-title" id="modaltitle"></h6>
        </div>
        <div class="modal-body" id="body">
         <span id="td1"></span>
         <span id="td2"></span>
         <span id="td3"></span>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" id="btncancel">취소</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" id="btnoks">확인</button>
        </div>
      </div>
    </div>
  </div>
</div>


	<br> <br> <br>
	<div id="finaldiv">
		<button type="button" id="allcheck">전체선택/해제</button>
		<button onClick="goRegister();"  type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal" id="addcartbtn">선택상품 한번에 담기</button>
		<button onclick="cancel();">선택상품 삭제</button>
	</div>
	</form>

</div>
<jsp:include page="../footer.jsp" />