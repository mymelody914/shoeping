<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>위시리스트</title>
    <style type="text/css">
/*         .row { */
/*             margin-left: 13%; /* 왼쪽 공백 크기 조절 */ */
/*             margin-right: 13%; /* 오른쪽 공백 크기 조절 */ */
/*         } */
        .dataRow {
            display: flex;
            margin-bottom: 20px;
        }
        .thumbnail {
            display: flex;
            flex-direction: column; /* 이미지와 productName을 세로로 배치하기 위해 열 방향으로 배치합니다. */
            align-items: center; /* 이미지와 productName을 가운데 정렬합니다. */
            text-align: center; /* 텍스트를 가운데 정렬합니다. */
        }
        .imgDiv {
            width: 50%;
        }
        .productName {
            margin-top: 10px; /* 이미지 아래에 적절한 간격을 주세요. */
        }
        /* X 버튼 스타일 */
.closeButton {
    position: absolute;
    top: 2px; /* 원하는 위치로 조절하세요 */
    right: 2px; /* 원하는 위치로 조절하세요 */
    background-color: transparent;
    border: none;
    font-size: 16px;
    line-height: 1;
    cursor: pointer; 
    color: #000; /* X 아이콘 색상 */
}

.pStyle {
   color: #444444;
   font-weight: bold;
   font-size: 17px;
   margin-bottom: 10px;
   margin: 10px 0px 10px 20px;
}
.dataRow {
    display: flex;
    margin-bottom: 20px;
    width: 200px; /* 원하는 너비로 조절 */
    height: 300px; /* 원하는 높이로 조절 */
}
.imgDiv {
    max-width: 100%; /* 이미지의 최대 너비를 부모 요소에 맞게 조절 */
}
    </style>
    
    <script type="text/javascript">
    $(function(){
    	$(".closeButton").click(function(){
            let wishListNo = $(this).data("no"); // 이 코드는 클로즈 버튼의 data-cart-no 속성을 가져옵니다.
            
    		console.log(wishListNo);
            $.ajax({
                url: "/wishListAjax/deleteWishList.do",
                method: "POST", // 요청 방식 (GET 또는 POST를 선택하세요)
                data: { wishListNo: wishListNo }, // 전송할 데이터
                success: function(response){
                    // AJAX 요청이 성공했을 때 수행할 작업을 여기에 추가하세요
                    console.log("삭제 요청이 성공했습니다.");
                    location.reload();
                    // 여기에서 추가적인 작업을 수행하거나 페이지 리로드 등을 수행할 수 있습니다.
                },
                error: function(xhr, status, error){
                    // AJAX 요청이 실패했을 때 수행할 작업을 여기에 추가하세요
                    console.error("삭제 요청이 실패했습니다. 오류: " + error);
                }
            });
        });
    });
    
    
   
    
    </script>
</head>
<body>
<div class="row" >
<div class="col-md-2">
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
<div class="col-md-8">
    <h1 style="text-align: center;">WISH LIST</h1><br>
    <div class="row" >
        <c:choose>
            <c:when test="${empty list}">
                <!-- Display a message when the wishlist is empty -->
                <p style="text-align: center;">위시리스트가 존재하지 않습니다.</p>
            </c:when>
            <c:otherwise>
                <!-- Display wishlist items when the wishlist is not empty -->
                <c:forEach items="${list}" var="vo" varStatus="vs">
                    <c:if test="vo.index > 0 && vs.index % 4 == 0">
                        <c:out value="<div>" />
                        <c:out value="<div class='row'>" />
                    </c:if>
                    <div class="col-md-3 dataRow">
                        <a href="/item/view.do?itemNo=${vo.itemNo }" style="color:black;">
                            <div class="thumbnail" style="display: flex; position: relative;">
                                <button class="closeButton" data-no="${vo.wishListNo}">x</button>
                                <div class="imgDiv" style="width: 50%">
                                    <img src="${vo.fileName}" style="width: 100%">
                                </div>
                                <div class="productName">Product : ${vo.itemName}</div>
                                <div class="productDetails">
                                    <div class="brand">${vo.brand}</div>
                                    <div class="price">Price : <span class="itemPrice">${vo.itemPrice}</span></div>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    </div>
    <div class="col-md-2"></div>
</div>
</body>

</html>
