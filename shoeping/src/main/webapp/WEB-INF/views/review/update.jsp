<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업데이트샤방</title>


</head>
<body>

<div class="container">
<h2>리뷰수정하기</h2>
	<form action="update.do" method="post">
	<input type="hidden" name="review_no" value="${vo.review_no }" id="review_no">
<div class="form-group">
	<input id="itemNo" name="itemNo" value="${vo.itemNo }" type="hidden">
	</div>
<div class="form-group">
	<input id="orderNo" name="orderNo" value="${vo.orderNo }" type="hidden">
	</div>

<div class="form-group">
	<label for="title">제목</label><input id="title" name="title" value="${vo.title}" class="form-control">
	</div>
<div class="form-group">
	<label for="content">내용</label><input id="content" name="content" value="${vo.content}" class="form-control">
	</div>
<div class="form-group">
	<input type="hidden" id="id" name="id" value="${vo.id }" class="form-control">
	</div>
	
	<button>등록완료</button>
	</form>
	</div>
	
</body>
</html>