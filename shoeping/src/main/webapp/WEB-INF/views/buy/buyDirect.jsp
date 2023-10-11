<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카트 구매 페이지</title>
<style type="text/css">
thumbnail {
	padding: 10px;
}
table {
	border: 3px solid white;
}
th {
	font-size: 15px;
    font-weight: bold;
    padding-top: 5px;
    padding-bottom: 5px;
}
tr,td {
background-color: rgba( 200, 200, 200 , 0.2 );
}
ul {
	list-style-type: none;
	margin-top: 5px;
	margin-bottom: 5px;
}
li {
	margin-top: 5px;
	margin-bottom: 5px;
}

.ground {
/* 	background-color: black; */
     background-color: rgba( 220, 220, 220, 0.5 );
}
</style>

<script type="text/javascript">
$(function(){
    let itemNoCount = $(".itemNo").length;
    console.log("itemNoCount: " + itemNoCount);
    $("input.count").val(itemNoCount);

})
</script>

</head>
<body>
	<div class="row">
		<div class="col-md-2" id="boardList"></div>
      	<div class="col-md-8 thumbnail ground" style="padding: 1%;">
      	<h3 style="margin-top: 1%; margin-bottom: 1%;">주문/결제</h3> 
		
      	
				<table class="table-striped" style="width: 100%;">
					<tr>
						<th style="width: 150px;"></th>
						<th style="width: 300px;">상품정보</th>
						<th style="width: 150px;">배송비</th>
						<th style="width: 150px;">수량</th>
						<th style="width: 150px;">금액</th>
					</tr>
					
						<tr class="dataRow">
							<td> <!-- 상품이미지 -->
								<div class="imgDiv" style="text-align: center;">
									<img src="${param.fileName}" style="height: 150px;">
								</div>
							</td>
							
							<td> <!-- 출력 상품정보 -->
								<div><h4>${vo.itemName}</h4></div>
					            <div>Brand : ${vo.brand}</div>
					            <div>Color : ${param.color}</div>
					            <div>Size : ${param.size}</div>
							</td>
							<td> <div>공짜</d iv></td> <!-- 배송비 -->
							<td><div>${param.quantity}</div></td> <!-- 수량 -->
							<td><div>₩<fmt:formatNumber type="number" maxFractionDigits="3" value="${vo.itemPrice }" /></div></td> <!-- 금액 -->
						</tr>
							<td colspan="5" style="padding: 1%">
								<div class="pull-right" style="font: bold; font-size: 20px;">
								Total : <span>₩<fmt:formatNumber type="number" maxFractionDigits="3" value="${param.totalPrice }"/></span>
								</div>
							</td>
						</tr>
				</table>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 상단 버튼 & 이벤트 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
				<div class="thumbnail" style="margin-top: 1%; margin-bottom: 1%;">
					<ul>
						<li><h4 style="font-weight: bold;">배송지 정보</h4></li>
						<li>${member.id }</li>
						<li>${member.phone }</li>
						<li>${member.address }</li>
					</ul>
					
				<!-- 전달할 상품 데이터 -->
				<form action="buyDirect.do" method="post" varStatus="vs">
					<input class="id" name="memberId" type="hidden" value="${member.id }" readonly="readonly">
					<input class="id" name="name" type="hidden" value="${member.id }" readonly="readonly">
					<input class="tel" name="tel" type="hidden" value="${member.phone }" readonly="readonly">
					<input class="address" name="Address" type="hidden" value="${member.address }" readonly="readonly">
					<input class="totalPrice" name="totalPrice" type="hidden" value="${param.totalPrice }" readonly="readonly">
					<input class="count" name="count" type="hidden" value="${itemNoCount }" readonly="readonly">

					<input class="itemNo" name="itemNo" type="hidden" value="${param.itemNo}" readonly="readonly">
					<input class="color" name="color" type="hidden" value="${param.color}" readonly="readonly">
					<input class="size" name="size" type="hidden" value="${param.size}" readonly="readonly">
					<input class="quantity" name="quantity" type="hidden" value="${param.quantity}" readonly="readonly">
					
					<button class="btn btn-default pull-right btn-lg" style="margin-top: 1%;">결제</button>
				</form>
				
				</div>
				
		</div> <!-- end col-md-8 -->
	    </div> 
		<div class="col-md-2" id="boardList"></div>
	</div>
</body>
</html>