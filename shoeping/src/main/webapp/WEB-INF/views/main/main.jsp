<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<style type="text/css">
*, *:after, *:before {box-sizing: border-box;}
    html, body{margin:0; padding:0}
    #mainslider {position: relative; height: 100%;}
    #mainslider {background: #eee; font-family: Helvetica Neue, Helvetica, Arial, sans-serif; font-size: 14px; color: #000; margin: 0; padding: 0;}
    .swiper {width: 100%; height: 100%;}
    .swiper-slide {text-align: center;font-size: 18px;background: #fff;display: flex;justify-content: center;align-items: center;}
    .swiper-slide img {display: block;width: 100%;height: 100%;object-fit: cover;}

    #tab-list {}
    #tab-list > div:hover,
    #tab-list > div.stylish {background-color: #000; color: #fff; cursor: grab; transition: .3s ease;}
    .tab:not(:first-child) {display: none;}
    article {
	min-height: 440px;
	margin-top: 0px;
	margin-bottom: 0px;
}
.more{
	border: none;
	background: none;
	color: #6D6D6D;
}
.moreReview{
	border: none;
	background: none;
	color: #6D6D6D;
}
.viewMore{
	border: none;
	background: none;
	color: #6D6D6D;
}
.more:hover{
	color: black;
}
.moreReview:hover{
	color: black;
}
.viewMore:hover{
	color: black;
}
#items{
	width: 300px;
	height: 370px;
	background: #E5E4E3;
  	border-radius: 20px;
  	overflow: hidden;
  	margin-left: 10px;
}
#category{
	border-bottom: 1px solid #EDEDED;
	height: 48px;
	padding-top: 10px;
	padding-left: 20px;
}
.dataRow:hover{
	cursor: pointer;
}
</style>
<script type="text/javascript">

$(document).ready(function() {
	const initSlider = () => {
	    var swiper = new Swiper(".mySwiper", {
	    spaceBetween: 30,
	    centeredSlides: true,
	    autoplay: {
	        delay: 2500,
	        disableOnInteraction: false,
	    },
	    pagination: {
	        el: ".swiper-pagination",
	        clickable: true,
	    },
	    navigation: {
	        nextEl: ".swiper-button-next",
	        prevEl: ".swiper-button-prev",
	    },
	});
	}
	initSlider();

	$('#tab-list > div').click(function(){
	var $this = $(this);
	var idx = $this.index();

	var styleClass = 'stylish'

	// 누른애 스타일 추가
	$('#tab-list > div').removeClass(styleClass);
	$this.addClass(styleClass);

	$('.tab').hide();
	$('.tab:eq(' + idx + ')').show()
	});

	// 아이템 리스트로 이동
	$(".more").click(function(){
		location="/item/list.do";
	});
	// 리뷰 리스트로 이동
	$(".moreReview").click(function(){
		location="/review/list.do";
	});
	// 클릭한 리뷰로 이동
	$(".viewMore").click(function(){
		let reviewNo = $(this).find(".reviewNo").text();
		// alert(reviewNo);
		location="/review/view.do?review_no=" + reviewNo;
	});
	
	$(".dataRow").click(function(){
		let itemNo = $(this).find(".itemNo").text();
		// alert(itemNo);
		location="/item/view.do?itemNo=" + itemNo;
	});
		
});


</script>
</head>
<body>
<div class="container">
	<section id="mainslider">
	    <!-- Slider main container -->
	    <div class="swiper mySwiper">
	        <div class="swiper-wrapper">
	            <div class="swiper-slide"><img src="https://placehold.co/1920x1200/orange/white?text=Slide+Item+1"></div>
	            <div class="swiper-slide"><img src="https://placehold.co/1920x1200/orange/white?text=Slide+Item+2"></div>
	            <div class="swiper-slide"><img src="https://placehold.co/1920x1200/orange/white?text=Slide+Item+3"></div>
	            <div class="swiper-slide"><img src="https://placehold.co/1920x1200/orange/white?text=Slide+Item+4"></div>
	            <div class="swiper-slide"><img src="https://placehold.co/1920x1200/orange/white?text=Slide+Item+5"></div>
	        </div>
	        <div class="swiper-pagination"></div>
	    </div>
	</section>
	<!-- 이달의 신상 -->
	<div class="item" style="padding: 80px 20px 80px 20px;">
		<div class="row">
			<div style="padding: 0px 15px 0px 15px;">
				<p>
					<span style="color: #6D6D6D; font-weight: bold; font-size: 15px;">이달의 신상</span>
					<span style="color: #BCBCBC;">(운동화)</span>
					<span class="pull-right"><button class="more">더보기</button></span>
				</p>
				<hr>
			</div>
			<c:forEach items="${list}" var="vo" varStatus="vs">
	            <c:if test="${vs.index < 3}">
			         <div class="col-md-4">
			            <div class="thumbnail dataRow">
			            	<div class="imageDiv" style="width: 433px; height: 541px; overflow: hidden; background: #F4F3F2;">
				                <img src="${vo.fileName }" alt="Lights" style="width: 100%">
			            	</div>
			            	<div class="contentDiv" style="height: 70px; padding-top: 5px;">
			                	<div>${vo.brand }<span class="pull-right">${vo.category }</span></div>
			                     <p class="itemNo" style="display: none;">${vo.itemNo }</p>
			                     <div style="margin: 0%;"><span>${vo.itemName }</span></div>
			                     <div>
				                     <span class="pull-right">
				                        	₩<fmt:formatNumber type="number" maxFractionDigits="3" value="${vo.itemPrice }" />
				                     </span>
				                 </div>
			            	</div>
			            </div>
			         </div>
	            </c:if>
	         </c:forEach>
      	</div>
    </div>
