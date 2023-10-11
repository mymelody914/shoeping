<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품리스트</title>

<style type="text/css">
.dataRow:hover {
   cursor: pointer;
   background: #dddddd;
}
table {
/*    border: 1px solid; */
   width: 100%;
   margin-top: 5px;
   margin-bottom: 5px;
}
.thumbnail {
    position: relative; /* 부모 요소에 대한 상대 위치 설정 */
}

.overlay-image {
    position: absolute; /* 겹치는 이미지의 위치 설정 */
    top: 0; /* 상단 정렬 */
    right: 0; /* 오른쪽 정렬 */
    z-index: 1; /* 겹치는 이미지가 위에 표시되도록 설정 */
}
</style>

<script type="text/javascript">
$(function(){
   $("#key").val("${(empty pageObjec.key)?"t":pageObject.key}");
   
   // perPageNum 값을 세팅
   $("#perPageNum").val(${pageObject.perPageNum});
   
   // 이벤트 처리
   $(".dataRow").click(function(){
      let itemNo = $(this).find(".itemNo").text();
      
      location="/item/view.do?itemNo=" + itemNo
      + "&${pageObject.pageQuery}";
   });
   
   $("#perPageNum").change(function(){
      // alert("perPageNum 값이 변경");
      // alert("perPageNum 값 : " + perPageNum);
      location = "list.do?perPageNum=" + $("#perPageNum").val() 
      + "&key=${pageObject.key}&word=${pageObject.word}";
   });
});



</script>
<script type="text/javascript">
$(function() {
        $(".like").click(function() {
    if (${login != null}) {
            let imgNo = $(this).data("imageno");
            let itemNo = $(this).data('itemno');

            // Perform an AJAX request to your controller
            $.ajax({
                type: 'POST', // or 'GET' depending on your controller
                url: "/wishListAjax/insertWishList.do",
                data: {
                    itemNo: itemNo,
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
    	alert("회원만 이용가능합니다.");
    	return false;
    }
        });
});

</script>

</head>
<body>
   <div class="container">
      <!-- 게시판의 검색 : 제목, 내용, 작성자, 그외 복합 
         페이지는 1페이지, 한페이지에 표시할 데이터 갯수 전달. : hidden-->
   <div style="margin-bottom: 10px" class="row">
      <div id="searchDiv">
         <form action="list.do" class="form-inline">
            <input name="page" value="1" type="hidden"/>
            <input name="perPageNum" value="10" type="hidden"/>
            <div class="pull-right">
            <div class="form-group">
            <c:if test="${!empty login && (login.id == vo.id || login.gradeNo == 9)}">
	            <a href="/item/write.do?perPageNum=${pageObject.perPageNum }" class="btn btn-default newItem">상품 등록</a>
            </c:if>
               <select class="form-control" id="key" name="key">
                  <option value="t" >상품명</option>
                  <option value="c" >카테고리</option>
                  <option value="i" >아이디</option>
                  <option value="tc" >제목/내용</option>
                  <option value="tI" >제목/아이디</option>
                  <option value="cI"  >내용/아이디</option>
                  <option value="tcI" >전체</option>
               </select>
            </div>
            <div class="input-group">
               <input type="text" class="form-control" placeholder="Search"
                  name="word" value="${parm.word }">
             <span class="input-group-addon">
                   <i class="glyphicon glyphicon-search"></i>
             </span>
           </div>
           </div>
           
<!--             <div class="input-group pull-right"> -->
<!--                <span class="input-group-addon">Rows/Page</span> -->
<!--               <select class="form-control" id="perPageNum" name="perPageNum"> -->
<!--                 <option>8</option> -->
<!--                 <option>12</option> -->
<!--                 <option>16</option> -->
<!--                 <option>20</option> -->
<!--               </select> -->
<!--             </div> -->
            
         </form>
      </div>
   </div>
   
      <div class="row">
         <!-- 반복 처리 시작 -->
         <c:forEach items="${list }" var="vo" varStatus="vs" begin="0" end="${fn:length(list)}">
         <c:set var="ro" value="${wishlist[vs.index] }"/>
            <c:if test="${vs.index != 0 && vs.index % 3 == 0 }">
               ${"</div>" }
               ${"<div class=\"row\">"}
            </c:if>
         <div class="col-md-4">
         <div class="thumbnail">
         
            
            <c:if test="${ro eq null}">
                <img class="like pull-right lick overlay-image" src="/resources/assets/images/heartRed.png" width="30" height="30" id="imageData" data-imageno="${vo.imageNo }"  data-itemno="${vo.itemNo }" style="    margin-top: 10px;
    margin-right: 10px;">
            </c:if>
            <c:if test="${not empty ro}">
                <img class="like pull-right lick overlay-image" src="/resources/assets/images/heart.png" width="30" height="30" id="imageData" data-imageno="${vo.imageNo }"  data-itemno="${vo.itemNo}" style="    margin-top: 10px;
  margin-right: 10px;"> 
            </c:if>
          
            <div class="dataRow">
            	<div style="height: 500px; overflow: hidden; text-align: center;">
                <img src="${vo.fileName }" alt="Lights" style="width: 105%; height: 105%;">
            	</div>
                  <table>
                     <tr>
                  
                        <td>${vo.brand } </td>
                        <td><span class="pull-right">${vo.category }</span></td>
                     </tr>
                     <tr>
                        <td colspan="2"><p class="hidden itemNo">${vo.itemNo }</p><labal class="iname">${vo.itemName }</labal></td>
                     </tr>
                     <tr>
                        <td colspan="2"><span class="pull-right">
                        	₩<fmt:formatNumber type="number" maxFractionDigits="3" value="${vo.itemPrice }" />
                        </span></td>
                     </tr>
                  </table>
            </div>
         </div>
         </div>
         </c:forEach>
         <!-- 반복 처리 끝 -->
      </div>
      <!-- 이미지 표시의 끝 -->
      <center><pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/></center>
   </div>
</body>
</html>