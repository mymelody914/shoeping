<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<style type="text/css">
.container {
	margin-top: 20px;
}

.table th, .table td {
	text-align: center;
	vertical-align: middle;
}

.reviewBtn, .updateBtn, .deleteBtn {
	cursor: pointer;
}

.imgDiv img {
	max-width: 100%;
	height: auto;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#perPageNum").change(
				function() {
					location = "list.do?page=1&perPageNum="
							+ $("#perPageNum").val()
							+ "&key=${pageObject.key}&word=${pageobject.word}";
				});

		$(".write").click(function() {
			let id = $(this).find("id").val();
			alert("로그인확인" + id)
			return;
		})

		$(".updateBtn").click(function() {
			let review_no = $(this).data("reviewno");

			location = "update.do?review_no=" + review_no;
		})

		$(".deleteBtn").click(function() {
			let review_no = $(this).data("reviewno");
		
			if (confirm("정말로 삭제하시겠습니까?")) 
				location = "delete.do?review_no=" + review_no;
			
		})
	});
</script>

</head>
<body>

	<div class="container">
		<h2>후기상세보기</h2>
		<div class="panel-group">
			<div class="panel panel-default">
				<div class="panel-heading" style="height: 70px;">
					상품명:<span>${vo.itemName }</span> <span class="pull-right">작성자:${vo.id }</span>
					<br> <span class="pull-right"><fmt:formatDate
							value="${vo.writeDate }" pattern="yyyy-MM-dd" /></span>

				</div>
				<div class="panel-body" style="height: 300px;">
					<input type="hidden" ${vo.review_no }> <input type="hidden"
						${vo.itemNo }>

					<div class="column" style="width: 50%; float: left;">
						<span> <img src="${vo.fileName }"
						style="width: 250px; height: 270px"></span>
					</div>
					<div class="column" style="width: 50%; float: left;">
							<div style="padding: 60px;">
							<table>
							<tr>
								<th>상품명:</th>
								<td>${vo.itemName }</td>
								</tr>
								<tr>
								<th>제목:</th>
								<td>${vo.title }</td>
								</tr>
								<tr>
								<th>내용:</th>
								<td>${vo.content }</td>
							</tr>
							</table>
							</div>
					</div>


					

				</div>
				<div class="panel-footer">
					<c:if test="${vo.id == login.id || login.gradeNo == 9}">
					<div class="btn-group btn-group-justified">
						<a href="update.do?review_no=${vo.review_no }"
							class="btn btn-link updateBtn">수정</a> 
							<a
							class="btn btn-link deleteBtn" data-reviewno="${vo.review_no }" >삭제</a> 
							<a type="button"
							class="btn btn-link" data-toggle="modal" data-target="#myModal">이미지바꾸기</a>
					</div>

						</c:if>

				</div>

			</div>
		</div>
		<a href="list.do" class="btn btn-link" >리스트</a>
	</div>


	<!-- Modal image change -->
	<div id="myModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<form action="change.do" method="post">
					<div class="modal-header">
						<input type="hidden" name="review_no" value="${vo.review_no }">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">사진바꾸기</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="fileName">사진</label><input id="fileName"
								name="fileName" type="file">
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default">수정</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</form>
			</div>

		</div>
	</div>
	
	
	
	
	

</body>
</html>