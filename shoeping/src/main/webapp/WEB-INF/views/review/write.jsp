<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reviewWriteForm</title>
<script type="text/javascript">
   function selectedEvent(e){   
      console.log("itemno" , $("#selectTag option:selected").data("itemno"));
      console.log("orderno" , $("#selectTag option:selected").data("orderno"));   

      $("#hiddenItemNo").val( $("#selectTag option:selected").data("itemno") );
      $("#hiddenOrderNo").val( $("#selectTag option:selected").data("orderno") );
      
                  
      }
$(function(){
   $("#cancelBtn").click(function() {
		history.back();
	})
     

     
   });
</script>

</head>
<body>

   <div class="container">

      <h2 style="text-align: center;">리뷰등록</h2>




      <form action="write.do" method="post" enctype="multipart/form-data">
         <input id = "hiddenItemNo" type="hidden" name="itemNo" value=""  required="required">
         <input id = "hiddenOrderNo"type="hidden" name="orderNo" value="" required="required">
         <div>
         </div>
         <select id = "selectTag" onchange="selectedEvent()" required="required">
            <option value="">리뷰쓸 상품을 선택하세요</option>
            <c:forEach items="${writeList}" var="vo">

               <option class="form-group" data-itemno="${vo.itemNo }"   data-orderno="${vo.orderNo }">
               (주문번호:${vo.orderNo})${vo.itemName }
               </option>

            </c:forEach>
         </select>
   

   <div class="form-group">
      <label for="title">제목</label> <input id="title" name="title" required
         class="form-control">
   </div>
   <div class="form-group">
      <label for="content">내용</label> <input id="content" name="content"
         required class="form-control">
   </div>

   <div class="form-group">
      <label for="fileName">사진</label><input id="prImageFile" name="prImageFile"
         type="file" class="form-control">
   </div>


   <button class="btn btn-default"
      style="color: white; background-color: black;">등록완료</button>

   </form>
<button  class="btn btn-default"  id="cancelBtn">취소</button>
      
</div>
</body>
</html>