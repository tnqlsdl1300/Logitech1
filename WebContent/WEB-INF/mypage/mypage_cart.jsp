<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<style type="text/css">
tr#titlehead>td {
   width: 200px;
   height: 50px;
   font-size: 10pt;
   background-color: #f4f4f0;
   text-align: center;
}

tr#titlehead2>td {
   /* border: solid 1px gray; */
   width: 200px;
   height: 50px;
   font-size: 10pt;
   text-align: center;
   padding: 10px;
}

#title {
   text-align: center;
   font-size: 18pt;
   margin-bottom: 60px;
}

#seconddiv li {
   list-style-type: none;
   text-align: right;
}

#span3 {
   font-size: 8pt;
}

tr#tr3>td {
   width: 200px;
   height: 50px;
   font-size: 10pt;
   text-align: center;
   background-color: #f4f4f0;
}

tr#trnumber>td {
   border: solid 1px #d2d2d2;
   font-size: 18pt;
   text-align: center;
   font-weight: bold;
   width: 200px;
   height: 50px;
}

span.span4 {
   display: inline-block;
   width: 700px;
}

#finalbtn {
   text-align: center;
   list-style-type: none;
}

#finalbtn>button {
   padding: 10px;
   width: 150px;
}

img {
   width: 100px;
   height: 100px;
}

#fixdiv {
   background-color: white;
   padding-left: 220px;
}
</style>

<script type="text/javascript">
   $(document).ready(function() {
      console.log($("#allcheck").val());
      var sum = 0;
      var result = 0;
      arrcheck = $("input.checkclass").length;
      //alert(arrcheck);
      $("input.checkclass").each(function(index, item) {
         //
         
         // 초기값 설정
         $("#oneresult"+index).text($("#price"+index).text());
         
         // 수량 변경 버튼을 눌렀을때 해당 수량에 맞는 각 가격을 설정
         $("#numchange" + index).click(function() {
            var temp = parseInt($("#oneresult"+index).text());
            
            var cnt = parseInt($("#numinput"+index).val());
            var price = parseInt($("#price"+index).text());
            var eachresult = cnt * price;
            $("#oneresult"+index).text(eachresult);
            
            if ($("#check" + index).is(":checked")==true) {
            	//alert("num");
               sum = sum - temp;
               sum = sum + eachresult;
               $("#sumresult").text(sum);
            }
            
            if(parseInt($("#sumresult").text()) >= 300000){
               $("#deliver").text("0");
            }
            else{
               $("#deliver").text("2500");
            }
            
            $("#totalsum").text(parseInt($("#sumresult").text()) + parseInt($("#deliver").text()));
         });
         
         // 특정 체크 박스 변화 이벤트
         $("#check" + index).change(function() {
           // alert(sum);
            // 특정 체크박스의 체크가 true 일때!
            
            if ($(this).is(":checked")==true) {
               sum += parseInt($("#oneresult"+index).text());
               $("#sumresult").text(sum);
            }
            else{
               //alert("saz"+sum);
               sum -= parseInt($("#oneresult"+index).text());
               $("#sumresult").text(sum);
               //alert("ss"+sum);
            }
            
            if(parseInt($("#sumresult").text()) >= 300000){
               $("#deliver").text("0");
            }
            else{
               $("#deliver").text("2500");
            }
            //alert("dd"+sum);
            $("#totalsum").text(parseInt($("#sumresult").text()) + parseInt($("#deliver").text()));
         });

         $("#colorselec"+index).change(function() {
            var cnt2 = 0;
            for(var i=0; i<arrcheck; i++){
               if(($("#colors"+i).text()==$(this).val())&&($("#proid"+i).text() == $("#proid"+index).text()))
               {
                  cnt2 = cnt2+1;   
               }
            }
            if(cnt2 == 1){
               alert("해당 상품의 옵션은 이미 장바구니에 존재합니다. 수량을 변경해주세요!")
            }
            else{
               var seq = $("#numtext"+index).val();
               var viewcolor = $("#colors"+index);
               
               $.ajax({
                      url:"<%= ctxPath%>/mypage/selectcolor.sg",
                      data:{"hiddencolor":$(this).val(),
                           "hiddenseq":seq},   // data는 위의 url로 전송해야할 데이터를 말한다. 
                      type:"post", 
                      dataType:"json",   // 자바스크립트 표준 객체 표기법으로 data type은 uri로부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
                      success:function(data) {
                         //alert(data.color);
                         $("#colors"+index).text(data.color);
                      },
                      error: function(request, status, error){
                           alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                        }
                   }); 
            }
         });
      });
      

      
      $("#allcheck").change(function() {
       
         // 특정 체크박스의 체크가 true 일때!
         if ($(this).is(":checked")==true) {
            $("#allcheck").val("no");
            $("input.checkclass").prop("checked", true);
            sum = 0;
            $("input.checkclass").each(function(index, item) {
               sum += parseInt($("#oneresult"+index).text());
            });
/* 
            $("input.checkclass").each(function(index, item) {
               $("#check" + index).change(function() {
                  if ($(this).is(":checked")==false) {
                    // alert("dd");
                     sum = sum - parseInt($("#oneresult"+index).text());
                  }
               });
            }); */
            $("input.checkclass").each(function(index, item) {
                $("#check" + index).change(function() {
                   if ($(this).is(":checked")==false) {
                	   $("#allcheck").prop("checked", false);
                   }
                });
            });
            
            $("#sumresult").text(sum);
            if(parseInt($("#sumresult").text()) >= 300000){
                $("#deliver").text("0");
             }
             else{
                $("#deliver").text("2500");
             }
            $("#totalsum").text(parseInt($("#sumresult").text()) + parseInt($("#deliver").text()));
         }
         else{
        	 $("input.checkclass").prop("checked", false);
        	 $("#totalsum").text("0");
        	 $("#deliver").text("0");
        	 $("#sumresult").text("0");
        	 sum = 0;
        	 
         }
      });
      
   });/////////////document.ready... .......
   
   function goCancel() {
      var seqcart = "";
      var arrcheck = $("input.checkclass");
      arrcheck.each(function(index, item){
         if($("#check" + index).is(":checked")==true){
            seqcart += $("#seqcart"+index).val();
            if(arrcheck.length-1 > index){
               seqcart+= ",";
            }
         }
      });
      location.href="/Logitech/mypage/ordercart.sg?seqcart="+seqcart;
      alert("선택하신 상품이 장바구니에서 삭제되었습니다.");
      location.reload();
   }
   
   function selectOrder() {
	   
   }
