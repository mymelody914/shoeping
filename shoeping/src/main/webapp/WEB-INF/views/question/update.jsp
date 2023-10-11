<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 수정</title>
</head>
<body>
<div class="container">
	<h2>문의 수정</h2>
	<form action="update.do" method="post">
		<input type="hidden" name="itemNo" value="${ino}">
		<input type="hidden" name="qno" value="${vo.qno}">
		<div class="form-group">
			<label for="title">제목</label>
			<input class="form-control" name="title" id="title" required value="${vo.title}">
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea rows="5" class="form-control" name="content" id="content" required>${vo.content}</textarea>
		</div>
		<button class="btn btn-default">수정</button>
<!-- 		<button class="btn btn-default">취소</button> -->
	</form>
</div>
</body>
</html>