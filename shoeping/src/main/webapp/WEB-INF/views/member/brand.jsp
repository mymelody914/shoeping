<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Brand</title>
<style type="text/css">
.table {
	text-align: center;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#brandAdd").click(function() {
			const brand = $('#brand').val();
			// alert("test");
			$.ajax({
				type : "get",
				url : "/ajax/brandAdd.do?brand=" + brand,
				dataType : "text",

				success : function(response) {
					$('#brand').val('');
					// alert("data : " + data);
					document.location.href = document.location.href;

				},
				error : function(xhr, status, error) {
					console.log("error.xhr= " + xhr);
					console.log("error.status= " + status);
					console.log("error.error= " + error);
					alert("브랜드 추가 중 오류 발생");
				}
			});
		});

		$(".deleteBtn").click(function() {
			// alert("test");
			let brand = $(this).closest(".dataRow").find(".brand").text().replace('삭제', '');
			
			location = "brandDelete.do?brand=" + brand;
		});
	});
</script>
</head>
<body>
	<div class="container">
		<h2>브랜드 편집</h2>
		<table class="table">
			<tr>
				<th>브랜드 이름</th>
			</tr>
			<c:forEach items="${brandList }" var="vo">
				<tr class="dataRow">
					<td class="brand">${vo.brand }
						<button class="btn btn-default deleteBtn">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</table>
		<form action="brandAdd.do">
			<label>브랜드 이름 입력</label> <input type="text" id="brand"
				name="brand">
			<button class="btn btn-default" id="brandAdd" type="button">등록</button>
		</form>
	</div>
</body>
</html>