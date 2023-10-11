 <!-- sitemesh 사용을 위한 설정 파일 -->
<!-- 작성자 : 이영환 -->
<!-- 작성일 : 2020-06-30 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SHOEPIN:<decorator:title /></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script src="/resources/js/jquery-3.6.4.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-applesdgothicneo@1.0/all.min.css"> -->
<style type="text/css">

*{
font-family: 'Noto Sans KR', sans-serif;
}
/* @CHARSET "UTF-8";  */
/* @import url(https://cdn.jsdelivr.net/npm/font-applesdgothicneo@1.0/all.min.css); */
pre { /* 엔터, 공백문자를 기대로 볼 수 있다. Bootstrap의 디자인이 의도한 대로 되지 않는다.
		pre 대신 \n -> <br> " " -> &nbsp; 변환해서 표시한다. textarea 태그 사용하고 readonly 속성 지정*/
	background: white;
	border: 0px;
}

/* Remove the navbar's default margin-bottom and rounded borders */
.navbar {
	margin-bottom: 0;
	border-radius: 0;
}

/* Hide the carousel text when the screen is less than 600 pixels wide */
@media ( max-width : 600px) {
	.carousel-caption {
		display: none;
	}
}

article {
	min-height: 440px;
	margin-top: 80px;
	margin-bottom: 120px;
}

#welcome {
	color: grey;
	margin: 0 auto;
}
#navbar{
    display:flex;
    align-items: center;
    padding-left:4rem;
    border-bottom: 1px solid #EDEDED;
    border-radius: 0;
    height: 51px;
    background: white;
}
#navbar > ul {
    display: flex;
    flex-grow: 1;
}
#navbar > ul > li {
    width:20%;
    text-align: center;
}
#navbar > ul > li .font{
    color: #939393;
    font-weight: bold;
    font-size: 15px;
    height: 48px;
}
#navbar > ul > li .font:hover{
    cursor: pointer;
    color: black;
    background: white;
}
#navbar > ul > li .font:focus{
    color: black;
    background: white;
}
#navbar .nav-mypage {
    display:flex;
    align-items: center;
    flex-shrink: 0;
    margin-left:5rem;
}
@media (min-width: 1500px) {
    .container {
        width: 1460px;
    }
}
.scroll-menu {
    display: none;
      
}
.scroll-menu.visible {
    display: block;
	background: white;
}
.loginDiv{
	text-align:right;
	font-size: 12px;
	height: 47px;
	padding: 10px 0px;
}
.text {
	color: #939393;
    font-weight: bold;
    font-size: 15px;
    height: 48px;
	position:relative; 
	display:inline-block;
}
#navbar > ul > li .text:hover{
	cursor: pointer;
    color: black;
    background: white;
}
#navbar > ul > li .text:focus{
	color: black;
    background: white;
}
#navbar > ul > li .text > .text-label {
	position:absolute; 
	top:-0.75rem; 
	right:0; 
	background-color:green; 
	color:#fff; 
	border-radius:4px; 
	display:inline-block; 
	vertical-align:middle; 
 	padding:4px;
	margin-top:8px;
	margin-right:50px;
	line-height:1; 
	font-size:1rem; 
	text-transform:uppercase; 
	animation: anime-blink 3.5s ease 0s infinite normal forwards;
}
.scrollLogoName{
	color: black;
    font-weight: bold;
    font-size: 17px;
    height: 48px;
	position:relative; 
	display:inline-block;
	padding-top: 3px;
}
@keyframes anime-blink {
	0%,
	50%,
	100% {
		opacity: 1;
	}

	25%,
	75% {
		opacity: 0;
	}
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
	});
	$(function() {
		window.addEventListener('scroll', function() {
			  var scrollMenu = document.getElementById('scrollMenu');
			  var scrollThreshold = 270; // 스크롤 위치가 180px 이상일 때 메뉴를 보여줍니다.
			
			  if (window.scrollY >= scrollThreshold) {
			    scrollMenu.classList.add('visible');
			  } else {
			    scrollMenu.classList.remove('visible');
			  }
		});
	});
	
	$(function(){
		$("#cartLogo").click(function(){
			if(${login == null}){
				alert("로그인후 이용해주세요.");
				return false;
			}
		})
		$("#wishLogo").click(function(){
			if(${login == null}){
				alert("로그인후 이용해주세요.");
				return false;
			}
		})
		$("#myPageLogo").click(function(){
			if(${login == null}){
				alert("로그인후 이용해주세요.");
				return false;
			}
		})
	});
