<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 보기</title>
<style type="text/css">
.user_thumb {
	/*    text-align: center; */
	
}

table, th, td {
	border: 1px solid #bcbcbc;
}

#updateNickNameDiv {
	display: none;
}

#updateEmailDiv {
	display: none;
}

#updateAddressDiv {
	display: none;
}

.profileImageDiv {
	width: 200px;
	height: 200px;
	background: #ddd;
	border-radius: 100px;
	overflow: hidden;
	text-align: center;
}

#imageCangeBtn {
	margin: 10px 0px 10px 45px;
	background: black;
	border: 1px solid black;
	color: white;
}

#imageCangeBtn:hover {
	background: white;
	border: 1px solid black;
	color: black;
}

.pStyle {
	color: #444444;
	font-weight: bold;
	font-size: 17px;
	margin-bottom: 10px;
	margin: 10px 0px 10px 20px;
}

.blackBtns {
	background: black;
	border: 1px solid black;
	border-radius: 5px;
	font-size: 13px;
	width: 40px;
	padding: 3px 2px 0px 0px;
	color: white;
}

.blackBtns:hover {
	background: white;
	border: 1px solid black;
	color: black;
}
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('zipCode').value = data.zonecode;
						document.getElementById("address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("detailAddress").focus();
					}
				}).open();
	}
</script>
<script type="text/javascript">
	$(function() {
		// 변경 DIV 호출 관련
		$("#updateNickNameBtn").click(function() {
			$("#updateNickNameDiv").slideToggle();
		});
		$("#updateEmailBtn").click(function() {
			$("#updateEmailDiv").slideToggle();
		});

		$("#updateAddressBtn").click(function() {
			$("#updateAddressDiv").slideToggle();
		});

		// 정보 변경 ajax
		$('#updateNickNameSubmit').on(
				"click",
				function() {
					var form1 = $("#updateForm").serialize();
					$.ajax({
						type : "post",
						url : "/ajax/updateInfo.do",
						data : form1,
						dataType : 'json',
						success : function(data) {
							var newNickName = data.nickName;
							$("#nickName").text(newNickName);
							$("#updateNickNameDiv").slideUp();
							console.log(data);
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						}
					});
				});

		$('#updateEmailSubmit').on(
				"click",
				function() {
					var form1 = $("#updateForm").serialize();
					$.ajax({
						type : "post",
						url : "/ajax/updateInfo.do",
						data : form1,
						dataType : 'json',
						success : function(data) {
							var newEmail = data.email;
							// alert(newEmail);
							$("#emailDiv span").text(newEmail);
							$("#updateEmailDiv").slideUp();
							console.log(data);
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						}
					});
				});
		$('#updateAddressSubmit').on(
				"click",
				function() {
					var form1 = $("#updateForm").serialize();
					$.ajax({
						type : "post",
						url : "/ajax/updateInfo.do",
						data : form1,
						dataType : 'json',
						success : function(data) {
							var newAddress = data.address;
							// alert(newEmail);
							$("#addressDiv span").text(newAddress);
							$("#updateAddressDiv").slideUp();
							console.log(data);
						},
						error : function(request, status, error) {
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						}
					});
				});
	});
</script>
<script>
	function changePwSubmit() {
		const pw1 = $("#pw").val();
		const pw2 = $("#pw2").val();

		if (pw1 != pw2) {
			alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			event.preventDefault(); // 틀리면 폼 제출 막기
		}
	}
