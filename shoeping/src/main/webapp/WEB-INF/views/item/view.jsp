<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>

<style type="text/css">
table {
	width: 100%;
	height: 100%;
}

td {
	/*     border: 1px solid black; */
	padding-top: 5px;
	padding-bottom: 5px;
}

.overlay-image {
	position: absolute; /* 겹치는 이미지의 위치 설정 */
	z-index: 1; /* 겹치는 이미지가 위에 표시되도록 설정 */
}

.mainStatus {
	padding: 10px;
}

.subImage {
	margin-left: 10px;
	margin-top: 1px;
	margin-bottom: 10px;
}

.selectedtable {
	width: 100%;
	height: 100%;
}

* /

.minus {
	margin: 5px;
}

.plus {
	margin: 5px;
}

.row {
	padding: 5px;
}

<!--
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 상세 페이지 메뉴  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->.font
	{
	color: #939393;
	font-weight: bold;
	font-size: 15px;
}

.detailTd {
	width: 50px;
	color: black;
}

body {
	position: relative;
}

#section1 {
	color: black;
}

#section2 {
	padding-top: 20px;
	color: black;
}

#section3 {
	padding-top: 20px;
	color: black;
}

#section4 {
	padding-top: 20px;
	color: black;
}
</style>


<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 상품 이미지 스크립트  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
<script type="text/javascript">
   // 파라메터로 넘어가는 showImage 변수는 img 태그이다.
   function showImage(showImage){
      let alt = showImage.attr("alt");
      let src = showImage.attr("src");
      $("#bigImage").attr("alt", alt).attr("src", src);
      // 작은 이미지 fno -> 큰 이미지의 fno
      $("#bigImage").data("fno", showImage.data("fno"));
      // download를 위해서 a href에도 넣준다.
      $("#imageDownload").attr("href", src);
      $("#imageListDiv").find("img").css("opacity", 1);
      showImage.css("opacity", 0.5);

      // 이미지 바꾸기 폼 사라지게 한다.
      $("#changeImageDiv").slideUp();

      // 주이미지인 경우에는 삭제 버튼은 없앤다. -> 내가 작성한 이미지에서만 동작이 된다.
      if(showImage.data("pr") == 1) $("#deleteImageBtn").hide();
      else $("#deleteImageBtn").show();
      
   }
   
   $(function(){

      // 작은 이미지 비율 조정
      resize();
      
      // 큰이미지에 메인 이미지를 보이게 한다.
      showImage($("#imageListDiv").find("img:first"));
      // 이미지 삭제 버튼은 안보이게 한다.
      $("#deleteImageBtn").hide();

      // 이벤트 처리
      
      // 브라우저의 창의 사이즈가 조정이 되면 이미지 높이도 다시 계산되서 표시되어야한다.
      $(window).resize(function(){
         // 이미지의 표시 사이즈 지정 처리
         resize();
      });
      
      $("#deleteBtn").click(function(){
         if(!confirm("정말 삭제하시겠습니까?")) return false;
      });

      // 작은 이미지 div를 클릭하면 큰 이미지에 보여야 한다.
      $("#imageListDiv > div").click(function(){
         showImage($(this).find("img"));
      });

      // 이미지 변경
      $("#changeImageBtn").click(function(){
         let fno = $("#bigImage").data("fno");
         // alert("이미지 변경. fno = " + fno);
         $("#changeFno").val(fno);F
         $("#deleteFileName").val($("#bigImage").attr("src"));
         $("#changeImageDiv").slideToggle(); // 수정 div는 사라지게 한다.
         $("#changeImage").val(""); // 선택한 파일은 없앤다.
      });

      // 이미지 삭제
      $("#deleteImageBtn").click(function(){
         // alert("이미지 삭제 버튼");
         if(confirm("이미지를 정말 삭제하시겠습니까?")){
            // alert("이미지 삭제 처리");
            let fno = $("#bigImage").data("fno");
            let deleteFile = $("#bigImage").attr("src");
            // alert("fno = " + fno + ", deleteFile = " + deleteFile);
            location = "deleteImage.do?imageNo=" + imageNo
               + "&deleteFile=" + deleteFile
               // encodeURI : 한글등 encode한다. 단, 특수문자(= , & 등)는 제외한다.
               // encodeURIComponent : 한글, 특수문자(= , & 등) 등을 encode한다.
               + "&query=" + encodeURIComponent("<%=request.getQueryString()%>");
               ;
         }
      });
   });

   // 이미지의 높이를 처리하는 함수.
   function resize(){
      // 이미지의 너비를 구해보자.
      // select "a b" --> a안에 있는 b 객체를 선택. :first - 처음 것 --> .first()
      let width = $("#imageListDiv .imgDiv:first").width();
      // alert(width);
      let height = width / 3 * 2.4;
      $("#imageListDiv .imgDiv").height(height + "px");
   }
   </script>


