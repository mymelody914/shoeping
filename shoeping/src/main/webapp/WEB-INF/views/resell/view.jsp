<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리셀 상세 페이지</title>
   <style>
   
   




@media screen and (max-width: 1260px) {
    .back {
        width: 50%;
    }
}

@media screen and (max-width: 840px) {
    .back {
        width: 100%;
    }
}

.button_base {
    margin: 0;
    border: 0;
    font-size: 18px;
    position: relative;
    top: 50%;
    left: 50%;
    margin-top: -25px;
    margin-left: -100px;
    width: 400px;
    height: 100px;
    text-align: left;
    box-sizing: border-box;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-user-select: none;
    cursor: default;
}

.button_base:hover {
    cursor: pointer;
}
        /* 전체 화면 스타일 */
        body, html {
            height: 100%;
            margin: 0;
            
        }

        #fullscreen-image {
            display: flex;
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.1);
            z-index: 1;
            
        }

        #fullscreen-image img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        
        
        /* ### ### ### 08 */
.b08_3d_pushback {
    perspective: 500px;
    -webkit-perspective: 500px;
    -moz-perspective: 500px;
    transform-style: preserve-3d;
    -webkit-transform-style: preserve-3d;
}

.b08_3d_pushback div {
    position: absolute;
    text-align: center;
    width: 100%;
    height: 50px;
    box-sizing: border-box;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    pointer-events: none;
    padding: 10px;
    border: #000000 solid 1px;
}

.b08_3d_pushback div:nth-child(1) {
    color: #000000;
    background-color: #ffffff;
    transform: rotateX(0deg) translateZ(0px);
    -webkit-transform: rotateX(0deg) translateZ(0px);
    -moz-transform: rotateX(0deg) translateZ(0px);
    transform-origin: 50% 50%;
    -webkit-transform-origin: 50% 50%;
    -moz-transform-origin: 50% 50%;
    transition: all 0.2s ease;
    -webkit-transition: all 0.2s ease;
    -moz-transition: all 0.2s ease;
}

.b08_3d_pushback div:nth-child(2) {
    color: #ffffff;
    background-color: #000000;
    transform: rotateX(-179.5deg) translateZ(1px);
    -webkit-transform: rotateX(-179.5deg) translateZ(1px);
    -moz-transform: rotateX(-179.5deg) translateZ(1px);
    transform-origin: 50% 50%;
    -webkit-transform-origin: 50% 50%;
    -moz-transform-origin: 50% 50%;
    transition: all 0.2s ease;
    -webkit-transition: all 0.2s ease;
    -moz-transition: all 0.2s ease;
}

.b08_3d_pushback:hover div:nth-child(1) {
    transition: all 0.2s ease;
    -webkit-transition: all 0.2s ease;
    -moz-transition: all 0.2s ease;
    transform: rotateX(179.5deg);
    -webkit-transform: rotateX(179.5deg);
    -moz-transform: rotateX(179.5deg);
}

.b08_3d_pushback:hover div:nth-child(2) {
    transition: all 0.2s ease;
    -webkit-transition: all 0.2s ease;
    -moz-transition: all 0.2s ease;
    transform: rotateX(0deg) rotateY(0deg) translateZ(1px);
    -webkit-transform: rotateX(0deg) rotateY(0deg) translateZ(1px);
    -moz-transform: rotateX(0deg) rotateY(0deg) translateZ(1px);
}


    </style>
    <style type="text/css">
    
    
   

.box h3 {
  text-align:center;
    position:relative;
    top:80px;
}
.box {
    width:70%;
    height:450px;
    background:#edebeb;
    margin:40px auto;
}
    
    .effect2 {
  position: relative;
}
.effect2:before, .effect2:after {
  z-index: -1;
  position: absolute;
  content: "";
  bottom: 15px;
  left: 10px;
  width: 50%;
  top: 80%;
  max-width:300px;
  background: #777;
  -webkit-box-shadow: 0 15px 10px #777;
  -moz-box-shadow: 0 15px 10px #777;
  box-shadow: 0 15px 10px #777;
  -webkit-transform: rotate(-3deg);
  -moz-transform: rotate(-3deg);
  -o-transform: rotate(-3deg);
  -ms-transform: rotate(-3deg);
  transform: rotate(-3deg);
}
.effect2:after
{
  -webkit-transform: rotate(3deg);
  -moz-transform: rotate(3deg);
  -o-transform: rotate(3deg);
  -ms-transform: rotate(3deg);
  transform: rotate(3deg);
  right: 10px;
  left: auto;
}


    
    </style>
    
    <script>
$(document).ready(function() {
    // 페이지 로드 시 전체 화면 이미지 보여주기
    var fullscreenImage = $('#fullscreen-image');

    // 전체 화면 이미지 보이기
    fullscreenImage.fadeIn();

    // 일정 시간 후 전체 화면 이미지 숨기기 (예: 3초 후)
    setTimeout(function () {
        fullscreenImage.fadeOut();
    }, 2000); // 3초 후 숨김 (원하는 시간으로 조정 가능)
    
});