</script>
</head>
<body>
	<div class="row">
		<div class="col-md-2">
			<p class="pStyle">쇼핑 정보</p>
			<div style="margin-left: 20px;">
				<p>
					<a href="/member/view.do">마이페이지</a>
				</p>
				<p>
					<a href="/buy/list.do">구매내역</a>
				</p>
				<p>
					<a href="/wishList/list.do">관심상품</a>
				</p>
				<p>
					<a href="/cart/list.do">장바구니</a>
				</p>
			</div>
		</div>
		<div class="col-md-8">
			<h2 style="margin-bottom: 20px;">마이 페이지</h2>
			<div class="user_detail">
				<div class="user_thumb row">
					<div class="col-sm-3">
						<div class="profileImageDiv">
							<c:if test="${vo.profilePhoto == null }">
								<img alt="" src="../upload/image/blank_profile.png">
							</c:if>
							<c:if test="${vo.profilePhoto != null }">
								<img src="${vo.profilePhoto }">
							</c:if>
						</div>
						<div>
							<c:if test="${vo.id == login.id || login.gradeNo == 9}">
								<button type="button" class="btn" data-toggle="modal"
									data-target="#changePhotoModal" id="imageCangeBtn">사진
									바꾸기</button>
							</c:if>
						</div>
					</div>
				</div>
				<div class="user_info">
					<form id="updateForm" autocomplete="off">
						<div class="row" style="border-bottom: 2px solid black;">
							<div class="col-sm-3">
								<p class="pStyle">ID</p>
								<p style="margin: 10px 0px 10px 20px;">${vo.id }</p>
								<input type="hidden" name="id" value="${vo.id }">
							</div>
							<div class="col-sm-3" id="nickNameDiv">
								<p class="pStyle">닉네임</p>
								<p style="margin: 10px 0px 10px 20px;" id="nickName">${vo.nickName }
									<c:if test="${vo.id == login.id || login.gradeNo == 9 }">
										<button id="updateNickNameBtn" type="button" class="blackBtns">변경</button>
									</c:if>
								</p>
								<div id="updateNickNameDiv">
									<h4>변경할 닉네임</h4>
									<input type="text" class="updateNickName" name="nickName"
										value="${vo.nickName }">
									<button class="btn btn-default submit" type="button"
										id="updateNickNameSubmit" name="submit">변경</button>
								</div>
							</div>
							<div class="col-sm-3">
								<p class="pStyle">회원등급</p>
								<p style="margin: 10px 0px 10px 20px;">${vo.gradeName }</p>
							</div>
							<div class="col-sm-3"></div>
						</div>

						<div id="emailDiv" style="padding-top: 10px;">
							<p class="pStyle">Email</p>
							<p style="margin: 10px 0px 10px 20px;">
								<span>${vo.email }</span>
								<c:if test="${vo.id == login.id || login.gradeNo == 9 }">
									<button id="updateEmailBtn" type="button" class="blackBtns">변경</button>
								</c:if>
							</p>
						</div>
						<div id="updateEmailDiv">
							<h4>변경할 이메일</h4>
							<input type="text" class="updateEmail" name="email"
								value="${vo.email }">
							<button class="btn btn-default submit" type="button"
								id="updateEmailSubmit">변경</button>
						</div>
						<hr>
						<p class="pStyle">휴대전화</p>
						<p style="margin: 10px 0px 10px 20px;">${vo.phone }</p>
						<hr>

						<p class="pStyle">회원가입일</p>
						<p style="margin: 10px 0px 10px 20px;">
							<fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd" />
						</p>
						<hr>

						<p class="pStyle">생년월일</p>
						<p style="margin: 10px 0px 10px 20px;">
							<fmt:formatDate value="${vo.birth }" pattern="yyyy-MM-dd" />
						</p>
						<hr>

						<div id="addressDiv">
							<p class="pStyle">주소</p>
							<p style="margin: 10px 0px 10px 20px;">
								<span>${vo.address }</span>
								<c:if test="${vo.id == login.id || login.gradeNo == 9 }">
									<button id="updateAddressBtn" type="button" class="blackBtns">변경</button>
								</c:if>
							</p>
						</div>
						<div id="updateAddressDiv">
							<div class="flex-container">
								<input type="text" id="zipCode" name="zipCode"
									placeholder="우편번호" class="form-inline"> <input
									type="button" onclick="sample6_execDaumPostcode()"
									value="우편번호 찾기"><br>
							</div>
							<div class="flex-container">
								<input type="text" id="address" name="address" placeholder="주소"><br>
								<input type="text" id="detailAddress" name="detailAddress"
									placeholder="상세주소"> <input type="text"
									id="sample6_extraAddress" placeholder="참고항목">
							</div>
							<button class="btn btn-default submit" type="button"
								id="updateAddressSubmit" name="submit">변경</button>
						</div>
						<hr>
					</form>
				</div>
			</div>
			<c:if test="${vo.gradeNo == 9 || vo.id == login.id }">
				<button type="button" id="findPWBtn" class="btn btn-primary"
					data-toggle="modal" data-target="#findPWModal">비밀번호 변경</button>
			</c:if>
			<c:if test="${vo.gradeNo == 9}">
				<a href="list.do" class="btn btn-default">회원 리스트</a>
				<a href="category.do" class="btn btn-default">카테고리 편집</a>
				<a href="brand.do" class="btn btn-default">브랜드 편집</a>
			</c:if>

		</div>
	</div>
	<div class="col-md-2"></div>

	<!-- changeImage Modal -->
	<div id="changePhotoModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">사진</h4>
				</div>
				<form action="changePhoto.do" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="id" value="${vo.id }">
					<div class="modal-body">
						<label>바꿀 사진 선택</label> <input name="changePhoto" type="file"
							class="form-control" id="changeImage" required>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-default">등록</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>

		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="findPWModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">비밀번호 변경</h4>
				</div>
				<div class="modal-body">
					<div id="changePwDiv">
						<form action="changePW.do" method="post" id="changePWForm"
							onsubmit="changePwSubmit()">
							<input type="hidden" id="id" name="id" value=${vo.id }> <label>변경
								할 비밀번호</label> <input type="password" id="pw" name="pw"> <label>비밀번호
								확인</label> <input type="password" id="pw2" name="pw2">
							<button class="btn btn-default">변경</button>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>