<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 색상 & 사이즈 선택 스크립트  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
<script type="text/javascript">
    $(function(){
        // 초기 변수 설정
         let selectedColor = "옵션 선택"; // 선택된 색상 초기화
         let selectedSize = "옵션 선택"; // 선택된 사이즈 초기화
         var totalPrice = parseFloat($(".itemPrice").text()); // 총 가격 초기화

         // 가격 설정
         itemPrice = parseFloat($(".itemPrice").text());

         // 색상 설정
         $(".colorBtn").click(function() {
             selectedColor = $(this).text(); // 선택된 색상 저장
             $(".cOption").text(selectedColor); // 선택된 색상 출력
             $(".colorCheck").text(selectedColor); // 선택된 색상 출력
             
         });

         // 사이즈 설정
         $(".sizeBtn").click(function() {
             if (selectedColor !== "옵션 선택") {
                 selectedSize = $(this).text(); // 선택된 사이즈 저장
                   $(".sizeCheck").text(selectedSize); // 선택된 색상 출력
                 itemPrice = parseFloat($(".itemPrice").text()); // 상품 가격 가져오기
               
                 // 선택된 상품 정보 출력
                 selectedTable = $(".selectedtable");
                 $(".Price").text(itemPrice); // 선택된 색상 출력
                 $(".selectedtable").show();

                // 선택 상품 출력 후 초기화
//                  selectedColor = "옵션 선택";
//                  selectedSize = "옵션 선택";
                  defaultQuantity = 1;
                 $(".cOption").text(selectedColor);
                 $(".sOption").text(selectedSize);
                 $(".quantity").text(1);
             } else {
                 alert("색상을 먼저 선택해주세요!");
             }
         });
// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 수량 설정 버튼  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
         $(function(){
            $("#plus").click(function(){
                let quantity = parseInt($("#quantity").text());
                $("#quantity").text(quantity + 1);
                let totalQuantity = parseInt($("#quantity").text());
                totalPrice = itemPrice * totalQuantity;
                $(".Price").text(totalPrice + "원");
            });

            $("#minus").click(function(){
                let quantity = parseInt($("#quantity").text());
                if (quantity > 1) { // 현재 수량이 1 이상일 때만 감소하도록 조건 추가
                    $("#quantity").text(quantity - 1);
                    let totalQuantity = parseInt($("#quantity").text());
                    totalPrice = itemPrice * totalQuantity;
                    $(".Price").text(totalPrice + "원");
                }
            });
        });
// ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 카트 버튼  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
         $(".cartBtn").click(function(){
//            alert(selectedColor);
			if(${login != null}){
				if(selectedSize !== "옵션 선택") {
           let imgNo = $("#imgNo").data("no");
           let fileName = $("#imgName").data("bayaba");
           let buyquantity = parseInt($("#quantity").text());
//            alert(buyquantity);
           
           location = "/cart/insertCart.do?color=" + selectedColor + "&size=" + selectedSize + "&itemNo=" + ${vo.itemNo} + "&imageNo="+imgNo +
           "&quantity=" + buyquantity;
           alert("장바구니에 추가되었습니다.");
					} else {
				alert("옵션을 먼저 선택해 주세요. ");
				return false;
						 }
			}else{
				alert("로그인이 필요한 서비스 입니다.");
				return false;
			}
			           });

         $(".buyBtn").click(function(){
        	 if(${login != null}){
        		 if(selectedSize !== "옵션 선택") {
             let totalQuantity = parseInt($("#quantity").text());
             let fileName = $("#imgName").data("bayaba");
//              alert(fileName);
             
             location = "/buy/buyDirect.do?color=" + selectedColor + "&size=" + selectedSize + "&itemNo=" + ${vo.itemNo} +
             "&quantity=" + totalQuantity + "&totalPrice=" + totalPrice + "&fileName=" + fileName
        		 } else {
       			alert("옵션을 먼저 선택해 주세요. ");
  				return false;
            		 }
	         }else{
	        		alert("로그인이 필요한 서비스 입니다.");
	        		return false;
	        	}
             });
       });
