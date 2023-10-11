<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="pageObject" required="true"
 type="com.webjjang.util.page.ReplyPageObject" %>
<%@ attribute name="listURI" required="true"
 type="java.lang.String" %>
<%@ attribute name="query" required="false"
 type="java.lang.String" %> 

<% /** PageNation을 위한 사용자 JSP 태그  *
	 * 작성자 웹짱 이영환 강사 
	 * 작성일 2023.07.27
	 * 버전 5.0
	 
	 *   - replyPageObject 안에 pageObject변수와 replyPageObject 변수가 들어 있다.
	 *   - listURI="view.do"
	 * 사용방법 :<pageObject:replyPageNav listURI="호출 일반 게시판 글보기 URL"
	 			pageObject= "웹짱 댓글 페이지 객체" query="페이지 정보 외 다른 전달 데이터" />
   */ %>

<% request.setAttribute("noLinkColor", "#999"); %>
<% request.setAttribute("tooltip", " data-toggle=\"tooltip\" data-placement=\"top\" "); %>
<% request.setAttribute("noMove", " title=\"no move page!\" "); %>

<ul class="pagination">
  	<li data-page=1>
		<c:if test="${pageObject.replyPageObject.page > 1 && empty query}">
			<!-- 맨 첫페이지로 이동 : query가 없는 경우 - 일반 게시판 페이지 처리 -->
	  		<a href="${listURI }?no=${pageObject.no}&${pageObject.pageObject.pageQuery}&replyPage=1&${pageObject.notPageQuery}${query}"
	  		  title="click to move first page!" ${tooltip } >
	  			<i class="glyphicon glyphicon-fast-backward"></i>
	  		</a>
  		</c:if>
		<c:if test="${pageObject.replyPageObject.page == 1 }">
	  		<a href="" onclick="return false"
	  		 ${noMove }  ${tooltip } >
	  			<i class="glyphicon glyphicon-fast-backward" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</c:if>
	</li>
	
	
	<li data-page=${pageObject.replyPageObject.startPage -1 }>
		<c:if test="${pageObject.replyPageObject.startPage > 1 }">
	  		<a href="${listURI }?no=${pageObject.no}&${pageObject.pageObject.pageQuery}&replyPage=${pageObject.replyPageObject.startPage - 1 }&${pageObject.notPageQuery}${query}"
	  		  title="click to move previous page group!" ${tooltip } >
	  			<i class="glyphicon glyphicon-step-backward"></i>
	  		</a>
	  	</c:if>
		<c:if test="${pageObject.replyPageObject.startPage == 1 }">
	  		<a href="" onclick="return false"
	  		 ${noMove } ${tooltip }>
	  			<i class="glyphicon glyphicon-step-backward" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</c:if>
  	</li>
	<c:forEach begin="${pageObject.replyPageObject.startPage }" end="${pageObject.replyPageObject.endPage }" var="cnt">
  	<li ${(pageObject.replyPageObject.page == cnt)?"class=\"active\"":"" } 
  	 data-page=${cnt }>
  	 	<!-- 페이지와 cnt가 같으면 링크가 없음 -->
  	 	<c:if test="${pageObject.replyPageObject.page == cnt }">
  			<a href="" onclick="return false"
  			 ${noMove } ${tooltip }>${cnt}</a>
  	 	</c:if>
  	 	<!-- 페이지와 cnt가 같지 않으면 링크가 있음 -->
  	 	<c:if test="${pageObject.replyPageObject.page != cnt }">
  			<a href="${listURI }?no=${pageObject.no}&${pageObject.pageObject.pageQuery}&replyPage=${cnt }&${pageObject.notPageQuery}${query}"
	  		 title="click to move ${cnt } page" ${tooltip }>${cnt}</a>
  		</c:if>
  	</li>
	</c:forEach>
	<c:if test="${pageObject.replyPageObject.endPage < pageObject.replyPageObject.totalPage }">
	  	<li data-page=${pageObject.replyPageObject.endPage + 1 }>
	  		<a href="${listURI }?no=${pageObject.no}&${pageObject.pageObject.pageQuery }&replyPage=${pageObject.replyPageObject.page + 1}&${pageObject.notPageQuery}${query}"
	  		  title="click to move next page group!" ${tooltip } >
	  			<i class="glyphicon glyphicon-step-forward"></i>
	  		</a>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.replyPageObject.endPage == pageObject.replyPageObject.totalPage }">
	  	<li data-page=${pageObject.pageObject.endPage }>
	  		<a href="" onclick="return false"
	  		 ${noMove }  ${tooltip } >
	  			<i class="glyphicon glyphicon-step-forward" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.replyPageObject.page < pageObject.replyPageObject.totalPage }">
	  	<li data-page=${pageObject.pageObject.totalPage }>
	  		<a href="${listURI }?no=${pageObject.no}&${pageObject.pageObject.pageQuery }&replyPage=${pageObject.replyPageObject.totalPage}&${pageObject.notPageQuery}${query}"
	  		  title="click to move last page!" ${tooltip } >
		  		<i class="glyphicon glyphicon-fast-forward"></i>
	  		</a>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.replyPageObject.page == pageObject.replyPageObject.totalPage }">
	  	<li data-page=${pageObject.replyPageObject.totalPage }>
	  		<a href="" onclick="return false"
	  		 ${noMove }  ${tooltip } >
		  		<i class="glyphicon glyphicon-fast-forward" style="color: ${noLinkColor};"></i>
	  		</a>
	  	</li>
  	</c:if>
</ul> 

<script>
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();
  $(".pagination").mouseover(function(){
//   		$(".tooltip > *:last").css({"background-color": "red", "border": "1px dotted #444"});   
	});
});
</script>
