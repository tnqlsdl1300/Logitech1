<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%@ taglib prefix="fn" uri ="http://java.sun.com/jsp/jstl/functions"%>
   
    <%
    	String ctxPath = request.getContextPath();
    %>
<!DOCTYPE html>
<html>
<head>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

<style>
* {
    box-sizing: border-box;
}
body {
    font-family: Arial;
    
    background: #f1f1f1;
}

.header {
    padding: 30px;
    text-align: center;
    background: white;
}
.header h1 {
    font-size: 50px;
}

/* .topnav {
    overflow: hidden;
    background-color: #333;
} */

.topnav a {
    float: left;
    display: block;
    color: #f2f2f2;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}
 
.topnav a:hover {
    background-color: #ddd;
    color: black;
}

.leftcolumn {   
    float: left;
    width: 75%;
}

.rightcolumn {
    float: left;
    width: 25%;
    background-color: white;
    padding-left: 20px;
}

.fakeimg {
    background-color:white;
    width: 100%;
    padding: 20px;
}

.card {
    background-color: hsl(0, 100%, 90%);
    padding: 20px;
    margin-top: 20px;
}

.row:after {
    content: "";
    display: table;
    clear: both;
}

.footer {
    padding: 20px;
    text-align: center;
    background: #ddd;
    margin-top: 20px;
}

@media screen and (max-width: 800px) {
    .leftcolumn, .rightcolumn {   
        width: 100%;
        padding: 0;
    }
}

@media screen and (max-width: 400px) {
    .topnav a {
        float: none;
        width: 100%;
    }
}

	div#wrap{
		border: solid 0px blue;
		width: 1150px;
		margin: 0 auto;
	}
	
	footer#page_footer{
		background-color: #cccccc;
		
		clear: both;
		height: 80px;
	}
	
	
	
	
	@import url("https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap");

select {
  /* 생략 */
  font-family: "Noto Sansf KR", sans-serif;
  font-size: 1rem;
  font-weight: 400;
  line-height: 1.5;

  color: #444;
  background-color: #fff;

  padding: 0.6em 1.4em 0.5em 0.8em;
  margin: 0;

  border: 1px solid #aaa;
  border-radius: 0.5em;
  box-shadow: 0 1px 0 1px rgba(0, 0, 0, 0.04);
}


select:hover {
  border-color: #888;
}

select:focus {
  border-color: #aaa;
  box-shadow: 0 0 1px 3px rgba(59, 153, 252, 0.7);
  box-shadow: 0 0 0 3px -moz-mac-focusring;
  color: #222;
  outline: none;
}

select:disabled {
  opacity: 0.5;
}
	
	
	
	
	
	
	

</style>
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<script type="text/javascript">
	
	$(document).ready(function() {
		
		var origincost = $("#originCost").val();
		
		var discountcost = 0;
		
		var totalcost = Number(origincost) - Number(discountcost);
				
		$("input#totalCost").val(totalcost); 
		
		$("input#amount").val(sessionStorage.getItem("amount"));
		 
		
		
		
		var totalPrice = 0;

		$("div.byproduct").each(function(){
		  
			var eachPrice = $(this).children().children().children(".eachPrice").text();
		   //console.log(eachPrice);
		   
		   var amount = $(this).children().children().children(".amount").val();
		   //console.log(amount);
		   totalPrice += Number(eachPrice) * Number(amount);
		   
		});

		$("span#totalCost").html(totalPrice);
		
		
		/*
		var paymoney = Number( ${rProductVO.price} ) * Number( $("input#amount").val() ) ;
		$("span#paymoney1").text(paymoney.toLocaleString('en')); 
		*/ 
		
		
		// 쿠폰 금액 적용
		$("select#choiceCoupon").change(function(){
			var discount = $(this).val();
		//	alert(discount);
			
			if(discount == null) {
				discount = 0;
			}
		
			
			$("span#discountCost").html(discount);
			
			// 쿠폰 금액을 계산한 결제금액
			var paymoney = totalPrice - Number($("span#discountCost").text());
			$("span#paymoney").html(paymoney);
			
			
		});
		
		 
		 
		
		
		
		
		//주소입력
		$("img#zipcodeSearch").click(function(){
	
		new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();

	});// end of $("img#zipcodeSearch").click(function()-----------------------------------------
	
			
			//주문자와 동일을 누르면 아이디,이름,전화번호가 다시 온다.
			$("input#originalInfo").click(function(){
				
				$("input:text[name=userid]").val("${sessionScope.loginuser.userid}");
				$("input:text[name=name]").val("${sessionScope.loginuser.name}");
				$("input:text[name=mobile]").val("${sessionScope.loginuser.mobile}");
		
			});// ---------------------------------------------------------
			
			
			// 주문자가 새입력 누르면 비워준다.
			$("input#newInfo").click(function(){
				
				$("input.form-control").val("");  
				
			});// ---------------------------------------------------------
	
		
			
	
	
	
	});//end of document.ready() -----------------------------------------------------------------
	
	function goPayment(){
		
	}
	
	
	