</script>

<div class="container">
   <div id="title">SHOPPING CART</div>
   <div>
      <table>
         <tr id="titlehead">
            <td><span>전체선택&nbsp;</span><input type="checkbox" id="allcheck" value="ok"></td>
            <td>이미지</td>
            <td class="info">상품정보</td>
            <td>판매가</td>
            <td>수량</td>
            <td>합계</td>
         </tr>
         <c:forEach var="pvo" items="${cartprolist}" varStatus="status">
            <tr id="titlehead2">
               <td><input type="checkbox" id="check${status.index}"
                  class="checkclass"></td>
               <td><img src="${pvo.imgfilename}" /></td>
               <td class="info"><span><span id="proid${status.index}">${pvo.pcvo.fk_productid}</span><br />
                     ${pvo.productname}
               </span> <br> <span>[옵션:<span id="colors${status.index}">${pvo.pcvo.selectcolor}</span>]</span> <br> <br>
                  <form id="colorform${status.index}" method="post" action="ordercart.sg">
                     <input type="text" id="colortext${status.index}" name="hiddencolor" hidden="true"/>
                     <input type="text" id="numtext${status.index}" name="hiddennum" hidden="true" value="${pvo.pcvo.sq_cart}"/>
                     <input type="text" id="seqcart${status.index}" value="${pvo.pcvo.sq_cart}" hidden="true"/>
                     <select name="selectcolor" id="colorselec${status.index}"
                        class="inputhidden">
                        <option value="none">옵션변경</option>
                        <c:forEach var="list" items="${colorlist.get(status.index)}">
                           <option value="${list}">${list}</option>
                        </c:forEach>
                     </select>
                  </form></td>
               <td id="price${status.index}">${pvo.pcvo.price}</td>
               <td><input type="number" name="favnum"
                  id="numinput${status.index}" min="1" max="10" value="1"><br>
               <br>
                  <button type="button" id="numchange${status.index}" class="numcl">변경</button>
               </td>
               <td id="oneresult${status.index}"></td>
            </tr>
         </c:forEach>
      </table>
      <hr>
   </div>
   <hr>

   <div>
      <span id="span3">선택상품을
         <button type="button" onClick="goCancel();" >x 삭제하기</button>
      </span>
      <hr>
   </div>

   <div class="navbar-fixed-bottom" id="fixdiv">
      <table>
         <tr id="tr3">
            <td>총 상품금액</td>
            <td>총 배송비</td>
            <td><span class="span4">결제예정금액</span></td>
         </tr>
         <tr id="trnumber">
            <td id="sumresult">0</td>
            <td id="deliver">0</td>
            <td><span class="span4" id="totalsum">0</span></td>
         </tr>

      </table>
   </div>
   <br>
   <div>
      <li id="finalbtn">
         <button type="button" onclick="allOrder">전체상품주문</button>
         <button type="button" onclick="selectOrder">선택상품주문</button>
         <button type="button">쇼핑계속하기</button>
      </li>
   </div>
   <br>
   <br>
   <br>
</div>

<jsp:include page="../footer.jsp" />



















