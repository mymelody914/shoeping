<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resell List</title>
<style type="text/css">

.e{
  position: absolute;
  left:50%;

  transform:translate(-50%,-50%);
}
h1{
  font-size:60px;
  font-weight:bold;
  font-family: 'Montserrat', sans-serif;
  text-align:center;
  color:#black;
  letter-spacing:0px;
  transition:1s;
  -webkit-transition:1s;
  -ms-transition:1s;
  position: relative;
  padding:10px;
 
}

h1:before,
h1:after{
  content:"";
  position: absolute;
  height: 7px;
  width: 0px;
  background:gray;
  transition:300ms;
  -webkit-transition:1s;
  -ms-transition:1s;
  opacity:0.3;
  left:50%;
}

h1:before{
  bottom:0;
 
}

h1:after{
  top:0;
  
}

h1:hover{
  letter-spacing:30px;
}

h1:hover:before,
h1:hover:after{
   width: 95%;
    opacity:1;
  left:0;

}
h1:hover ~ h2{
  opacity:0;
}

h2{
  color:#fff;
  font-family: 'Pinyon Script', cursive;
  text-align:center;
  font-size:100px;
  font-weight:100;
  bottom:40px;
  position: absolute;
  transition:1s;
  -webkit-transition:1s;
  -ms-transition:1s;
  opacity:0.1;
  width: 100%;
}

.title{
font-size: x-large;
font-weight: bolder;
}

.product:hover {
    transform: scale(1.02); /* 10% 확대 효과 (원하는 크기로 조절 가능) */
    transition: transform 0.3s ease; /* 부드러운 애니메이션 효과 적용 */
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3); /* 그림자 효과 추가 */
   	cursor: pointer;
}
.fixed-image {
  width: 300px; /* 원하는 너비로 조정 */
  height: 300px; /* 높이를 자동으로 조정하여 가로세로 비율 유지 */
  float: left;
  margin-right: 20px;
}

</style>
<script>
   $(function(){
	  $(".product").click(function(){
		  let resellNo = $(this).data("no");
		  console.log(resellNo);
		  location="view.do?resellNo="+resellNo
	  });
   });
</script>

</head>
<body>
<div class="container">
<h1 class="e" style="text-align: center;"> Resell List </h1><br><br><br><br><br><br><br><br><br><br>
<c:forEach items="${list}" var="vo">
    <div class="product" data-no="${vo.resellNo }">
    
            <div class="title">${vo.resellName}</div>
    <hr style="height: 5px; background-color: black;">
        <img class="fixed-image" alt="${vo.fileName}" src="${vo.fileName }" style="float: left; margin-right: 20px;">
        <div class="item-info">
            <div><strong style="color: gray;">${vo.category }</strong></div>
            <div><strong style="color: gray;" id="brand">${vo.brand}&nbsp;
            </strong></div><br><br>
            <div><h3>ModelName :  ${vo.resellModelName }</h3></div>
            <div><h3>size :  ${vo.sizes }</h3></div>            
            <div><h3>color : ${vo.color }</h3></div><br><br><br><br>
                     
            <div class="countDate" style="text-align: right;" data-dday="${vo.dday }">남은기한 :  </div>
        </div>
    </div>
        <div style="clear: both;"></div><br><br><br><br><br>
</c:forEach>

<c:if test="${login.gradeNo == 9 }">
<a href="write.do" >
<button class="btn btn-default pull-right"> 등록</button>
</a>
</c:if>

</div>











<script>
function counter() {
	  $(".countDate").each(function() {
	    var userInput = $(this).data("dday"); // 해당 요소의 종료 날짜 가져오기

	    // "yyyy-mm-dd" 형식의 입력을 Date 객체로 변환합니다.
	    var dateParts = userInput.split("-");
	    var year = parseInt(dateParts[0], 10);
	    var month = parseInt(dateParts[1], 10) - 1; // 월은 0부터 시작하므로 1을 빼줍니다.
	    var day = parseInt(dateParts[2], 10);

	    var dday = new Date(year, month, day);

	    var $countDate = $(this); // 현재 처리 중인 요소 가져오기

	    setInterval(function() {
	      var now = new Date(); // 현재 날짜 가져오기
	      var distance = dday - now;
	      var d = Math.floor(distance / (1000 * 60 * 60 * 24));
	      var h = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	      var m = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	      var s = Math.floor((distance % (1000 * 60)) / 1000);
	      var view = '';
	      if (s < 10) {
	        s = '0' + s;
	      }
	      if (distance < 0) {
	        $countDate.html('마감되었습니다.');
	        $countDate.hide();
	      } else {
	        if (d > 0) {
	          view = view + d + '일 ';
	        }
	        if (h > 0) {
	          view = view + h + '시간 ';
	        }
	        if (m > 0) {
	          view = view + m + '분 ';
	        }
	        $countDate.html('시즌 종료까지 남은기한 : ' + view + s + '초');
	      }
	    }, 1000);
	  });
	}

	counter();
</script>
</body>
</html>