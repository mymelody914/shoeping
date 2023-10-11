<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register Form</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/resources/js/regEx.js?v=3"></script>
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
	// 전화번호 양식 자동완성
	function oninputPhone(target) {
		target.value = target.value.replace(/[^0-9]/g, '').replace(
				/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g,
				"$1-$2-$3");
	}

	
	
	let isIdDuplicated = false;
	// 아이디 체크
	function checkIdFunc() {
		const id = $("#id").val();

		// 아이디에 입력이 되어 있을 경우
		if (id !== '') {
			$("#checkId").css("display", "");
			if (!checkData(reg_id, $("#id"), 1)) {
				$("#checkId").css("background-color", "tomato");
				$("#checkId").text(reg_id_error_msg);
			} else {
				// 아이디 중복 체크 요청
				$
						.ajax({
							url : '/ajax/checkId.do',
							type : 'GET',
							data : {
								id : id
							},
							success : function(data) {
								let result = data;
								if (result == 0) {
									$("#checkId").css("background-color",
											"lightgreen");
									$("#checkId").text("사용 가능한 아이디 입니다.");
									$("#submitDiv").hide();
									$("#submit").show();
								} else {
									$("#checkId").css("background-color",
											"tomato");
									$("#checkId").text("이미 존재하는 아이디 입니다.");
									$("#submitDiv").css("background-color", "tomato");
									$("#submitDiv").text("아이디 중복체크를 확인 해 주세요.");
									$("#submit").hide();
								}
							},
							error : function() {
								console.log("아이디 중복 검사 중 오류가 발생했습니다.");
							}
						});
			}
		}
		// 아이디에 입력이 안되어 있을 경우
		else {
			$("#checkId").css("display", "none");
		}
	}

	
	
	$(function() {
		$("#birth").datepicker(
				{
					changeMonth : true,
					changeYear : true,
					dateFormat : "yy-mm-dd",
					dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
					monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월",
							"7월", "8월", "9월", "10월", "11월", "12월" ],
					yearRange : "1923:2023"
				});

		$(document).on("keydown keypress", function(event) {
	        if (event.key === "Enter") {
	            event.preventDefault();
	            return false;
	        }
	    });
	    
		// 이메일 인증
		$('#mail-Check-Btn').click(function() {
			const email = $('#email').val();
			console.log('완성된 이메일 : ' + email);
			const checkInput = $('.mail-check-input');

			$.ajax({
				type : "get",
				url : "/member/mailCheck?email=" + email,

				success : function(data) {
					console.log("data : " + data);
					checkInput.attr('disabled', false);
					code = data;
					alert('인증번호가 전송되었습니다.')
				}
			});
		});

		const myForm = document.getElementById('registerForm');
		// 인증번호 비교 
		// blur -> focus가 벗어나는 경우 발생
		$('.mail-check-input').blur(function() {
			const inputCode = $(this).val();
			const $resultMsg = $('#mail-check-warn');

			if (inputCode === code) {
				$resultMsg.html('인증번호가 일치합니다.');
				$resultMsg.css('color', 'green');
				$('#mail-Check-Btn').attr('disabled', true);
				$('#email').attr('readonly', true);
			} else {
				$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
				$resultMsg.css('color', 'red');

			}
		});

		// 인증번호 틀릴시 폼 제출 막기
		$('#registerForm').submit(function(event) {
			const inputCode = $('.mail-check-input').val();
			if (inputCode !== code) {
				event.preventDefault(); // 인증번호가 일치하지 않으면 폼 제출을 막습니다.
				alert('인증번호를 확인해 주세요.');
			} 
		});

	});
</script>
</head>
<body>
	<div class="container">
		<h2>회원 가입</h2>
		<form action="register.do" method="post" id="registerForm">
			<div class="form-group">
				<h4>ID *</h4>
				<input type="text" class="form-control" id="id" name="id"
					autocomplete="off" required maxlength="20">
				<button type="button" class="btn btn-default"
					onclick="checkIdFunc();">아이디 확인</button>
			</div>
			<div id="checkId"></div>
			<div class="form-group">
				<h4>Password *</h4>
				<input type="password" class="form-control" id="pw" name="pw"
					autocomplete="off" required>
			</div>
			<div class="form-group">
				<h4>닉네임 *</h4>
				<input type="text" class="form-control" id="nickName"
					name="nickName" autocomplete="off" required maxlength=15
					placeholder="">
			</div>
			<div id="checkNickname"></div>
			<div class="form-group">
				<label>Email *</label> <input type="text" id="email" name="email"
					class="form-control" placeholder="예) shoeping@gmail.com"
					autocomplete="off" required>
				<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
				<input class="form-control mail-check-input"
					placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
				<span id="mail-check-warn"></span>
			</div>

			<div class="form-group">
				<h4>이름 *</h4>
				<input type="text" id="name" name="name" class="form-control"
					autocomplete="off" required>
			</div>
			<div class="form-inline">
				<h4>전화번호 *</h4>
				<input type="text" id="phone" name="phone" class="form-control"
					autocomplete="off" required oninput="oninputPhone(this)"
					placeholder="예) 010-0000-0000" maxlength="14">
			</div>
			<div class="form-inline">
				<h4>생년월일 *</h4>
				<input id="birth" name="birth" class="form-inline form-control"
					placeholder="YYYY-MM-DD" required="required" autocomplete="off">
				<br>
			</div>

			<div class="flex-container">
				<input type="text" id="zipCode" name="zipCode" placeholder="우편번호"
					class="form-inline"> <input type="button"
					onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			</div>
			<div class="flex-container">
				<input type="text" id="address" name="address" placeholder="주소"><br>
				<input type="text" id="detailAddress" name="detailAddress"
					placeholder="상세주소"> <input type="text"
					id="sample6_extraAddress" placeholder="참고항목">
			</div>
			<div id="submitDiv">
				<br>
			</div>
			<button class="btn btn-default" id="submit" type="submit">회원가입</button>
		</form>
	</div>
</body>
</html>