</script>


<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 카트 버튼  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
<script type="text/javascript">
$(function(){
   
   $(".like").click(function(){
	   if(${login!=null}){
      let imgNo = $("#imgNo").data("no");
      let itemNo = $("#imageData").data('itemno');
      
        // Perform an AJAX request to your controller
        $.ajax({
            type: 'POST', // or 'GET' depending on your controller
            url: "/wishListAjax/insertWishList.do",
            data: { itemNo: itemNo , 
                  imgNo: imgNo
                  
            }, // Send data to the controller if needed
            success: function(response) {
                location.reload();
                
            },
            error: function(xhr, status, error) {
                // Handle the error here
            }
        });
	  }else{
		 alert("로그인 후 이용가능합니다.");
		 return false;
		 
	  }
   });
});

</script>


</head>
<body>
	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 상단 버튼 & 이벤트 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
	<div class="row" style="margin-bottom: 0%; padding-bottom: 0%;">
		<div class="col-md-2" id="boardList"></div>
		<div class="col-md-8" style="padding: 0%;">

			<!-- 이미지 변경 Modal -->
			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog">
					<form action="changeImage.do" method="post"
						enctype="multipart/form-data">
						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">이미지 바꾸기</h4>
							</div>
							<div class="modal-body">
								<input type="hidden" name="query"
									value="<%=request.getQueryString()%>" id="query"> <input
									type="hidden" name="imageNo" id="changeFno"> <input
									type="hidden" name="deleteFileName" id="deleteFileName">
								<input name="changeImage" type="file" class="form-control"
									id="changeImage" required>
							</div>
							<div class="modal-footer">
								<button class="btn btn-default changeBtn">바꾸기</button>
							</div>
						</div>
					</form>
				</div>
			</div>

			<!-- 삭제 Modal -->
			<div class="modal fade" id="delete" role="dialog"
				style="border-color: red;">
				<div class="modal-dialog" style="border-color: red;">
					<form action="delete.do" method="post">
						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header"
								style="border-color: red; text-align: center;">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title" style="font-weight: bold; color: red;">상품을
									삭제 하시겠습니까?</h4>
							</div>
							<div class="modal-body"
								style="text-align: center; font-weight: bold;">
								<input class="itemNo" name="itemNo" type="hidden"
									value="${vo.itemNo }" readonly="readonly">
								<div style="font-size: 15px;">상품명 : ${vo.itemName }</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btndefault"
									data-dismiss="modal">취소</button>
								<button class="btn btn-default btn-danger">삭제</button>
							</div>
						</div>
					</form>
				</div>
			</div>


			<c:if test="${!empty login && login.gradeNo == 9}">
				<div style="text-align: center;">
					<div class="btn-group btn-sm pull-left" style="padding: 0%;">
						<button type="button" class="btn btn-default" id="changeImageBtn"
							data-toggle="modal" data-target="#myModal">이미지 바꾸기</button>
						<button type="button" class="btn btn-default" id="deleteImageBtn">이미지
							삭제</button>
					</div>
					<button type="button" class="btn btn-default btn-danger"
						data-toggle="modal" data-target="#delete">!!!상품삭제!!!</button>
					<a
						href="update.do?itemNo=${vo.itemNo }&page=${param.page }&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}"
						class="btn btn-default pull-right">상품수정</a>
				</div>
			</c:if>
		</div>
		<div class="col-md-2" id="boardList"></div>
	</div>
	<!-- end div row -->
	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 넘기는 데이터 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
	<div style="display: none;">
		<c:forEach items="${fileList}" var="item">
			<c:if test="${item.pr == 1}">
				<div id="imgNo" data-no="${item.imageNo}"></div>
				<div id="imgName" data-bayaba="${item.fileName}"></div>
				<br>
                 Filename: ${item.fileName}<br>
                 PR: ${item.pr}<br>
			</c:if>
		</c:forEach>
	</div>

	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 좋아요 버튼 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
	<div class="row" style="margin-bottom: 0%; padding-bottom: 0%;">
		<div class="col-md-2" id="boardList"></div>
		<div class="col-md-8 thumbnail" style="margin-bottom: 0%;">
			<!--          <div class="pull-right"> -->

			<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메인 상품 이미지  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
			<div class="col-md-5 mainStatus">
				<!-- 큰 이미지 표시 -->
				<img class="img-rounded" id="bigImage" alt="Lights"
					style="width: 100%">
				<!-- 작은 이미지 표시 -->
				<div class="subImage">
					<div class="row" id="imageListDiv">
						<c:forEach items="${fileList }" var="fileVO">
							<div class="col-xs-1 imgDiv img-rounded"
								style="padding: 5px 3px 3px 3px">
								<img alt="${fileVO.fileName }" src="${fileVO.fileName }"
									data-pr="${fileVO.pr }" style="width: 100%"
									data-fno="${fileVO.imageNo }">
							</div>
						</c:forEach>
					</div>
				</div>
			</div>

			<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메인 상품 정보 페이지 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
			<div class="col-md-7">
				<input type="hidden" value="${vo.itemNo }">
				<table>
					<tr>
						<td><h2>${vo.itemName }</h2></td>
						<td>
							<div class="pull-right" id="reloadLike">
								<div class="likeDiv" style="margin: 15px; position: relative;">

									<a href="#" class="like"
										style="display: inline-block; float: right; margin-top: -10px; margin-left: 8px;">
										<c:if test="${empty checkWishList}">
											<img src="/resources/assets/images/heartRed.png" width="40"
												height="40" id="imageData" data-itemno="${vo.itemNo }">
										</c:if> <c:if test="${ not empty checkWishList}">
											<img src="/resources/assets/images/heart.png" width="40"
												height="40" id="imageData" data-itemno="${vo.itemNo}">
										</c:if>

									</a>
									<div style="position: relative;">
										<img
											style="width: 25%; display: inline-block; margin-top: -30px; float: right;"
											src="/resources/assets/images/balloon2.png"> <strong
											style="color: gray; position: absolute; display: inline-block; margin-top: -24px; right: 73px;">${wishListNumber }</strong>
									</div>

								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>PRICE</td>
						<td><span class="pull-right"> <fmt:formatNumber type="number" maxFractionDigits="3" value="${vo.itemPrice }" />
								<span class="itemPrice" style="display: none;">${vo.itemPrice }</span>
						</span></td>
					</tr>
					<tr>
						<td>DELVERY</td>
						<td><span class="pull-right">2,500 won (70,000 won 이상
								구매 시 무료)</span></td>
					</tr>
					<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 색상 선택 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
					<tr>
						<td>COLOR</td>
						<td>
							<div class="dropdown pull-right">
								<button class="cOption btn btn-default dropdown-toggle btn-sm"
									type="button" data-toggle="dropdown">
									옵션 선택 <span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<c:forEach items="${colors }" var="color">
										<li class="colorBtn"><a href="#">${color }</a></li>
										<br>
									</c:forEach>
								</ul>
							</div>
						</td>
					</tr>
					<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 사이즈 선택 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
					<tr>
						<td>SIZE</td>
						<td>
							<div class="dropdown pull-right">
								<button class="sOption btn btn-default dropdown-toggle btn-sm"
									type="button" data-toggle="dropdown">
									옵션 선택 <span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<c:forEach items="${sizes }" var="size">
										<li class="sizeBtn"><a href="#">${size }</a></li>
										<br>
									</c:forEach>
								</ul>
							</div>
						</td>
					</tr>
				</table>
				<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 선택 옵션 정보 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
				<div class="selectedtable" style="display: none;">
					<table>
						<tr>
							<td><span class="pull-left">${vo.itemName }</span>
							<td>
							<td><span class="colorCheck pull-left">${selectedColor}</span>,
								<span class="sizeCheck">${selectedSize}</span></td>
							<td>
								<div class="btn-group pull-right">
									<button type="button" class="btn btn-default" id="minus">-</button>
									<button type="button" class="btn btn-default ">
										<span id="quantity">1</span>
									</button>
									<button type="button" class="btn btn-default pull-right"
										id="plus">+</button>
								</div>

							</td>
						</tr>
					</table>
				</div>
				<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 총 가격 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->

				<table>
					<!-- 총금액 -->
					<tr>
						<td style="width: 50%;"><h4>TotalPrice</h4></td>
						<td style="width: 50%;"><h4 class="pull-right Price"></h4></td>
					</tr>
					<tr>
						<td style="width: 50%;"><a
							class="btn btn-default btn-block cartBtn" id="insertCart">CART</a>
						</td>
						<td style="width: 50%;"><a
							class="btn btn-default btn-block buyBtn" id="buyDirect">BUY</a></td>
					</tr>
				</table>
				<!-- end of 구매, 장바구니 버튼 -->
			</div>
		</div>
		<!-- 중심 /div -->
		<div class="col-md-2" id="qnaList"></div>
	</div>
	<!-- end class.row -->


	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 상세 페이지 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
	<div class="row">
		<!-- 상세페이지 -->
		<div class="col-md-2" id="boardList"></div>
		<div class="col-md-8 thumbnail">
			<div class="container-fluid" style="width: 100%;">
				<div>
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#myNavbar">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
				</div>
				<div>
					<div class="collapse navbar-collapse" id="myNavbar"
						style="margin-left: 4%; margin-right: 7%; margin-top: 1%; font-weight: bolder;">
						<table id="detailMenu">
							<tr style="width: 100%;">
								<td class="detailTd"><a href="#section1"
									style="text-align: center;">상세보기</a></td>
								<td class="detailTd"><a href="#section2"
									style="text-align: center;">상품후기</a></td>
								<td class="detailTd"><a href="#section3"
									style="text-align: center;">상품문의</a></td>
								<td class="detailTd"><a href="#section3"
									style="text-align: center;">배송/교환/환불 안내</a></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 세션1 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
			<div id="section1">
				<div class="col-md-12"
					style="padding-left: 3%; padding-right: 3%; padding-top: 1%;">
					<div class="overlay-image">
						<c:if test="${!empty login && login.gradeNo == 9}">
							<button class="btn btn-default" id="changeDetailImageBtn"
								data-toggle="modal" data-target="#changeDetailPageModal">상세이미지
								바꾸기</button>
						</c:if>
					</div>
					<img src="${vo.detailImage }" style="width: 100%">
				</div>

			</div>
			<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 세션2 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
			<!-- 여기 리뷰입니다아아아아아아아아아앙아아 아이템 넘버도 넘겨받을거에요 인클루드입니다!!!!! -->
			<div id="section2">
				<div class="row" >
					<div class="col-md-12" style="padding: 3%;">
						<%@include file="../review/reviewlist.jsp"%>
					</div>
				</div>
			</div>

			<!-- 여기 리뷰입니다아아아아아아아아아앙아아 아이템 넘버도 넘겨받을거에요 인클루드입니다!!!!! -->
			<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 세션3 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
			<div id="section3">
				<div class="row">
					<div class="col-md-12" style="padding: 3%;">
						<%@include file="../question/list.jsp"%>
					</div>
				</div>
			</div>
			<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 세션4 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
			<div id="section4"">
				<h1 style="text-align: center;">배송 / 교환 / 환불 정책</h1>
				<span style="font-size: 15px; text-align: center;"> 단순 변심, 착오
					구매에 따른 교환/반품은 상품을 공급받은 날부터 7일 이내에 가능합니다. (배송비 고객 부담) 단, 일부 제품의 경우
					포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우에는 교환 및 반품이 불가능합니다. (상품 확인을 위하여 포장
					훼손한 경우는 제외) 공급 받으신 상품 내용이 표시, 광고내용과 다르거나 다르게 이행된 경우에는 그 상품을 공급받은
					날부터 3개월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내 청약철회가 가능합니다. (배송비 회사
					부담) 교환 및 반품 신청에는 사유에 따라 배송비 3,000~6,000원이 부과됩니다. 이 때 무료배송 혜택을 받은
					주문일 경우 왕복 금액을, 배송비를 부담하신 경우 편도 금액을 산정하여 환불 금액에서 차감될 수 있습니다. 물품 하자에
					의한 반송을 제외하고 고객변심에 의한 반품, 교환인 경우 배송비는 고객 부담이며(교환 시 6,000원 / 반품 시
					3,000원), 접수 완료일로부터 평일 기준 2~3일 내에 수거가 이루어집니다. 구매수량 단위로 배송비가 부과된 상품은
					교환 및 반품을 희망하실 경우 주문시와 동일하게 구매수량 단위로 회수비를 부과합니다. 반품 시, 상품대금 환불은 상품
					회수 및 청약철회가 확정된 날로부터 3영업일 이내 진행되며, 기한을 초과한 경우 지연 기간에 대하여 「전자상거래 등에서의
					소비자보호에 관한 법률 시행령」 에서 정하는 이율을 곱하여 산정한 지연이자를 지급합니다. 주문취소는 [마이페이지 >
					주문/배송조회] 교환/반품은 [마이페이지 > 반품/교환/환불] 또는 고객센터를 통해 신청하실 수 있습니다. 소비자에게
					책임이 있는 사유로 재화등이 멸실되거나 훼손된 경우(재화의 내용을 확인하기 위하여 포장을 훼손한 경우는 제외) 소비자의
					사용 또는 일부 소비로 재화등의 가치가 현저히 감소한 경우 시간이 지나 다시 판매하기 곤란할 정도로 재화등의 가치가
					현저히 감소한 경우 복제가 가능한 재화등의 포장을 훼손한 경우 소비자의 주문에 따라 개별적으로 생산되는 재화등 또는 이와
					유사한 재화등에 대하여 청약철회등을 인정하는 경우 통신판매업자에게 회복할 수 없는 중대한 피해가 예상되는 경우로서 사전에
					해당 거래에 대하여 별도로 그 사실을 고지하고 소비자의 서면(전자문서 포함)에 의한 동의를 받은 경우 </span>
			</div>

		</div>
		<div class="col-md-2" id="boardList"></div>
	</div>

	<!-- 상세페이지 변경 Modal -->
	<div class="modal fade" id="changeDetailPageModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">상세이미지 바꾸기</h4>
				</div>
				<form action="detailImageChange.do" method="post"
					enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="itemNo" value="${vo.itemNo }">
						<input type="hidden" name="deleteFileName"
							value="${vo.detailImage }"> <input type="hidden"
							name="query" value="<%=request.getQueryString()%>" id="query">
						<input name="changeImage" type="file" class="form-control"
							id="changeImage" required>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default">바꾸기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>