<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기리스트</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
/* .container { */
/* 	margin-top: 20px; */
/* } */
.container {
	width: 1460px;
}

.table th, .table td {
	text-align: center;
	vertical-align: middle;
}

.reviewBtn, .updateBtn, .deleteBtn {
	cursor: pointer;
}

.imgDiv {
	overflow: hidden;
}

.imgDiv img {
	max-width: 70%;
	height: auto;
}

.row>.review>.col-sm-4 {
	height: 40px;
	padding-top: 10px;
	padding-bottom: 10px;
}

.title {
	text-overflow: ellipsis; /* 말 줄임 표 - 아래 2가지 css가 필수다. */
	white-space: nowrap; /* 데이터가 많아도 한줄 처리 */
	overflow: hidden; /* 넘치는 데이터는 안 보이게 처리 */
}
</style>
<script type="text/javascript">
	$(function() {
// 		$("#perPageNum").change(function() {
// 			location = "list.do?page=1&perPageNum=" + $("#perPageNum").val();

// 		})//perPageNum 끝 
$("#perPageNum").val("${pageObject.perPageNum}");

		$("#perPageNum").change(function(){
			// alert("페이지당 데이터의 개수를 변경했습니다.");
			location = "list.do?page=1&perPageNum=" + $("#perPageNum").val()
				+ "&key=${pageObject.key}&word=${pageObject.word}";
		});

		//리뷰등록버튼
		$(".write").click(function() {
			let id = $(this).find("id").val();

			return;
		})//리뷰등록버튼
		//like 버튼 시작 ---
		 		$(".like").click(function() {
// 		 			let review_no = $(this).data("reviewno");
// 		 if( ${empty login.id}){
// 			alert("좋아요 기능을 누르시려면 로그인이 되어 있어야합니다.-로그인페이지로이동합니다.");
// 		 location ="/member/login.do";
// 		 }else{
// 		 	location="checkLike.do?review_no="+review_no;
// 		 }
						if(${!empty login}){
		 			        let review_no = $(this).data("reviewno");
		 			        $.ajax({
		 			            url: "checkLike.do",
		 			            method: "get", // 요청 방식 (GET 또는 POST를 선택하세요)
		 			            data: { review_no: review_no }, // 전송할 데이터
		 			            success: function(response){
		 			                // AJAX 요청이 성공했을 때 수행할 작업을 여기에 추가하세요
		 			                console.log("리뷰좋아요 요청이 성공했습니다.");
		 			                location.reload();
		 			                // 여기에서 추가적인 작업을 수행하거나 페이지 리로드 등을 수행할 수 있습니다.
		 			            },
		 			            error: function(xhr, status, error){
		 			                // AJAX 요청이 실패했을 때 수행할 작업을 여기에 추가하세요
		 			                console.error("리뷰좋아요 요청이 실패했습니다. 오류: " + error);
		 			            }
		 			        });
						}else{
								alert("로그인이 되어 있지 않아서 이동해야합니다.");
								location="/member/login.do";

							}
		 			    });
		 			
		//like버튼 끝

		//상세보기
		$(".reviewBtn").click(function() {
			let review_no = $(this).data("reviewno");

			location = "view.do?review_no=" + review_no;
		});
		//상세보기

	})//function 끝

	function resize(){
		// 이미지의 너비를 구해보자.
		// select "a b" --> a안에 있는 b 객체를 선택. :first - 처음 것 --> .first()
		let width = $(".dataRow .imgDiv:first").width();
		// alert(width);
		let height = width / 3 * 2.4;
		$(".dataRow .imgDiv").height(height + "px");
	}
</script>


</head>
<body>
	<!-- 리뷰게시판리스트 -->
	<div class="container">
		<div style="text-align: center;">
			<h2>REVIEW</h2>
			<img src="../upload/image/review.jpg" alt="Image"
				style="width: 1170px; height: 470px;">
		</div>
		<div style="height: 200px; padding-top: 50px; padding-bottom: 50px;">
			<h3>New Review</h3>
			<div class="pull-right" style="width: 300px; margin-bottom: 10px;">
				<form action="list.do">
					<input name="page" value="1" type="hidden" />
					<div class="input-group">
						<span class="input-group-addon">Rows/Page</span> <select
							class="form-control" id="perPageNum" name="perPageNum"
							style="wedth: 100px">
							<option>8</option>
							<option>12</option>
						</select>
					</div>
				</form>
			</div>
		</div>
		<div class="row" style="padding: 10px;">
			<c:forEach items="${list}" var="vo" varStatus="vs">
				<c:if test="vs.index > 0 && vs.index % 4 == 0">
					<c:out value="</div>" />
					<c:out value="<div class='row'>" />
				</c:if>
				<div class="col-sm-3" style="padding: 5px;">
					<div class="imgDiv" style="width: 290px; height: 150px">
						<img src="${vo.fileName}" class="img-responsive"
							style="padding-left: 5px; width: 280; height: 140; text-align: center"
							alt="Image">
					</div>
					<p>${vo.itemName}</p>
					<p class="title">${vo.title}</p>
					<p>
						<button class="btn btn-link reviewBtn"
							data-reviewno="${vo.review_no}">
							<span>더보기</span>
						</button>
					</p>
					<a class="like" data-reviewno="${vo.review_no}">
						<button class="btn btn-defalut" style="background: black;">
							<span class="glyphicon glyphicon-thumbs-up"
								style="color: yellow;"></span> <span class="badge"
								style="background-color: gray;">${vo.count}</span>
						</button>
					</a>
				</div>
			</c:forEach>
		</div>
	</div>

	<br>

	<div class="text-center">
		<p>
			<c:if test="${!empty login.id && login.gradeNo < 9}">
				<div>
					<a href="/review/write.do">
						<button class="btn btn-default">리뷰등록</button>
					</a>
				</div>
			</c:if>
		</p>
	</div>

	<!-- 리뷰게시판리스트 -->

	<div style="text-align: center;">
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
		
	</div>

</body>
</html>