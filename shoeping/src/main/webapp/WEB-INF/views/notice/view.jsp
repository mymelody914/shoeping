<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice-view</title>

<style type="text/css">
.bg-2 {
	background-color: #474e5d;
	color: #ffffff;
}

.bg-3 {
	background-color: #ffffff;
	color: #555555;
}

.container-fluid {
	padding-top: 70px;
	padding-bottom: 70px;
}
</style>
</head>
<body>

	<div class="container-fluid bg-2 text-center">
		<h3>${vo.title }</h3>

	</div>

	<div class="container-fluid bg-3 text-center">
		<h3>${vo.content}</h3>
		<p></p>

		<form action="delete.do" method="post">
			<div class="btn-group">
				<a href="list.do?page=${param.page}&perPageNum=${param.perPageNum}"
					class="btn btn-custom" role="button">리스트</a>

				<c:if test="${login.gradeNo > 1}">
					
					<input type="hidden" value="${vo.notice_no}" name="no">
					<input type="hidden" value="${param.perPageNum}" name="perPageNum">
					<button class="btn btn-link">삭제</button>
					<a
						href="update.do?no=${vo.notice_no}&page=${param.page}&perPageNum=${param.perPageNum}"
						class="btn btn-custom" role="button">수정</a>
			</c:if>
			</div>
		</form>

	</div>
	
	<!-- 여긴 페이지 넘기는 창 -->
	
	<div class="container">
                
  <ul class="pager">
    <li class="previous"><a href="#">Previous</a></li>
    <li class="next"><a href="#">Next</a></li>
  </ul>
</div>
	
	<!-- 여긴 페이지 넘기는 창 -->
	
	
	

</body>
</html>