</script>

<c:if test="${!empty msg}">
	<script type="text/javascript">
		$(function(){
			alert("${msg}")
		});
	</script>
</c:if>

<decorator:head/>
</head>
<body>
	<header>
		 <div class="container">
            <div class="loginDiv">
            	<c:if test="${ !empty login && login.gradeNo == 9 }">
	            	<a href="/item/write.do" style="color: #939393;">상품관리 </a>&nbsp;&nbsp;
            	</c:if>
            	<a href="/review/list.do" style="color: #939393;">리뷰 </a>&nbsp;&nbsp;
            	<a href="/notice/list.do" style="color: #939393;">공지사항/이벤트 </a>&nbsp;&nbsp;
            	<c:if test="${ !empty login && login.gradeNo == 9 }">
            		<a href="/question/managerList.do" style="color: #939393;">문의</a>&nbsp;&nbsp;
            	</c:if>
            	<c:if test="${ !empty login && login.gradeNo == 1 }">
            		<a href="/question/myList.do" style="color: #939393;">내 문의</a>&nbsp;&nbsp;
            	</c:if>
            	<c:if test="${ empty login }">
               <!-- 로그인이 되어 있지 않을 때 시작 -->
                  <a href="/member/write.do" style="color: #939393;">회원가입 </a>&nbsp;&nbsp;
                  <a href="/member/login.do" style="color: #939393;">로그인</a>
               <!-- 로그인이 되어 있지 않을 때 끝 -->
               </c:if>
               <c:if test="${ ! empty login }">
               <!-- 로그인이 되어 있을 때 시작 -->
                  <a href="/member/view.do?id=${login.id }" style="color: #939393;">${ login.name }</a>님&nbsp;&nbsp;&nbsp;
                  <a href="/member/logout.do" style="color: #939393;">로그아웃</a>
               <!-- 로그인이 되어 있을 때 끝 -->
               </c:if>
            </div>
            <div style="display:flex; align-items:center;">
            	<a href="/main/main.do" style="margin: 0 auto;"><img src="/resources/assets/images/logo2.png" width="217" height="173"></a>
            </div>
            <div style="height: 51px; text-align:right; padding: 13px 0px 0px 0px;">
            	<a href="#"><img src="/resources/assets/images/searchic.png" width="40" height="40"></a>
            </div>
            <nav class="navbar" id="navbar">
                <ul class="nav navbar-nav">
                	<li><a href="/item/list.do" class="font">All</a></li>
                    <li>
	                    <div class="dropdown">
			                <button class="btn dropdown-toggle font" type="button" data-toggle="dropdown"
		                	style="background: white; border: none;">
		                  		Nike
		               		</button>
	                    	<ul class="dropdown-menu" style="margin-left: 15px;">
		            		  <li><a href="/menu/list.do?brand=나이키">전체 </a></li>
			                  <li><a href="/menu/list.do?category=운동화&brand=나이키">운동화</a></li>
			                  <li><a href="/menu/list.do?category=슬리퍼&brand=나이키">슬리퍼</a></li>
			                  <li><a href="/menu/list.do?category=트레킹화&brand=나이키">트레킹화</a></li>
			                </ul>
			            </div>
                    </li>
                    <li>
	                    <div class="dropdown">
			                <button class="btn dropdown-toggle font" type="button" data-toggle="dropdown"
		                	style="background: white; border: none;">
		                  		Adidas
		               		</button>
	                    	<ul class="dropdown-menu" style="margin-left: 15px;">
		            		  <li><a href="/menu/list.do?brand=아디다스">전체 </a></li>
			                  <li><a href="/menu/list.do?category=운동화&brand=아디다스">운동화</a></li>
			                  <li><a href="/menu/list.do?category=슬리퍼&brand=아디다스">슬리퍼</a></li>
			                  <li><a href="/menu/list.do?category=트레킹화&brand=아디다스">트레킹화</a></li>
			                </ul>
			            </div>
                    </li>
                    <li>
	                    <div class="dropdown">
			                <button class="btn dropdown-toggle font" type="button" data-toggle="dropdown"
		                	style="background: white; border: none;">
		                  		New Balance
		               		</button>
	                    	<ul class="dropdown-menu" style="margin-left: 15px;">
		            		  <li><a href="/menu/list.do?brand=뉴발란스">전체 </a></li>
			                  <li><a href="/menu/list.do?category=운동화&brand=뉴발란스">운동화</a></li>
			                  <li><a href="/menu/list.do?category=슬리퍼&brand=뉴발란스">슬리퍼</a></li>
			                  <li><a href="/menu/list.do?category=트레킹화&brand=뉴발란스">트레킹화</a></li>
			                </ul>
			            </div>
                    </li>
                    <li>
	                    <div class="dropdown">
			                <button class="btn dropdown-toggle font" type="button" data-toggle="dropdown"
		                	style="background: white; border: none;">
		                  		Puma
		               		</button>
	                    	<ul class="dropdown-menu" style="margin-left: 15px;">
		            		  <li><a href="#">전체 </a></li>
			                  <li><a href="#">운동화</a></li>
			                  <li><a href="#">슬리퍼</a></li>
			                  <li><a href="#">트레킹화</a></li>
			                </ul>
			            </div>
                    </li>
                    <li>
	                    <div class="dropdown">
			                <button class="btn dropdown-toggle font" type="button" data-toggle="dropdown"
		                	style="background: white; border: none;">
		                  		FILA
		               		</button>
	                    	<ul class="dropdown-menu" style="margin-left: 15px;">
		            		  <li><a href="#">전체 </a></li>
			                  <li><a href="#">운동화</a></li>
			                  <li><a href="#">슬리퍼</a></li>
			                  <li><a href="#">트레킹화</a></li>
			                </ul>
			            </div>
                    </li>
                    <li><a href="/resell/resell.do" class="text">Resell<span class="text-label">new</span></a></li>
                </ul>
                <div class="nav-mypage">
                    <a href="/wishList/list.do" id="wishLogo"class="font" style="margin-right: 15px;">
                    	<img src="/resources/assets/images/wish.png" width="41" height="40">
                   	</a>
                    <a href="/cart/list.do" id="cartLogo"class="font" style="margin-right: 10px;">
                    	<img src="/resources/assets/images/basketic.png" width="40" height="40">
                   	</a>
                    <a href="/member/view.do?id=${login.id }"  id="myPageLogo" class="font">
                    	<img src="/resources/assets/images/mypageic.png" width="40" height="40">
                   	</a>
                </div>
            </nav>
        </div>
        <!-- 스크롤시 메뉴바 -->
        <div class="scroll-menu" id="scrollMenu">
	        <div class="container">
	            <nav class="navbar-fixed-top" id="navbar" style="box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.1);">
	            	<div style="padding-top: 20px; width: 150px;">
		            	<a href="/main/main.do" style="margin: 0 auto;">
		            		<img src="/resources/assets/images/logo2.png" style="width: 20%; height: 20%; padding-bottom: 3px;">
		            		<span class="scrollLogoName">SHOEPIN</span>
		            	</a>
	            	</div>
	                <ul class="nav navbar-nav">
	                   <li><a href="/item/list.do" class="font">All</a></li>
	                   <li><a href="/menu/list.do?brand=나이키" class="font">Nike</a></li>
	                   <li><a href="/menu/list.do?brand=아디다스" class="font">Adidas</a></li>
	                   <li><a href="/menu/list.do?brand=뉴발란스" class="font">New Balance</a></li>
	                   <li><a href="#" class="font">Puma</a></li>
	                   <li><a href="/buy/cartList.do" class="font">FILA</a></li>
	                   <li><a href="/resell/resell.do" class="text">Resell<span class="text-label">new</span></a></li>
	                </ul>
	                <div class="nav-mypage">
	                    <a href="/wishList/list.do" class="font" style="margin-right: 15px;">
	                    	<img src="/resources/assets/images/wish.png" width="41" height="40">
                    	</a>
	                    <a href="/cart/list.do" class="font" style="margin-right: 10px;">
	                    	<img src="/resources/assets/images/basketic.png" width="40" height="40">
	                    </a>
                    	<a href="/member/view.do?id=${login.id }" class="font">
                    		<img src="/resources/assets/images/mypageic.png" width="40" height="40">
                   		</a>
	                </div>
	                <div class="dropdown" style="text-align:right;">
		                <button class="btn dropdown-toggle" type="button" data-toggle="dropdown"
	                	style="background: white; border: none; padding-right: 20px; margin-left: 5px;">
	                  		<span class="glyphicon glyphicon-align-justify" style="font-size: 30px; color: #939393;"></span>
	               		</button>
		                <ul class="dropdown-menu" style="left:auto; right:0;">
		                  <c:if test="${ !empty login && login.gradeNo == 9 }">
	            			<li><a href="/item/write.do">상품관리 </a></li>
            			  </c:if>
		                  <li><a href="/review/list.do">리뷰</a></li>
		                  <li><a href="/notice/list.do">공지사항/이벤트</a></li>
		                  <c:if test="${ !empty login && login.gradeNo == 9 }">
		                  	<li><a href="/question/managerList.do">문의</a></li>
		                  </c:if>
		                  <c:if test="${ !empty login && login.gradeNo == 1 }">
		                  	<li><a href="/question/myList.do">내 문의</a></li>
		                  </c:if>
			              <c:if test="${ empty login }">
				              <!-- 로그인이 되어 있을 때 시작 --> 
				                  <li><a href="/member/write.do">회원가입 </a></li>
				                  <li><a href="/member/login.do">로그인</a></li>
				              <!-- 로그인이 되어 있을 때 끝 --> 
				          </c:if>
				          <c:if test="${ ! empty login }">
				          	  <!-- 로그인이 되어 있지 않았을 때 시작 -->
				                  <li><a href="/member/logout.do">로그아웃</a></li>
				              <!-- 로그인이 되어 있지 않았을 때 끝 -->
			               </c:if>
		               </ul>
	               </div>
				</nav>
	        </div>
	     </div>
	</header>
	<article>
		<decorator:body />
	</article>
	<footer style="border-top: 1px solid #EDEDED;">
		<div class="container">
			<div>
				<img src="/resources/assets/images/logo2.png" style="width: 7%; height: 7%; margin-top: 30px; margin-bottom: 30px;">
			</div>
			<div style="display:flex; justify-content:space-between; align-items:center;">
				<div>
					<p style="color: #BCBCBC;">브랜드소개  |  이용약관  |   개인정보처리방침  |  이용안내</p>
					<p style="color: #BCBCBC;">사업자명 : 스프링 2조</p>
					<p style="color: #BCBCBC; margin-bottom: 30px;">사업자번호 : 000-00-00000</p>
				</div>
				<div style="display:flex; justify-content:space-between; align-items:center; padding-bottom: 50px;">
					<div style="width: 110px;">
						<p style="font-weight: bolder; color: #515150;">전화번호</p>
						<p style="color: #BCBCBC;">1234-1234</p>
					</div>
					<div style="width: 110px;">
						<p style="font-weight: bolder; color: #515150;">택배회사</p>
						<p style="color: #BCBCBC;">대한통장</p>
					</div>
					<div style="width: 110px;">
						<p style="font-weight: bolder; color: #515150;">은행(시놘)</p>
						<p style="color: #BCBCBC;">000-000-000000</p>
					</div>
				</div>
			</div>
		</div>
	</footer>
</body>
</html>