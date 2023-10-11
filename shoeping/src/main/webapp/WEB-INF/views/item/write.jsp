<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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

</style>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메인 이미지 추가 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
<script>
$(function () {
    function setThumbnail(event) {
        var reader = new FileReader();
        var img = $("<img />");
        var container = $("#image_container");

        reader.onload = function (event) {
            img.attr("src", event.target.result);

            img.on("load", function () {
                var maxWidth = container.width();
                var maxHeight = container.height();
                var width = img.width();
                var height = img.height();
                var ratio = 1;

                if (width > maxWidth || height > maxHeight) {
                    ratio = Math.min(maxWidth / width, maxHeight / height);
                }

                img.css({
                    width: width * ratio + "px",
                    height: height * ratio + "px"
                });
            });

            container.empty(); // 이미지를 새로운 이미지로 대체
            container.append(img);
        };

        reader.readAsDataURL(event.target.files[0]);
    }

    $("#image").change(function (event) {
        setThumbnail(event);
    });
});
</script>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 상세 이미지 추가 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
<script>
$(function () {
    function setDetailThumbnail(event) {
        var reader = new FileReader();
        var img = $("<img />");
        var container = $("#detailImageContainer");

        reader.onload = function (event) {
            img.attr("src", event.target.result);

            img.on("load", function () {
                var maxWidth = container.width();
                var maxHeight = container.height();
                var width = img.width();
                var height = img.height();
                var ratio = 1;

                if (width > maxWidth || height > maxHeight) {
                    ratio = Math.min(maxWidth / width, maxHeight / height);
                }

                img.css({
                    width: width * ratio + "px",
                    height: height * ratio + "px"
                });
            });

            container.empty(); // 이미지를 새로운 이미지로 대체
            container.append(img);
        };

        reader.readAsDataURL(event.target.files[0]);
    }

    $("#detailImage").change(function (event) {
        setDetailThumbnail(event);
    });
});
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
   });
</script>


<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 서브 이미지 추가 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
<script type="text/javascript">
$(function(){
   // 이벤트 처리
   $("#appendImageBtn").click(function(){
      let cnt = $(".imageFile").length;
      // alert("추가 이미지 개수 - " + cnt);
      if(cnt == 5){
         alert("추가 이미지 파일은 5개까지 가능합니다.");
         return;
      }
      let html = "";
      html += "<table class=\"imgBtn\"><tr>"
      html += "<td><button class='removeImageFileBtn btn btn-default btn-xs'>X</button></td>";
      html += "<td><input class=\"imageFile\" name=\"imageFile\" required class=\"form-control\" type=\"file\"></td>";
      html += "</tr></table>"

      // alert(html);
      // appendDiv에 html 뒤에 추가
      // html(data) - html 데이터 바꾸기. text(data) - text 데이터 바꾸기.
      // append(data) - 뒤에 추가하기. preppend(data) - 앞에 추가하기
      $("#appendDiv").append(html);
   });

   // 추가된 파일 입력 란 지우기 -> 추가로 만들어진 태그에는 click 이벤트(그외 모든 이벤트) 불가. --> on()을 사용해야 한다.
   $(".removeImageFileBtn").click(function(){
      alert("추가 파일 지우기");
   });
   $("#appendDiv").on("click", ".removeImageFileBtn", function(){
       // alert("추가 파일 지우기");
       // 클릭한 것의 form-group 지운다.
       $(this).closest(".imgBtn").remove();
   });
});
</script>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 브랜드 & 카테고리 스크립트  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
<script type="text/javascript">
   $(function(){
      let categoruy = "";
        let brand = "";
        $(".cOption").click(function(){
         category = $(this).text();
         $(".cOption").text(category);
            });
        $("#brand").val("").attr("selected","selected");
		$("#category").val("").attr("selected","selected");
      });
   
</script>

</head>
<body>
<div class="row">
   <div class="col-md-2" id="boardList"></div>
   <div class="col-md-8">
   <form action="write.do" method="post" enctype="multipart/form-data">
      <h3>상품등록</h3>
      <div class="col-md-12 thumbnail">
      
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메인 이미지  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
      <div class="col-md-5 mainStatus">
               <div id="image_container"
                  style="height: 350px; width: 100%; overflow: hidden;">
                  <img id="thumbnail" src="" alt="Image"
                     style="max-width: 100%; max-height: 100%; display: block; margin: auto;">
               </div>
               <input class="prImageFile" name="prImageFile" type="file" id="image" accept="image/*"
                  onchange="setThumbnail(event);" />
         </div>

      <div class="col-md-7">
      
         <table>
            <tr>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 상품명  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
               <td class="tdlabel">상품명 :</td>
               <td colspan="2"><input class="itemName pull-right" name="itemName" type="text" placeholder="상품명을 입력해 주세요."></td>
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
                 <select class="brand" name="brand" id="brand" style="width: 100%; hi">
                    <c:forEach items="${b_list }" var="b_vo">
                       <option>${b_vo.brand }</option>
                    </c:forEach>
                 </select>
               </td>
            </tr>
            <tr>
               <td class="tdlabel">가격 :</td>
               <td>
                  <input class="itemPrice pull-right" name="itemPrice" type="text" placeholder="숫자만 입력해 주세요">
               </td>
            </tr>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 색상 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
            <tr>
               <td class="tdlabel">색상 :</td>
               <td>
               <input class="colors pull-right" name="colors" type="text" placeholder="색상을 입력해 주세요">
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
               <button id="appendImageBtn" type="button" class="btn btn-block" style="background: #dddddd">서브 이미지 추가</button>
               <div id="appendDiv" style="margin-bottom: 10px; "></div>
               </td>
            </tr>
         </table>

      </div> <!-- end col-md-7 -->
   </div>
<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 상세 이미지  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■-->
      <div class="col-md-12 thumbnail">
      <h4>상세페이지</h4>
      <input class="m_detailImage" name="m_detailImage" type="file" id="detailImage" accept="image/*" onchange="setDetailThumbnail(event);" />
         <div id="detailImageContainer" style="height: 100%; width: 100%; overflow: hidden; text-align: center;">
         <img id="detailThumbnail" src="" alt="Detail Image" style="max-width: 100%; max-height: 100%; display: block; margin: auto;">
         </div>
         <button class="btn btn-lg btn-block" style="margin-top: 3%; background: #dddddd;">상품등록</button>
      </div>
   </form>
   </div> <!-- end col-md-8 -->
   <div class="col-md-2" id="boardList"></div>
</div>   
</body>
</html>