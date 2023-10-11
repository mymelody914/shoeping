<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/cartStyle.css">
<script src="/resources/js/cartJs.js"></script>
<script type="text/javascript">



////////////////////////////////////////// 최종금액 계산 스크립트
// 문서가 로드될 때 실행
$(document).ready(function() {
  // Total Price를 계산하고 업데이트
  calculateTotalPrice();

  // 수량 변경 버튼 클릭 이벤트 처리
  $(".decrease, .increase").click(function() {
    // Total Price를 다시 계산하고 업데이트
    calculateTotalPrice();
  });
});

var total = 0; // total 변수를 전역 범위에서 선언

function calculateTotalPrice() {
  total = 0; // calculateTotalPrice 함수 내에서 total 변수를 초기화
  $(".totalPrice strong").each(function() {
    total += parseInt($(this).text());
  });

  
  
  // totalPrice , 찍기 
  total = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  // Total Price 업데이트
  $("#totalPrice").text("Total Price: " + total);


		$("#buyCart").click(function(){
			if(total != 0){
			total = total.replace(/,/g, ''); // 쉼표(,)를 모두 제거합니다.
			location="/buy/buyCart.do?totalPrice="+total;
			}else{
				alert("구매할 상품이 없습니다.");	
				return false;
					
				}
		});

}
// --------------------------------------- 리스트 합계 , 찍기 
$(document).ready(function() {
    $('.totalPrice ').each(function() {
        var rawValue = $(this).text().trim();
        var formattedValue = parseFloat(rawValue).toLocaleString('en-US');
        $(this).html('<strong>' + formattedValue + '</strong>');
    });
});


</script>
<style>
.btn-group {
    display: flex; /* 가로 정렬을 위해 flexbox를 사용합니다. */
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: space-between; /* 버튼과 입력 필드 사이에 공간을 만듭니다. */
}

.btn {
    flex: 1; /* 각 버튼과 입력 필드가 동일한 너비를 가지도록 설정합니다. */
    text-align: center; /* 텍스트 중앙 정렬 */
}

.quantity {
    width: 50px; /* 입력 필드의 기본 너비를 설정합니다. 필요에 따라 조정할 수 있습니다. */
}
.imgDiv:hover{
	cursor: pointer;
}
.pStyle {
   color: #444444;
   font-weight: bold;
   font-size: 17px;
   margin-bottom: 10px;
   margin: 10px 0px 10px 20px;
}

</style>
<script type="text/javascript">
$(function(){
	$(".imgDiv").click(function(){
		let itemNo = $(this).data("no");
		location="/item/view.do?itemNo="+itemNo;
	});
});




</script>
</head>
<body>
<div class="row"> 
<div class="col-md-2" >
  <p class="pStyle" >쇼핑 정보</p>
         <div style="margin-left: 20px;">
            <p>
               <a href="/member/view.do">마이페이지</a>
            </p>
            <p>
               <a href="/buy/list.do">구매내역</a>
            </p>
            <p>
               <a href="/wishList/list.do">관심상품</a>
            </p>
            <p>
               <a href="/cart/list.do">장바구니</a>
            </p>
         </div>
</div>
<div class="col-md-8" style="">
<h1 style="text-align: center;">MY CART</h1><br>

<div id="row" style="">
<c:if test="${empty list }">장바구니에 상품이 없습니다.</c:if>
    <c:forEach items="${list}" var="vo" varStatus="vs">
    
        <div class="dataRow" data-no="${vo.itemNo}"  style="margin-left:-10%; margin-right:30%  ">
    <div class="thumbnail" style=" display: flex; position: relative;">
        <!-- X 버튼을 추가합니다. -->
        
        <button class="closeButton" data-no="${vo.cartNo }">×</button>

        <div class="imgDiv" data-no="${vo.itemNo}" >
           <div style="width: 200px; height: 217px; overflow: hidden;">
               <img src="${vo.fileName}" style="width:100%;">
           </div>
        </div>
        <div class="itemInfo" style="margin-left: 20px;">
            <div class="itemName"><h2>${vo.itemName}</h2></div>
            <div class="itemPrice">Product Price : ${vo.itemPrice}</div>
            <div class="brand">Brand : ${vo.brand}</div>
            <div class="color">Color : ${vo.color}</div>
            <div class="sizes">Size : ${vo.buysize}</div>
           수량 : 
            <!-- 수량 변경버튼 -->
            <div class="btn-group">
                <button type="button" class="btn btn-default decrease">-</button>
                <input class="btn btn-default quantity" readonly value="${vo.quantity}">
                <button type="button" class="btn btn-default increase">+</button> 
            </div>
            <!-- 수량변경 마지막 -->
            <div class="itemTotalPrice">
                합계 : <span class="totalPrice"><strong>${vo.itemPrice * vo.quantity}</strong></span>
            </div>
        </div>
    </div>
</div>

    </c:forEach>
    <h2 id="totalPrice"></h2><br><br>
</div>



<div class="back">
    <div class="button_base b03_skewed_slide_in">
        <div >Buy Products</div>
        <div></div>
        <div id="buyCart">Go Buy</div>
    </div>
</div>
</div>
<div class="col-md-2"></div>


</div>






</body>
</html>