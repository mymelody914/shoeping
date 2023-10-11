6<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>

<style type="text/css">

.thumbnail {
   padding: 1%;
}

table {
   width: 103%;
   height: 100%;
}

.tdlabel {
   color: black;
    font-weight: bold;
    font-size: 15px;
}

.sizeBtn {
   margin-top: 3px;
}

td {
/*           border: 1px solid black; */
   padding: 1%;
   
}

input {
   width: 100%;
   color: black;
     font-size: 15px;
     padding: 1%;
}

select {
   font-size: 15px;
   padding: 1%;
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


.row {
   padding: 5px;
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
         let imageNo = $("#bigImage").data("fno");
         alert("이미지 변경. imageNo = " + imageNo);
         $("#changeFno").val(imageNo);
         $("#deleteFileName").val($("#bigImage").attr("src"));
         $("#changeImage").val(""); // 선택한 파일은 없앤다.
      });

      // 이미지 삭제
      $("#deleteImageBtn").click(function(){
         // alert("이미지 삭제 버튼");
         if(confirm("이미지를 정말 삭제하시겠습니까?")){
            alert("이미지 삭제 처리");
            let imageNo = $("#bigImage").data("fno");
            let deleteFile = $("#bigImage").attr("src");
            alert(imageNo);
            alert(deleteFile);
            // alert("fno = " + fno + ", deleteFile = " + deleteFile);
            location = "deleteImage.do?imageNo=" + imageNo
               + "&deleteFile=" + deleteFile
               // encodeURI : 한글등 encode한다. 단, 특수문자(= , & 등)는 제외한다.
               // encodeURIComponent : 한글, 특수문자(= , & 등) 등을 encode한다.
               + "&query=" + encodeURIComponent("<%= request.getQueryString()%>");
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
   
   
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 사이즈 버튼  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
 <script>
 $(function () {
       var selectedSizes = []; // 선택한 사이즈를 저장할 배열

       $(".sizeBtn").click(function () {
           var selectSize = parseInt($(this).text()); // 선택한 사이즈를 숫자로 변환
           var index = selectedSizes.indexOf(selectSize);

        // 배열에서 선택한 사이즈의 인덱스를 찾습니다.
           if (index !== -1) {
              // 이미 선택된 사이즈인 경우 제거합니다.
               selectedSizes.splice(index, 1);
               $(this).css("background-color", ""); // 배경 색상 초기화
           } else {
              // 선택되지 않은 사이즈인 경우 추가합니다.
               selectedSizes.push(selectSize);
               $(this).css("background-color", "#dddddd"); // 배경 색상 변경
           }
           
           // 배열을 숫자 크기로 정렬합니다.
           selectedSizes.sort(function (a, b) {
               return a - b;
           });

          // 배열을 "/"로 연결하여 업데이트된 값을 입력란에 설정합니다.
           var currentSize = selectedSizes.join("/");
           $(".sizes").val(currentSize);
       });
		$("#brand").val("${vo.brand}").attr("selected","selected");
		$("#category").val("${vo.category}").attr("selected","selected");
   });
</script>

</head>
<body>
<div class="row" style="margin-bottom: 0%; padding-bottom: 0%;">
      <div class="col-md-2" id="boardList"></div>
      <div class="col-md-8 thumbnail" style="margin-bottom: 0%;">
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메인 상품 이미지  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
         <div class="col-md-5 mainStatus">
         <!-- 큰 이미지 표시 -->
         <img class="img-rounded" id="bigImage" alt="Lights" style="width:100%">
            <!-- 작은 이미지 표시 -->
            <div class="subImage">
         <div class="row" id="imageListDiv">
            <c:forEach items="${fileList }" var="fileVO">
              <div class="col-xs-1 imgDiv img-rounded" style="padding: 5px 3px 3px 3px">
                 <img alt="${fileVO.fileName }" src="${fileVO.fileName }" data-pr="${fileVO.pr }"
                 style="width: 100%" data-fno="${fileVO.imageNo }">
              </div>
            </c:forEach>
            </div>
         </div>
         </div>
         
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메인 상품 정보 페이지 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
      <div class="col-md-7">
      <form action="update.do" method="post">
      	
		<input class="itemNo" name="itemNo" type="hidden" value="${vo.itemNo }" readonly="readonly">      	
         <table>
            <tr>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 상품명  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
               <td class="tdlabel">상품명 :</td>
               <td colspan="2"><input class="itemName pull-right" name="itemName" type="text" value="${vo.itemName }"></td>
            </tr>
            <tr>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 카테고리 선택 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
                 <td class="tdlabel">카테고리 :</td>
               <td>
                 <select class="category" name="category" id="category" style="width: 100%;">
                    <c:forEach items="${c_list }" var="c_vo">
                       <option>${c_vo.category }</option>
                    </c:forEach>
                 </select>
               </td>
            </tr>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 브랜드 선택 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
            <tr>
                  <td class="tdlabel">브랜드 :</td>
               <td>
                 <select class="brand" name="brand" id="brand" style="width: 100%;">
                    <c:forEach items="${b_list }" var="b_vo">
                       <option>${b_vo.brand }</option>
                    </c:forEach>
                 </select>
               </td>
            </tr>
            <tr>
               <td class="tdlabel">가격 :</td>
               <td>
                  <input class="itemPrice pull-right" name="itemPrice" type="text" value="${vo.itemPrice }">
               </td>
            </tr>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 색상 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
            <tr>
               <td class="tdlabel">색상 :</td>
               <td>
               <input class="colors pull-right" name="colors" type="text" value="${vo.colors }">
               </td>
            </tr>
            <tr>
               <td></td>
               <td><span style="color: red;">*색상 입력 예시 : 화이트/블랙/레드/블루</span></td>
            </tr>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 사이즈  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
            <tr>
               <td class="tdlabel">사이즈 :</td>
               <td>
               <input class="sizes pull-right" name="sizes" type="text" readonly="readonly" value="${vo.sizes }" id="sizeInput">
               </td>
            </tr>
            <tr>
               <td colspan="2">
                  <div class="row" style="margin-right: 1%; text-align: right;">
                    <div>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(200)">200</button >
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(210)">210</button >
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(220)">220</button >
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(230)">230</button >
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(235)">235</button >
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(240)">240</button >
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(245)">245</button >
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(250)">250</button >
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(255)">255</button >
                    </div>
                    <div>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(260)">260</button>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(265)">265</button>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(270)">270</button>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(275)">275</button>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(280)">280</button>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(285)">285</button>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(290)">290</button>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(295)">295</button>
                        <button type="button" class="sizeBtn btn btn-default" onclick="addNumber(300)">300</button>
                    </div>
                    </div>
               </td>
            </tr>
            <tr>
               <td colspan="2">
               <button class="btn btn-block btn-lg" style="background: #dddddd">상품수정</button>
               </td>
            </tr>
         </table>
	  </form>
      </div> <!-- end col-md-7 -->
      </div>  <!-- 중심 /div -->
      <div class="col-md-2" id="qnaList"></div>
</div> <!-- end class.row -->
</body>
</html>