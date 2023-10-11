<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 리스트</title>
<style type="text/css">
.dataRow:hover{
	cursor: pointer;
}
.viewToggle{
	display: none;
}
#titleRow{
	height: 40px;
	background: #e8e8e8;
	margin: auto;
	padding-top: 10px;
	padding-bottom: 10px;
	font-weight: bolder;
}
#rowStyle{
	height: 40px;
	margin: auto;
	padding-top: 10px;
	padding-bottom: 10px;
	border-bottom: 1px dotted #e8e8e8;
}
.viewToggle{
	border-bottom: 1px dotted #e8e8e8;
}
.qWriteBtn{
	margin-top: 10px;
}
#notQlist{
	height: 40px;
	padding: 10px;
	border-bottom: 1px dotted #e8e8e8;
}
</style>
<script type="text/javascript">
$(function(){

	$(document).on('click', '#qDeleteBtn, #aDeleteBtn', function(){
	    if(!confirm("정말 삭제하시겠습니까?")) return false;
	});
	
    $(".dataRow > .row").click(function(){
        // 클릭한 요소에 대한 참조를 변수에 저장
        var $clickedRow = $(this);
        
        let qno = $clickedRow.find(".qno").text();
        let pw = $clickedRow.find(".pw").text();
        var id = "${login.id}";
	    console.log(qno+"/"+pw+"/"+id);
      	if(${empty login} && pw==1){
			alert("로그인을 해주세요.");
			return false;

          }
    	 
        var qnaData;
        var answerData;
        var login;
        var grade;
       
        $.ajax({
            url: "/questionajax/view.do?", // 컨트롤러 URL을 입력하세요.
            type: "GET", // 또는 "POST" 등 요청 방식을 선택하세요.
            dataType: "json", // "json" 또는 "html"
            data: { qno: qno, pw: pw }, // 전송할 데이터
            success: function(result) {
                // 서버로부터 받은 응답을 처리합니다.
                // model 변수에 서버 응답이 저장됩니다.
                console.log(result.vo);

                qnaData = result.vo;
                answerData = result.answerVO;
                login = result.login;
                grade = result.grade;
                voview = result.voview;

                console.log(qnaData);
                console.log(answerData);
                console.log(login);
                console.log(grade);
                console.log(voview);
                

                // 클릭한 qno에 해당하는 viewToggle 요소 선택
                var $viewToggle = $clickedRow.next(".viewToggle");

            	// 비밀글이고 본인의 글이 아닐경우 볼수 없음
                if(voview != null){
                	alert('비공개 문의내역은 작성자 본인만 확인하실 수 있습니다.');
                	return false;
                } else {
	                $(".answerView").html(`
	                        <div>
		                        <div class="row">
		                        	<div class="col-sm-1"></div>
		                        	<div class="col-sm-10">
		                        		<div style="padding-top: 30px; padding-bottom: 30px;">
			                        		<div style="word-break:keep-all; word-wrap:break-word;  margin-bottom: 30px;">
			                        			${ "${qnaData.content}" }
			                        		</div>
			                        		<div class="qnaBtns" style="margin-top: 10px; margin-bottom: 10px;">
				                        	</div>
										<div>
										<div class="answer" style="border-top: 1px solid #e8e8e8; border-bottom: 1px solid #e8e8e8; 
											background: #f6f6f6; padding: 15px; margin-bottom: 10px;">
							            <div>
				                    <div>
		                        	<div class="col-sm-1"></div>
		                        <div>
		                    </div>
		                    
						`);
					if(login != null){
						if(login == qnaData.id){
							// console.log("아이디 확인");
							$(".qnaBtns").html(`
	                    		<button type="button" class="btn btn-default qUpdateBtn" data-toggle="modal"
									data-target="#qUpdateModal">수정</button>
		                		<a href="/question/delete.do?qno=${ '${qnaData.qno}' }&itemNo=${ '${qnaData.itemNo}' }"
		                    		class="btn btn-default" id="qDeleteBtn">삭제</a>
							`)
						} else if (grade != null) {
							$(".qnaBtns").html(`
		                		<a href="/question/delete.do?qno=${ '${qnaData.qno}' }&itemNo=${ '${qnaData.itemNo}' }" 
		                    		class="btn btn-default" id="qDeleteBtn">삭제</a>
							`)
							
						}
					}
					if(answerData.ano != null){
						// 타임스탬프를 'YYYY-MM-DD' 형식의 날짜 문자열로 변환하는 함수
						function timestampToDateString(timestamp) {
						    const date = new Date(timestamp); // 밀리초 단위의 타임스탬프를 사용합니다.
						    const year = date.getFullYear();
						    const month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1을 하고 두 자리로 포맷팅합니다.
						    const day = String(date.getDate()).padStart(2, '0'); // 일자를 두 자리로 포맷팅합니다.
						    return `${ "${year}" }-${ "${month}" }-${ "${day}" }`;
						}
						
						// 예시 타임스탬프를 'YYYY-MM-DD' 형식의 날짜로 변환
						const timestamp = answerData.writeDate; // 예시 타임스탬프 (밀리초 단위)
						const dateString = timestampToDateString(timestamp);
						console.log(dateString); // 출력 예: '2023-03-01'
						
						$(".answer").html(`
								<span style="font-weight: bolder; font-size: 15px;">답변</span>
					            <span class="glyphicon glyphicon-calendar pull-right">${ "${dateString}" }</span>
					            <hr>
					            <div style="padding-top: 30px; padding-bottom: 30px; word-break:keep-all; word-wrap:break-word;">
					            	${ "${answerData.content}" }
					            </div>
								<div class="answerudBtn">
									
								</div>
								`);
						if(login != null && grade != null){
							$(".answerudBtn").html(`
								<button type="button" class="btn btn-default aUpdateBtn" data-toggle="modal"
									data-target="#aUpdateModal">수정</button>
								<a href="/answer/delete.do?qno=${ '${answerData.qno}' }
									&ano=${ '${answerData.ano}' }&itemNo=${ '${answerData.itemNo}' }"
									class="btn btn-default" id="aDeleteBtn">삭제</a>
							`)
						}
					} else {
						if(login != null && grade != null){
							$(".answer").html(`
								<button type="button" class="btn btn-default aWriteBtn" data-toggle="modal" data-target="#aWriteModal">
									답변등록
								</button>
							`);
						} else{
							$(".answer").html("답변이 아직 없습니다.");
						}
					}
					
	                $("#qUpdateModal").find(".modal-content").html(`
	                	<form action="/question/update.do" method="post">
	                		<input type="hidden" name="qno" value="${ '${qnaData.qno}' }">
	                		<input type="hidden" name="itemNo" value="${ '${qnaData.itemNo}' }">
	            	      <div class="modal-header">
	            	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	            	        <h4 class="modal-title">질문 수정 폼</h4>
	            	      </div>
	            	      <div class="modal-body">
	            	      	<div style="padding-bottom: 10px;">
			          			<label class="radio-inline"><input type="radio" name="pw" id="pw" value="0">일반글</label>
			          			<label class="radio-inline"><input type="radio" name="pw" id="pw" value="1">비밀글</label>
	          				</div>
			          		<div class="form-group">
			          			<label for="title">제목</label>
			          			<input class="form-control" name="title" id="title" required value="${ '${qnaData.title}' }"
			          				pattern="^.{3,100}$" title="3자 이상 100자 이내로 작성하셔야 합니다." maxlength="100">
			          		</div>
			          		<div class="form-group">
			          			<label for="content">내용</label>
			          			<textarea rows="5" class="form-control" name="content" id="content" required
			          			 title="내용을 입력해 주세요." style="resize: none;">${ '${qnaData.content}' }</textarea>
			          		</div>
	            	      </div>
	            	      <div class="modal-footer">
	            	        <button class="btn btn-default">수정</button>
	            	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	            	      </div>
	            	    </form>
	                `);


	             	// 기존 dealStatus 값을 세팅
	        		var previousDealStatus = pw;
	        		console.log("pw는?" + previousDealStatus);
	        		
	        		
	        		var radioButtons = document.querySelectorAll('input[type="radio"]');

	        		radioButtons.forEach(function(radioButton) {
	        		  if (radioButton.value === previousDealStatus) {
	        		    radioButton.checked = true;
	        		  }
	        		});
                }

                $(".viewToggle").not($viewToggle).slideUp();
                // 해당 viewToggle 요소가 보이는지 숨겨져 있는지 확인하여 슬라이드 토글
                $viewToggle.slideToggle();
               
            },
            error: function(xhr, status, error) {
                // 오류 처리
                console.error("오류 발생: " + error);
            }
        });
    });
});
</script>
</head>
<body>
<div class="container">
<h1>문의</h1>
	<div>
		<div class="row" id="titleRow">
			<div class="col-sm-2 text-center">답변여부</div>
			<div class="col-sm-5 text-center">제목</div>
			<div class="col-sm-2 text-center">작성자</div>
			<div class="col-sm-1 text-center">번호</div>
			<div class="col-sm-2 text-center">작성일</div>
		</div>
		<c:if test="${empty list}">
			<div class="row">
				<div class="col-sm-12 text-center">
					<div id="notQlist">문의가 아직 없습니다.</div>
				</div>
			</div>
		</c:if>
		<c:forEach items="${list}" var="listVO">
			<div class="dataRow">
				<div class="row" id="rowStyle">
					<div class="col-sm-2 text-center">
					
						<c:if test="${listVO.ano != null}">
							답변완료
						</c:if>
						<c:if test="${listVO.ano == null}">
							미답변
						</c:if>
					</div>
					<div class="col-sm-5 text-center">
						<c:if test="${listVO.pw == 1 }">
						 	<span class="glyphicon glyphicon-lock"></span>
						</c:if>
						${listVO.title}
					</div>
					<div class="col-sm-2 text-center">${listVO.id}</div>
					<div class="col-sm-1 text-center qno" id="qno">${listVO.qno}</div>
					<div class="col-sm-2 text-center"><fmt:formatDate value="${listVO.writeDate}" pattern="yyyy-MM-dd"/></div>
					<div class="pw" style="display: none;">${listVO.pw}</div>
				</div>
				<div class="viewToggle">
				 <div class="answerView">
				 </div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<!-- qUpdateModal -->
<div id="qUpdateModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
    	
    </div>
  </div>
</div>
</body>
</html>