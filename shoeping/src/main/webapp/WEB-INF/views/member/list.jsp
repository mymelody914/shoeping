<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>
<script type="text/javascript">
	$(function() {

		$("#key").val("${(empty pageObject.key)?"id":pageObject.key}");
		// ------------- 이벤트 처리 ------------------

		let clickCnt = 2;
		let oldData = "";
		let changeData = "";

		// 회원 등급 처리
		$(".grade").click(
				function() {
					let val = $(this).val();
					if (clickCnt == 2) {
						clickCnt = 1;
						oldData = val;
					} else {
						clickCnt = 2;
						changeData = val;
						if (oldData != changeData) {
							let id = $(this).closest(".dataRow").find(".id")
									.text();
							if (confirm(id + "님의 등급을 "
									+ ((changeData == 1) ? "일반회원으로" : "관리자로")
									+ " 바꾸시겠습니까?")) {
								// alert("데이터 바꾸기 진행");
								$.ajax({
									url : "/ajax/changeGrade.do?id=" + id
											+ "&gradeNo=" + changeData,
									success : function(result) {
										console.log("success.result = "
												+ result);
										alert(result);
									},
									error : function(xhr, status, error) {
										console.log("error.xhr= " + xhr);
										console.log("error.status= " + status);
										console.log("error.error= " + error);
										alert("회원 등급 변경 중 오류 발생");
									}
								});
							} else {
								// 원래 데이터로 복귀 세팅
								$(this).val(oldData);
							}
						}
					}
					console.log("회원 상태 클릭(" + clickCnt + ") : " + val);
					console.log("원래 데이터 =" + oldData + ", 바꿀 데이터 = "
							+ changeData);
				});

		$(".status").click(
				function() {
					let val = $(this).val();
					if (clickCnt == 2) {
						clickCnt = 1;
						oldData = val;
					} else {
						clickCnt = 2;
						changeData = val;
						if (oldData != changeData) {
							let id = $(this).closest(".dataRow").find(".id")
									.text();
							if (confirm(id + "님의 등급을 "
									+ ((changeData == 1) ? "정상 으로" :
										(changeData == 2) ? "휴면 으로" : "탈퇴 로"
										)
									+ " 바꾸시겠습니까?")) {
								// alert("데이터 바꾸기 진행");
								$.ajax({
									url : "/ajax/changeStatus.do?id=" + id
											+ "&statusNo=" + changeData,
									success : function(result) {
										console.log("success.result = "
												+ result);
										alert(result);
									},
									error : function(xhr, status, error) {
										console.log("error.xhr= " + xhr);
										console.log("error.status= " + status);
										console.log("error.error= " + error);
										alert("회원 등급 변경 중 오류 발생");
									}
								});
							} else {
								// 원래 데이터로 복귀 세팅
								$(this).val(oldData);
							}
						}
					}
					console.log("회원 상태 클릭(" + clickCnt + ") : " + val);
					console.log("원래 데이터 =" + oldData + ", 바꿀 데이터 = "
							+ changeData);
				});
	});
</script>
</head>
<body>
	<div class="container">
		<form action="list.do" class="form-inline">
			<select name="key" class="form-control mr-2">
				<option value="name">이름</option>
				<option value="id">아이디</option>
				<option value="email">이메일</option>
			</select> <input type="text" name="word" placeholder="검색어를 입력하세요"
				class="form-control mr-2" value="${pageObject.word }">
			<button class="btn btn-default" id="searchBtn">검색</button>
		</form>
		<table class="table" id="memberTable">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>닉네임</th>
				<th>연락처</th>
				<th>이메일</th>
				<th>상태</th>
				<th>등급</th>
				<th></th>
			</tr>
			<c:forEach items="${list }" var="vo">
				<c:if test="${login.id != vo.id }">
					<tr class="dataRow">
						<td class="id">${vo.id }</td>
						<td>${vo.name }</td>
						<td>${vo.nickName }</td>
						<td>${vo.phone }</td>
						<td>${vo.email }</td>
						<td><select class="status">
								<option value="1" ${(vo.statusNo == 1)?"selected":"" }>정상</option>
								<option value="2" ${(vo.statusNo == 2)?"selected":"" }>휴면</option>
								<option value="3" ${(vo.statusNo == 3)?"selected":"" }>탈퇴</option>
						</select></td>
						<td><select class="grade">
								<option value="1" ${(vo.gradeNo == 1)?"selected":"" }>일반회원</option>
								<option value="9" ${(vo.gradeNo == 9)?"selected":"" }>관리자</option>
						</select></td>
						<td><a href="view.do?id=${vo.id }&${pageObject.pageQuery}"
							class="btn btn-default">회원 정보</a></td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
		<div>
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
		</div>
	</div>
</body>
</html>