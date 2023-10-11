<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
<div class="container">
		<h2>공지사항</h2>
		<form action="write.do" method="post" >
			<input name="perPageNum" value="${param.perPageNum }" type="hidden">
			<div class="form-group">
				<label for="title">제목</label> <input id="title" name="title"
					required class="form-control">
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea rows="5" id="content" name="content" required
					class="form-control"></textarea>
			</div>
		

			<button class="btn btn-default">등록완료</button>
		</form>
	</div>

</body>
</html>