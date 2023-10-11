<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
.title {
	text-overflow: ellipsis; /* 말 줄임 표 - 아래 2가지 css가 필수다. */
	white-space: nowrap; /* 데이터가 많아도 한줄 처리 */
	overflow: hidden; /* 넘치는 데이터는 안 보이게 처리 */
	border-top: 1px solid #ddd;
	padding-top: 15px;
}
</style>
<script type="text/javascript">
	
</script>
<div class="container">


	<h1>후기</h1>
<div style="text-align: center;">
		<a href="/review/list.do"  style="padding: 10px;">리뷰더보기</a>
</div>
	<div class="list-group">

		<div class="line" style="padding: 10px;"></div>
		<c:if test="${ empty reviewlist }">
			<div class="well">상품에 후기가 존재하지 않습니다.</div>
		</c:if>

		<div class="row">
			<c:forEach items="${reviewlist}" var="vo" varStatus="vs">

				<c:if test="vs.index > 0 && vs.index % 4 == 0">
					<!-- 4개의 데이터가 찍히면 줄바꿈하는 처리 -> div를 마치고 다시 시작 - class=row -->

				</c:if>
				<div class="thumbnail col-md-3"
					style="height: 195px; width: 280px; margin-left: 20px">
					<div style="padding-left: 45px">
						<img src="${vo.fileName }" alt="${vo.fileName }" width="185px"
							height="150px">
					</div>
					<p class="title" style="height: 36px;">${vo.title }</p>
				</div>

			</c:forEach>
		</div>
	</div>


</div>












