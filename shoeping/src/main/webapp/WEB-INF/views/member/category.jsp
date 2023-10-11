<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category</title>
<style type="text/css">
.table {
	text-align: center;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#categoryAdd").click(function() {
			const category = $('#category').val();
			// alert("test");
			$.ajax({
				type : "get",
				url : "/ajax/categoryAdd.do?category=" + category,
				dataType : "text",

				success : function(response) {
					$('#category').val('');
					// alert("data : " + data);
					document.location.href = document.location.href;

				},
				error : function(xhr, status, error) {
					console.log("error.xhr= " + xhr);
					console.log("error.status= " + status);
					console.log("error.error= " + error);
					alert("카테고리 추가 중 오류 발생");
				}
			});
		});

		$(".deleteBtn").click(function() {
			// alert("test");
			let category = $(this).closest(".dataRow").find(".category").text().replace('삭제', '');
			
			location = "categoryDelete.do?category=" + category;
		});
	});
</script>
</head>
<body>
	<div class="container">
		<h2>카테고리 편집</h2>
		<table class="table">
			<tr>
				<th>카테고리 이름</th>
			</tr>
			<c:forEach items="${categoryList }" var="vo">
				<tr class="dataRow">
					<td class="category">${vo.category }
						<button class="btn btn-default deleteBtn">삭제</button>
					</td>
				</tr>
			</c:forEach>
		</table>
		<form action="categoryAdd.do">
			<label>카테고리 이름 입력</label> <input type="text" id="category"
				name="category">
			<button class="btn btn-default" id="categoryAdd" type="button">등록</button>
		</form>
	</div>
</body>
</html>