$(function(){
	$(".buyButton").click(function(){
		location=""
	})	
})

</script>
</head>
<body>
<div class="container">
<h1 style="text-align: center;font-weight:bold;">${vo.resellName }</h1><br>
<h2 style="text-align: center;">(주)${vo.brand }</h2>
<h3 style="text-align: center;">${vo.category }</h3><br><br>
<c:choose>
    <c:when test="${vo.brand == '나이키' }">
        <div id="fullscreen-image">
            <img alt="${vo.fileName}" src="/resources/assets/images/nike.png">
        </div>
    </c:when>
    <c:when test="${vo.brand == '아디다스' }">
        <div id="fullscreen-image">
            <img alt="${vo.fileName}" src="/resources/assets/images/adidas.png">
        </div>
    </c:when>
    <c:when test="${vo.brand == '뉴발란스' }">
        <div id="fullscreen-image">
            <img alt="${vo.fileName}" src="/resources/assets/images/newBalance.png">
        </div>
    </c:when>
    <c:otherwise>
    
    </c:otherwise>
</c:choose>

<img alt="" src="${vo.fileName }" style="display: block; margin: 0 auto; width:1000px;"><br><br><br>

<div style="text-align: center;">
  <h3 style="display: inline; ">size :   </h3><h1 style=" font-weight: bold; display: inline;">${vo.sizes}</h1><br><br><br>
</div>
<div style="text-align: center;">
  <h3 style="display: inline; ">color :   </h3><h1 style=" font-weight: bold; display: inline;">${vo.color}</h1><br><br><br>
</div>
<div style="text-align: center;">
  <h3 style="display: inline; ">Resell Price :   </h3><h1 style=" font-weight: bold; display: inline;">${vo.resellPrice}</h1><br><br><br><br>
</div>






<div style="margin-left: 130px;">
<div class="back buyButton" style="display: inline-block; margin-right: 10px; margin-left: 60px;">
    <div class="button_base b08_3d_pushback">
        <div>구매하기</div>
        <div>BUY PRODUCT</div>
    </div>
</div>

<div class="back sellButton" style="display: inline-block; margin-right: 10px; margin-left: 200px;">
    <div class="button_base b08_3d_pushback">
        <div>판매하기</div>
        <div>SELL PRODUCT</div>
    </div>
    </div>
</div><br><br><br><br><br><br><br><br><br><br><br><br><br>



<div class="box effect2">
<h4 style="margin: 0 30px ; text-align: center; "> <br><br>ShoePing Resell 약관 <br><br><br>
제1장 총칙
제 1 조 (목적)
이 약관은 (주)슈핑(이하 "회사"라 합니다)이 제공하는 웹사이트 및 리셀  서비스(이하 "리셀"이라 합니다)의 이용조건 및 절차, 기타 필요한 사항을 규정함을 목적으로 합니다.
제 2 조 (약관의 효력과 변경)
① 이 약관은 그 내용을 회사가 웹사이트 및 게시글에 게시하거나 기타의 방법으로 회원에게 공지함으로써 그 효력이 발생합니다.
② 회사는 합리적인 사유가 있는 경우 이 약관을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 게시 또는 공지함으로써 효력이 발생합니다.
③ 회원은 변경된 약관에 동의하지 않으면 언제든지 서비스 이용을 중단하고 이용계약을 해지할 수 있습니다. 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주됩니다.
제 3 조 (약관 외 준칙)
이 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신망 이용촉진 등에 관한 법률, 전자거래기본법, 전자서명법 및 기타 관련 법령의 규정에 따릅니다.
제 4 조 (용어의 정의)
① 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
1.회원 : 회사와 서비스 이용에 관한 계약을 체결하고 이용자 아이디를 부여 받은 자
2.아이디(ID) : 회원 식별과 회원의 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 문자, 숫자 또는 양자의 조합
3.비밀번호 : 회원의 본인 확인과 비밀 보호를 위해 회원 자신이 설정한 문자, 숫자 또는 양자의 조합
4.이용계약 : 서비스를 제공받기 위하여 이 약관으로 회사와 회원 간에 체결하는 계약
5.해지 : 회사 또는 회원이 서비스 개통 후 이용계약을 해약하는 것
6.운영자 : 서비스의 전반적인 관리와 원활한 운영을 위하여 회사에서 선정한 사람
② 제1항의 용어를 제외한 용어의 정의는 거래 관행 및 관계 법령에 따릅니다.

</h4>

</div>

<c:if test="${login.gradeNo == 9 }">
<a href="update.do?resellNo=${vo.resellNo }"><button class="btn btn-default pull-right">수정</button></a>
<a href="delete.do?resellNo=${vo.resellNo }&fileName=${vo.fileName}"><button class="btn btn-default pull-right">삭제</button></a>
</c:if>
</div>
</body>
</html>