</script>

</head>
<body>
<jsp:include page="../header.jsp"/>
<div id="wrap"> 

<div class="header" style="background-color:black;">
  <img src="<%=ctxPath%>/images/logitecha.png"/>
  <p style="color:white; font-weight:bold;">로지텍만의 완벽한 품질을 누리세요</p>
</div>
 
<!-- <div class="topnav">
  <a href="#">홈</a>
  <a href="#">제품</a>
  <a href="#">링크</a>
   <a href="#" style="float:right"></a>
</div> -->
 
<div class="row">

  <div class="leftcolumn">
  
    <div class="card" >
      
      <h2  style="font-weight:bold;">구매 정보</h2>
      
      
  
     
   <div class="fakeimg" style="height:1200px;">
   <c:forEach var="pvo" items="${purchaseList}">
      <div class="byproduct">
         <img src="${pvo.imgfilename}" style="width:100%"/>

         <%--  <ol><h2  style="font-weight:bold;">제품ID : ${pvo.productid} </h2></ol> --%>
         <ol><h2  style="font-weight:bold;">제품일련번호 : ${pvo.povo.productserialid} </h2></ol>
         <ol><h2  style="font-weight:bold;">제품명  : ${pvo.productname} </h2></ol>
         <%--  <ol><h2  style="font-weight:bold;">가격  : <fmt:formatNumber value="${rProductVO.price}" pattern="###,###"/>원</h2></ol> --%>
         <ol><h2 style="font-weight:bold;" value="${pvo.povo.color}">컬러  : ${pvo.povo.color}</h2></ol>
         <ol><h2 style="font-weight:bold;" value="${pvo.price}">상품가격  :<span class="eachPrice">${pvo.price}</span> </h2></ol>
         <ol><h2 style="font-weight:bold;">수량  : <input type="text" name="amount" class="amount" id="amount" value="" size="1" readonly style="border: none;" /></h2></ol>
      </div>
   </c:forEach>
</div>

<br>
  
<div>
	<input type="radio" name="chk_info" id="originalInfo" value="originalInfo" checked="checked">
	<label for = "originalInfo">주문자와 동일</label>
	<input type="radio" name="chk_info" id="newInfo" value="newInfo">
	<label for = "newInfo">새입력</label>
