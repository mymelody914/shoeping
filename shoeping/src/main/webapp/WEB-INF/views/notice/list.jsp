<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항리스트</title>

<style type="text/css">
.moreBtn:hover {
	cursor: pointer;
	font-weight: bolder;
}
.moreBtn{
	background: none;
}
#nwriteBtn {
	margin-top: 10px;
}

#nwriteBtn:hover {
	background: black;
	color: white;
	border: black;
}
.tabBtn{
	color: black;
}
.tabBtn:hover{
	color: black;
	font-weight: bolder;
	cursor: pointer;
}
/* 모달을 화면 가운데 정렬합니다. */
.modal {
    position: fixed;
	top: 60%;
	left: 50%;
	-webkit-transform: translate(-50%, -50%);
	-moz-transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	-o-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
}
</style>
<script type="text/javascript">
	$(function() {

		$("#perPageNum").val("${pageObject.perPageNum}");

// 		$(".viewBtn").click(function() {

// 			let notice_no = $(this).data("noticeno");

// 		});

		$("#perPageNum").change(
				function() {
					location = "list.do?page=1&perPageNum="
							+ $("#perPageNum").val()
							+ "&key=${pageObject.key}&word=${pageobject.word}";
				});

	});
</script>
</head>
<body>

	<!-- 여기여기시작 -->
	<div class="container text-center">
		<div class="row content">
			<div class="col-sm-2">
				<div
					style="padding-top: 10px; padding-bottom: 1px; border-bottom: double #ddd;">
					<h2>공지사항</h2>
				</div>
				<div style="padding-top: 5px">

					<p style="padding-top: 5px;">
						<a href="#" class="tabBtn">공지사항</a>
					</p>
					<p>
						<a href="#" class="tabBtn">이벤트</a>
					</p>
				</div>

			</div>




			<div class="col-sm-10 text-left">
				<div style="padding: 35px;"></div>
				<c:forEach items="${list }" var="vo">
					<div class="dataRow">
						<div class="no" style="display: none;">${vo.notice_no}</div>
						<p style="padding: 10px; border-bottom: 1px solid #d8d8d8; margin: 0px;">
							<span>[공지사항]${vo.title}</span>
							<span class="pull-right">
								<button class="btn moreBtn" data-noticeno="${vo.notice_no }"
									type="button" data-toggle="modal" data-target=".myModal${vo.notice_no}">
									더보기
								</button>
							</span>
						</p>
					</div>
					<div class="modal fade myModal${vo.notice_no}" tabindex="-1" role="dialog">
					    <div class="modal-dialog modal-dialog-centered" role="document">
					        <div class="modal-content">
					            <div class="modal-header">
					                <button type="button" class="close" data-dismiss="modal">&times;</button>
					                <h4 class="modal-title" style="font-weight: bold;">${vo.title}</h4>
					            </div>
					            <div class="modal-body">
					                <p>${vo.content }</p>
					            </div>
					            <div class="modal-footer">
					                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					                <c:if test="${login.gradeNo == 9}">
					                <a type="button" class="btn btn-default" href="update.do?notice_no=${vo.notice_no}" id="updateBtn">수정</a>
					                <a type="button" class="btn btn-default" href="delete.do?notice_no=${vo.notice_no}" id="deleteBtn">삭제</a>
					                </c:if>
					            </div>
					        </div>
					    </div>
					</div>

				</c:forEach>


			</div>


			<div class="col-sm-2">
			</div>
		</div>
		<c:if test="${login.gradeNo == 9}">
			<a href="write.do?perPageNum=${pageObject.perPageNum }"
				class="btn btn-default" id="nwriteBtn">공지사항등록</a>
		</c:if>

		<div style="text-align: center;">
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
		</div>
	</div>




	<!-- 여기여기 끝 -->







</body>
</html>