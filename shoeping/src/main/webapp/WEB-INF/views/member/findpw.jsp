<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style type="text/css">
#authenticateDiv {
	display: none;
}
</style>
<script type="text/javascript">
	$(function() {
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

		const myForm = document.getElementById('findPWForm');
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
		$('#findPWForm').submit(function(event) {
			const inputCode = $('.mail-check-input').val();
			if (inputCode !== code) {
				event.preventDefault(); // 인증번호가 일치하지 않으면 폼 제출을 막습니다.
				alert('인증번호를 확인해 주세요.');
			}
		});

		$("#checkEmail").click(function() {
			const email = $('#email').val();
			// alert(email);
			$.ajax({
				type : "get",
				url : "/ajax/findIDCheck.do?email=" + email,

				success : function(data) {
					console.log("data : " + data);
					// alert("data : " + data);

					if (data == 1) {
						alert("이메일 인증을 진행해 주세요.");
						$("#authenticateDiv").slideToggle();
					} else {
						alert("해당하는 이메일로 가입된 ID가 없습니다.");
					}
				}
			});
		});

		$("#findPWBtn").click(function() {
			$.ajax({
				url : '/ajax/findID.do',
				type : 'POST',
				data : {
					email : $('#email').val()
				},
				success : function(data) {
					alert(data);
					$("#id").val(data);
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
	<div class="container">
		<h2>비밀번호 찾기</h2>
		<form action="findPW.do" method="post" id="findPWForm">
			<label>Email *</label> <input type="text" id="email" name="email"
				class="form-control" placeholder="예) shoeping@gmail.com"
				autocomplete="off" required>
			<button class="btn btn-default" id="checkEmail" type="button">이메일
				확인</button>
			<div id="authenticateDiv">
				<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
				<input class="form-control mail-check-input"
					placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
				<span id="mail-check-warn"></span>
				<button type="button" id="findPWBtn" class="btn btn-primary"
					data-toggle="modal" data-target="#findPWModal">찾기</button>
			</div>
		</form>
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
							<input type="hidden" id="id" name="id"> <label>변경
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