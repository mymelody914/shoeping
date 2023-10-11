<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리셀 수정</title>

<!-- 부트스트랩 3 Datepicker CSS 및 JavaScript -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker3.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.min.js"></script>

</head>
<!-- script tag 안에 JS로 datepicker 등록 : 전체 datepicker 클래스로 등록 -->


<body>
	<div class="container">
		<h2>리셀 컬렉션 수정 </h2>
		<form action="update.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="deleteFileName" value="${vo.fileName }">
			<input type="hidden" name="resellNo" value="${vo.resellNo }">
			<input type="hidden" name="imageNo" value="${vo.imageNo}">
			
			
			
			<div class="form-group">
				<label for="resellName">제품 이름  </label> <input id="resellName" name="resellName"
					required class="form-control" value="${vo.resellName }">
			</div>
			<div class="form-group">
				<label for="category">카테고리</label> <select id="category"
					name="category" required class="form-control">
					<c:forEach var="category" items="${category}">
						<option value="${category.category}">${category.category}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<label for="brand">브랜드</label> <select id="brand"
					name="brand" required class="form-control">
					<c:forEach var="brandList" items="${brandList}">
						<option value="${brandList.brand}">${brandList.brand}</option>
					</c:forEach>
				</select>
			</div>
			
			<div class="form-group">
				<label for="prImageFile">메인 이미지 </label> 
				<input id="prImageFile" name="prImageFile" class="form-control" type="file" required="required" > 
			</div>
			
			<div class="form-group">
				<label for="resellModelName">제품번호 </label> <input id="resellModelName" name="resellModelName"
					required class="form-control" value="${vo.resellModelName }">
			</div>
			<div class="form-group">
				<label for="resellPrice">제품가격 </label> <input id="resellPrice" name="resellPrice"
					required class="form-control" value="${vo.resellPrice }">
			</div>
			
			<div class="form-group">
				<label for="sizes">사이즈</label> 
				<select id="sizes"class="form-control">
				<option value="210">210</option>
				<option value="215">215</option>
				<option value="220">220</option>
				<option value="225">225</option>
				<option value="230">230</option>
				<option value="235">235</option>
				<option value="240">245</option>
				<option value="250">250</option>
				<option value="255">255</option>
				<option value="260">260</option>
				<option value="265">265</option>
				<option value="270">270</option>
				<option value="275">275</option>
				<option value="280">280</option>
				<option value="285">285</option>
				<option value="290">290</option>
				<option value="295">295</option>
				<option value="300">300</option>
				</select>
			</div>
			<div class="form-group" id="selected-options">
    <!-- 선택한 옵션에 따라 동적으로 생성될 옵션들은 여기에 추가될 것입니다. -->
</div>
<script>
    var selectedOptions = []; // 선택한 옵션을 저장할 배열

    // select 요소가 변경될 때마다 호출될 함수를 만듭니다.
    $('#sizes').on('change', function() {
        // 선택한 옵션의 값을 가져옵니다.
        var selectedSize = $(this).val();
        
        // 선택한 옵션을 배열에 추가합니다.
        selectedOptions.push(selectedSize);

        // 선택한 옵션을 표시할 HTML을 생성합니다.
        var selectedOptionsHTML = '<p id="selectSize">' + selectedOptions.join('/') + '</p>';
        
        // 선택한 옵션을 표시하는 div를 업데이트합니다.
        $('#selected-options').html(selectedOptionsHTML);
    	let size = $("#selectSize").text();	
    	console.log(size);
    	$("#size").val(size);
    });
    
    $(document).ready(function () {
        $('#datePicker').datepicker({
            format: 'yyyy-mm-dd',  // 날짜 형식 설정
            autoclose: true        // 선택 후 자동으로 닫힘
        });
    });

</script>
<input type="hidden" value=""  id="size" name="sizes">
			
			<div class="form-group">
				<label for="color">컬러  </label> <input id="color" name="color"
					required class="form-control" value="${vo.color }">
			</div>
			
				<label for="dday">마감기한   </label> <input class="datepicker" id="datePicker" name="dday"
					required type="text" autocomplete="off" readonly="readonly">
			
			
			
			
			<div id="appendDiv" style="margin-bottom: 10px;"></div>
			<button type="submit">등록</button>
		</form> 

	</div>
</body>
</html>