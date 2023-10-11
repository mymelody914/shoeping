<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<style type="text/css">
.dataRow:hover {
	cursor: pointer;
	background: #d8d8d8;
}
</style>


</head>
<body>
	<div class="container">
		<h2>공지사항</h2>
		<form action="update.do" method="post">
			

			<div class="form-group">
				<label for="no">번호</label> <input id="notice_no" name="notice_no" required
					type="hidden" value="${param.notice_no }"class="form-control">
			</div>
			<div class="form-group">
				<label for="title">제목</label> <input id="title" name="title"
					required value="${vo.title }"class="form-control">
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea rows="5" id="content" name="content" required class="form-control">${vo.content }</textarea>
			</div>



			<button class="btn btn-default" >공지수정완료</button>
		</form>
	</div>
</body>
</html>