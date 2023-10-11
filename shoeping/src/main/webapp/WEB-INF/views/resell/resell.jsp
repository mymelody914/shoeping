<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.image1 {
    background-image: url('/resources/assets/images/resell1.jpg');
    background-attachment: fixed;
    width: 100%;
    height: 100vh;
    position: relative;
    background-size: cover;
    background-repeat: no-repeat;
}

.image2 {
    background-image: url('/resources/assets/images/resell2.jpg');
    background-attachment: fixed;
    width: 100%;
    height: 100vh;
    position: relative;
    background-size: cover;
    background-repeat: no-repeat;
}

.image3 {
    background-image: url('/resources/assets/images/resell5.jpg');
    background-attachment: fixed;
    width: 100%;
    height: 100vh;
    position: relative;
    background-size: cover;
    background-repeat: no-repeat;
}

.text1 {
    display: flex;
   	height: 150px;
    justify-content: center;
    align-items: center;
    text-align: center;
    color: black;
    background: white;
    font-size: 1.1rem;
}

.row {
        margin-left: 30%; /* 왼쪽 공백 크기 조절 */
        margin-right: 30%; /* 오른쪽 공백 크기 조절 */
    }
@import url('https://fonts.googleapis.com/css?family=Roboto+Condensed');

.preserve-3d {
    transform-style: preserve-3d;
    -webkit-transform-style: preserve-3d;
}

.back:before {
    position: absolute;
    padding: 10px;
}

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
    width: 200px;
    height: 50px;
    text-align: center;
    box-sizing: border-box;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-user-select: none;
    cursor: default;
}

.button_base:hover {
    cursor: pointer;
}

/* ### ### ### 03 */
.b03_skewed_slide_in {
    overflow: hidden;
    border: #000000 solid 1px;
}

.b03_skewed_slide_in div {
    position: absolute;
    text-align: center;
    width: 100%;
    height: 50px;
    box-sizing: border-box;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    padding: 10px;
}

.b03_skewed_slide_in div:nth-child(1) {
    color: #000000;
    background-color: #ffffff;
}

.b03_skewed_slide_in div:nth-child(2) {
    background-color: #000000;
    width: 230px;
    transition: all 0.2s ease;
    -webkit-transition: all 0.2s ease;
    -moz-transition: all 0.2s ease;
    transform: translate(-250px, 0px) skewX(-30deg);
    -webkit-transform: translate(-250px, 0px) skewX(-30deg);
    -moz-transform: translate(-250px, 0px) skewX(-30deg);
}

.b03_skewed_slide_in div:nth-child(3) {
    color: #ffffff;
    left: -200px;
    transition: left 0.2s ease;
    -webkit-transition: left 0.2s ease;
    -moz-transition: left 0.2s ease;
}

.b03_skewed_slide_in:hover div:nth-child(2) {
    transition: all 0.5s ease;
    -webkit-transition: all 0.5s ease;
    -moz-transition: all 0.5s ease;
    transform: translate(-15px, 0px) skewX(-30deg);
    -webkit-transform: translate(-15px, 0px) skewX(-30deg);
    -moz-transform: translate(-15px, 0px) skewX(-30deg);
}

.b03_skewed_slide_in:hover div:nth-child(3) {
    left: 0px;
    transition: left 0.30000000000000004s ease;
    -webkit-transition: left 0.30000000000000004s ease;
    -moz-transition: left 0.30000000000000004s ease;
}

.fade-in-out-text {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(255, 255, 255, 0.8);
    color: black;
    opacity: 1; /* 초기에 표시 */
    transition: opacity 1s ease-in-out; /* 투명도 애니메이션 설정 */
    animation: none; /* 애니메이션 제거 */
    z-index: 9999;
    pointer-events: none;
}


@keyframes fade-in-out {
    0%, 100% {
        opacity: 0; /* 처음과 마지막에 숨김 */
    }
    50% {
        opacity: 1; /* 중간에 보임 */
    }
}

</style>
<script type="text/javascript">
//화면이 로딩되면 3초 후에 fade-in-out-text 클래스를 숨깁니다.
window.addEventListener('load', function() {
    setTimeout(function() {
        document.querySelector('.fade-in-out-text').style.opacity = '0';
    }, 1000); // 3초 후에 투명도를 0으로 변경
});


</script>
<script type="text/javascript">
$(function(){
	$("#buyCart").click(function(){	
		location="resellList.do";
	})	;
});


</script>
</head>
<body>
<div class="container">

<div class="fade-in-out-text">
<br><br><br><br><br><br><br><br><br><br>
    <h1 style="font-weight: bold;">new Resll Product</h1>
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</div>

<div class="image1"></div>
<div class="text1">
  <h1>
  <br>
   	더 가지고싶고 <br>
    더 희소성 있게 <br>
    <br>
  </h1>
</div>

<div class="image2"></div>

<div class="text1">
  <h2>
  <br>
   자신의 소중한 물건을 <br>
   사고 , 되팔아보세요
  <br>
  <br>
  </h2>
  
</div>

<div class="image3"></div>

</div><br><br>

<div class="back container">
    <div class="button_base b03_skewed_slide_in">
        <div >My Products</div>
        <div></div>
        <div id="buyCart">Go Resell</div>
    </div>
</div>

</body>
</html>
