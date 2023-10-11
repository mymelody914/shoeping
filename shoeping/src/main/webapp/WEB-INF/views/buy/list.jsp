<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
tr, td {
/*    	border: 1px solid;    */
	font-size : 15px;
}
th {
	font-weight : bold;
	text-align: center;
}
.pStyle {
   color: #444444;
   font-weight: bold;
   font-size: 17px;
   margin-bottom: 10px;
   margin: 10px 0px 10px 20px;
}
</style>

</head>
<body>
	<div class="row">
	<div class="col-md-2" id="boardList">
		   <p class="pStyle">쇼핑 정보</p>
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
      <div class="col-md-8" style="padding: 0%;">
      	
      	<div class="thumbnail" style="padding: 2%; background-color: rgba( 200, 200, 200 , 0.2 );">
      	<c:forEach  items="${list }" var="vo">
      		<div class="thumbnail" style="margin: 1%;">
      		<table style="width: 100%; padding: 1%;">
      			<tr>
      				<td colspan="2" style="padding-left: 1%;"><span style="font-weight: bold; color: gray;">${vo.status }</span></td>
      			</tr>
      			<tr style="height: 190px; overflow: hidden;">
      				<td style="width : 200px; height: 200px;">
      					<div style="height : 200px; width : 200px; overflow: hidden;">
			                 <img alt="${vo.fileName }" src="${vo.fileName }" data-pr="${fileVO.pr }" style="width: 100%" data-fno="${fileVO.imageNo }">
      					</div>
      				</td>
      				<td style="height: 200px; width: 100%;">
      					<table style="width: 98%; height: 100%; margin-right: 3%;">
      						<div style="display: none;">${vo.itemNo }</div>
      						<tr>
      							<td colspan="2" style="padding-left: 2%; padding-right: 2%; padding-bottom: 1%;">
      								<div style="font-weight: bold; color: gray;">${vo.buyDate }</div>
									<div style="font-weight: bold; font-size: 20px; margin-bottom: 4%;">${vo.itemName }</div>
      								<div>색상 : ${vo.buyColor }</div>
      								<div>사이즈 : ${vo.buySize }</div>
      								<div>수량 : <span class="quantity">${vo.quantity }</span></div>
      								<div>가격 : ￦<fmt:formatNumber type="number" maxFractionDigits="3" value="${vo.buyPrice }" /></div>
      								
      							</td>
      						</tr>
      						<tr>
      							<td style="width: 50%; padding-left: 2%;">
				                	<a href="/review/write.do?id=${login.id}" class="btn btn-default btn-block cartBtn" id="insertCart">리뷰작성</a>
				                </td>
				                <td style="width: 50%;">
				                	<a href="/item/view.do?itemNo=${vo.itemNo}" class="btn btn-default btn-block buyBtn" id="buyDirect">재구매</a>
				                </td>
      						</tr>
      					</table>
      				</td>
      			</tr>
      		</table>
      	</div>
      	</c:forEach>
      	</div>
      </div>
	<div class="col-md-2" id="boardList"></div>
	</div>
	<div style="text-align: center;">
      <pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/>
	</div>
</body>
</html>