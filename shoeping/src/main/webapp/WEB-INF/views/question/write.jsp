<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 작성</title>
</head>
<body>
<div class="container">
	<h2>문의 작성</h2>
	<form action="write.do" method="post">
		<input type="hidden" name="itemNo" value="${vo}">
		<div style="padding-bottom: 10px;">
			<label class="radio-inline"><input type="radio" name="pw" value="0" checked>일반글</label>
			<label class="radio-inline"><input type="radio" name="pw" value="1">비밀글</label>
		</div>
		<div class="form-group">
			<label for="title">제목</label>
			<input class="form-control" name="title" id="title" required>
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea rows="5" class="form-control" name="content" id="content" required></textarea>
		</div>
		<button class="btn btn-default">등록</button>
		<button class="btn btn-default">취소</button>
	</form>
</div>
</body>
</html>