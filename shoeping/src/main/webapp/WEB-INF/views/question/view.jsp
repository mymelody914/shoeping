<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 리스트</title>
</head>
<body>
<div class="container">
	<div class="panel panel-default">
	  <div class="panel-body">
	  	${answerVO}
  		<span>${vo.content}</span>
	  </div>
	  <c:if test="${!empty answerVO}">
	  	<div class="panel-footer">
<%-- 	  		<%@ include file="../answer/view.jsp" %> --%>
	  	</div>
	  </c:if>
	  <c:if test="${empty answerVO}">
		<c:if test="${!empty login && login.gradeNo == 9}">
			<div class="panel-footer">
				<button type="button" class="btn btn-default aWriteBtn" data-toggle="modal" data-target="#aWriteModal">답변등록</button>
			</div>
		</c:if>
	  </c:if>
	</div>
	<a href="update.do?qno=${vo.qno}&itemNo=${vo.itemNo}" class="btn btn-default">수정</a>
	<a href="delete.do?qno=${vo.qno}&itemNo=${vo.itemNo}" class="btn btn-default">삭제</a>
	<a href="list.do" class="btn btn-default">리스트</a>
</div>

<!-- Modal -->
<div id="aWriteModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
    	<form action="/answer/write.do" method="post">
    		<input type="hidden" name="qno" value="${vo.qno}">
    		<input type="hidden" name="itemNo" value="${vo.itemNo}">
    		<input type="hidden" name="title" value="${vo.title}">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">답변 등록 폼</h4>
	      </div>
	      <div class="modal-body">
	        <textarea rows="3" name="content" class="form-control" id="modalContent"></textarea>
	      </div>
	      <div class="modal-footer">
	        <button class="btn btn-default">등록</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	      </div>
	    </form>
    </div>
  </div>
</div>
</body>
</html>