</div>
  
  <br>
  
   <div class="form-group">
    <label for="inputdefault">주문자</label>
    <!-- <input class="form-control" id="inputdefault" type="text"> -->
      <input class="form-control" type="text" name="userid" id="inputdefault userid" value="${sessionScope.loginuser.userid}" required /> 
                <!-- id값도 넘어간다 누구아이디인지 알려주고 히든타입으로 변경 -->
             
  </div>
  
  <div class="form-group">
    <label for="inputdefault">회원명</label>
    <!-- <input class="form-control" id="inputdefault" type="text"> -->
     <input type="text" class="form-control" name="name" id="name" value="${sessionScope.loginuser.name}" class="requiredInfo" required />
  </div>
  
  <div class="form-group">
    <label for="inputdefault">전화번호 <span style="color:red";> (-을 빼고 입력하세요)</span></label>
   <input type="text" class="form-control" name="mobile" id="mobile" value="${sessionScope.loginuser.mobile}" class="requiredInfo" required />
  </div>
  
  
  <div class="form-group">
  <tr>
         <td style="width: 20%; font-weight: bold;">우편번호</td>
         <td style="width: 80%; text-align: left;">
            <input type="text" id="postcode"  class="form-control" name="postcode" size="6" maxlength="5" required/>&nbsp;&nbsp;
            <%-- 우편번호 찾기 --%>
            <img id="zipcodeSearch" src="../images/b_zipcode.gif" style="vertical-align: middle;" />
            
         </td>
      </tr>
  </div>
  
  
  <div class="form-group">
    <tr>
         <td style="width: 20%; font-weight: bold;">주소</td>
         <td style="width: 80%; text-align: left;">
            <input type="text" class="form-control" id="address" name="address" size="40" placeholder="주소" /><br/>
            <input type="text" class="form-control" id="detailAddress" name="detailAddress" size="40" placeholder="상세주소" />&nbsp;
            <input type="text" class="form-control" id="extraAddress" name="extraAddress" size="40" placeholder="참고항목" />
            <span class="error">주소를 입력하세요</span> 
            
         </td>
      </tr>
  </div>
  
  
  <div>
    <select class="myselect" name="orderList" >
                  <option>배송 시 요청사항을 선택해주세요</option>
                  <option value="1">부재시 경비실에 맡겨주세요</option>
                  <option value="2">부재시 택배함에 넣어주세요</option>
                  <option value="3">부재시 문 앞에 놔주세요</option>
                  <option value="4">배송 전 연락주세요</option>
                  <option value="5">파손의 위험이 있는 상품입니다. 배송시 주의헤주세요.</option>
    </select>
  </div>
  
 
 

      
      </div>
      
    </div>
     
     
     <!-- <div class="card">
      <h2>2번째</h2>
      <h5>추천물품?</h5>
      <div class="fakeimg" style="height:200px;">이미지</div>
      <p>ABC</p>
      <p>
      </p>
    </div>
  </div>  -->
  
  
  
  <div class="rightcolumn">
    <div class="card" style="width:300px;">
      <h4 style="font-weight:bold;">보유 쿠폰을 확인하세요.</h4>
      <div class="fakeimg" style="height:100px;">
				
				
				  <c:if test="${couponList.size() == 0}">
                  <span style="color:red; font-weight:bold;">보유중인 쿠폰이 없습니다.</span>
                  </c:if>
                
                  <c:if test="${couponList.size() > 0}">
                  <select id="choiceCoupon" class="myselect" name="coupon">
                  <option selected>쿠폰을 선택하세요</option>
                  <c:forEach var="ecvo" items="${couponList}"><option id="choice"value="${ecvo.coupvo.discount}"> ${ecvo.coupvo.couponname} : ${ecvo.coupvo.discount}원</option></c:forEach>
                  </select>
                  </c:if>
               
               
               
              <%--  <c:if test="${not empty imgList}">
			<c:forEach var="imgfilename" items="${imgList}">
				<div class="col-md-3 line">
				   <img src="/MyMVC/images/${imgfilename}" style="width: 200px; height: 170px;" />
				</div>
			</c:forEach>
		</c:if> --%>
		
		</div>     
      <p></p>
    </div>
    
    
    <div class="card" style="width:300px;">
      <h3>결제금액</h3>
<%--        <div class="fakeimg"><h4  style="font-weight:bold;">상품가격  :  <fmt:formatNumber value="${pvo.price}" pattern="###,###"/>원</h4></div>
      <div class="fakeimg"><h4  style="font-weight:bold;">수량  :  <input type="text" name="amount" id="amount" value="" size="1" readonly style="border: none;" /></h4></div>
--%>  

	
	<input id="originCost" type="hidden" value="totalPrice">
      
      <div class="fakeimg"><p>총 금액: <span id="totalCost"></span>원</p></div>
      <%-- 
      <c:if test="${eachcouponcode == null}">
      		<div class="fakeimg"><p>쿠폰할인: <span id="nodiscountCost">0</span>원</p></div>
      		<div class="fakeimg"><h4  style="font-weight:bold;">결제금액&nbsp;:&nbsp;<span id="paymoney1"></span>원</h4></div>
      	    <input id="totalCost" type="hidden" value="">
      </c:if>
      --%>
 <%--     <c:if test="${eachcouponcode != null}"> --%>
      		<div class="fakeimg"><p>쿠폰할인: -<span id ="discountCost">${eachcouponcode}</span>원</p></div>
      		<div class="fakeimg"><h4  style="font-weight:bold;">결제금액&nbsp;:&nbsp;<span id="paymoney"></span>원</h4></div>
      	    <input id="totalCost" type="hidden" value="">
 <%--     </c:if> --%>
      
      
      <!-- <div class="fakeimg"><p>합계:<span id="totalCost"></span>원</p></div> -->
      
      <%--  <div class="fakeimg"><h4  style="font-weight:bold;">결제금액  :  <fmt:formatNumber value="${rProductVO.price - eachcouponcode}" pattern="###,###"/>원</h4></div>
      <input id="totalCost" type="hidden" value=""> --%>
    </div>
   
    <div class="card" align="center" style="width:300px;">
    <button type="button" class="btn btn-info" onclick="goPayment()">결제하기</button> &nbsp;&nbsp;&nbsp;
    <button type="button" class="btn btn-danger" onclick="location.href='javascript:history.back()'">취소</button>
      
      
      <p></p>
      
    	</div>
	  </div>
	</div>
 </div>
 
 

 <jsp:include page="../footer.jsp" />  
 
</body>
</html>