</div>
<div style="background: #F4F3F2;">
	<div class="container">
		<section id="vertical-tabbox">
			<div class="row" style="padding-top: 90px; padding-bottom: 90px;">
				<div class="col-md-3" style="padding-left: 30px;">
					<p style="color: #515150; font-weight: bold; font-size: 16px;">인기 상품</p>
					<p style="color: #6D6D6D; font-size: 14px; padding-bottom: 20px;">핫한 아이템이 여기 있어요!</p>
				    <div id="tab-list" style="background: white; width: 250px;">
				        <div id="category" class="stylish">Nike</div>
				        <div id="category">Adidas</div>
				        <div id="category">New Balance</div>
				        <div id="category">Puma</div>
				        <div id="category">FILA</div>
				    </div>
				</div>
			    <div class="col-md-9" id="tab-boxes">
			        <div class="tab">
			        	<div class="row">
				        	<div class="col-md-4">
					            <div class="item" id="items"><img src="/resources/assets/images/nike1.jpg" alt="Lights" style="width: 100%"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"><img src="/resources/assets/images/nike2.jpg" alt="Lights" style="width: 100%"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"><img src="/resources/assets/images/nike3.jpg" alt="Lights" style="width: 100%"></div>
			        		</div>
			            </div>
			        </div>
			        <div class="tab">
			        	<div class="row">
			        		<div class="col-md-4">
					            <div class="item" id="items"><img src="/resources/assets/images/adidas1.jpg" alt="Lights" style="width: 100%"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"><img src="/resources/assets/images/adidas2.jpg" alt="Lights" style="width: 100%"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"><img src="/resources/assets/images/adidas3.jpg" alt="Lights" style="width: 100%"></div>
			        		</div>
			        	</div>
			        </div>
			        <div class="tab">
			            <div class="row">
			        		<div class="col-md-4">
					            <div class="item" id="items"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"></div>
			        		</div>
			        	</div>
			        </div>
			        <div class="tab">
			            <div class="row">
			        		<div class="col-md-4">
					            <div class="item" id="items"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"></div>
			        		</div>
			        	</div>
			        </div>
			        <div class="tab">
			            <div class="row">
			        		<div class="col-md-4">
					            <div class="item" id="items"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"></div>
			        		</div>
			        		<div class="col-md-4">
					            <div class="item" id="items"></div>
			        		</div>
			        	</div>
			        </div>
			    </div>
		    </div>
		</section>
	</div>
</div>
<div class="container">
	<div class="review" style="padding: 80px 20px 80px 20px;">
		<div class="row">
			<div style="padding: 0px 15px 0px 15px;">
				<p>
					<span style="color: #6D6D6D; font-weight: bold; font-size: 15px;">인기 리뷰</span>
					<span class="pull-right"><button class="moreReview">더보기</button></span>
				</p>
				<hr>
			</div>
	    	<c:forEach items="${reviewList}" var="reviewVO" varStatus="status">
		        <c:if test="${status.index < 4}">
		        	<div class="col-md-3">
			            <div class="thumbnail">
			            	<div class="imageDiv" style="width: 315px; height: 200px; overflow: hidden; background: #F4F3F2;">
				                <img src="${reviewVO.fileName }" alt="Lights" style="width: 100%">
			            	</div>
			            	<div class="contentDiv" style="padding-top: 5px; text-align: center;">
			            		<p style="font-weight: bold;">${reviewVO.itemName}</p>
			            		<p>
			            			<span>${reviewVO.title}</span>
			            		</p>
			            		<button class="viewMore">
			            			<span>더보기</span>
			            			<span class="reviewNo" style="display: none;">${reviewVO.review_no}</span>
			            		</button>
			            	</div>
			            </div>
		        	</div>
		        </c:if>
	   		</c:forEach>
		</div>
    </div>
</div>
</body>
</html>