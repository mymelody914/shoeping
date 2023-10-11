/**
 * Cart javaScript
 */
 
 $(function(){
	//이미지 표시 너비와 높이 
	resize();

	//브라우저의 창의 사이즈가 조정이되면 이미지 높이도 다시 계산되어서 표시되어야 한다. 
	$(window).resize(function(){
		resize();
	});
	
});



//이미지의 높이를 처리하는 함수.
function resize(){
	// 이미지의 너비를 구해보자.
	// select "a b" --> a안에 있는 b 객체를 선택. :first - 처음 것
	let width = $(".dataRow .imgDiv").width();
	// alert(width);
	let height = width / 3 * 2;
	$(".dataRow .imgDiv").height(height + "px");
};



//////////////////////////////////////////////----------------버튼 클릭 이벤트
//////////////////////////////////////////////----------------버튼 클릭 이벤트


$(function(){
	$(".closeButton").click(function(){
       
        var cartNo = $(this).data("no"); // 이 코드는 클로즈 버튼의 data-cart-no 속성을 가져옵니다.
		console.log(cartNo);
        $.ajax({
            url: "/cartAjax/delete.do",
            method: "POST", // 요청 방식 (GET 또는 POST를 선택하세요)
            data: { cartNo: cartNo }, // 전송할 데이터
            success: function(response){
                // AJAX 요청이 성공했을 때 수행할 작업을 여기에 추가하세요
                console.log("삭제 요청이 성공했습니다.");
                location.reload();
                // 여기에서 추가적인 작업을 수행하거나 페이지 리로드 등을 수행할 수 있습니다.
            },
            error: function(xhr, status, error){
                // AJAX 요청이 실패했을 때 수행할 작업을 여기에 추가하세요
                console.error("삭제 요청이 실패했습니다. 오류: " + error);
            }
        });
    });
});

///////////////////////////////////////////// 수량변경 아작스
///////////////////////////////////////////// 수량변경 아작스
$(function(){
	
	$(".increase").click(function(){
		var parentDiv = $(this).closest('.dataRow');
        
        // 상품의 cartNo 값을 가져옵니다.
        var cartNo = parentDiv.find('.closeButton').data("no");
		
		
		$.ajax({
            url: "/cartAjax/quantityPlus.do",
            method: "POST", // 요청 방식 (GET 또는 POST를 선택하세요)
            data: { cartNo: cartNo }, // 전송할 데이터
            success: function(response){
                // AJAX 요청이 성공했을 때 수행할 작업을 여기에 추가하세요
                console.log("플러스 성공");
                location.reload();
                // 여기에서 추가적인 작업을 수행하거나 페이지 리로드 등을 수행할 수 있습니다.
            },
            error: function(xhr, status, error){
                // AJAX 요청이 실패했을 때 수행할 작업을 여기에 추가하세요
                console.error("플러스 요청이 실패했습니다. 오류: " + error);
            }
        });
	});
	
	
	$(".decrease").click(function(){
		var parentDiv = $(this).closest('.dataRow');
        
        // 상품의 cartNo 값을 가져옵니다.
        var cartNo = parentDiv.find('.closeButton').data("no");
		
		
		$.ajax({
            url: "/cartAjax/quantityMinus.do",
            method: "POST", // 요청 방식 (GET 또는 POST를 선택하세요)
            data: { cartNo: cartNo }, // 전송할 데이터
            success: function(response){
                // AJAX 요청이 성공했을 때 수행할 작업을 여기에 추가하세요
               
                location.reload();
                // 여기에서 추가적인 작업을 수행하거나 페이지 리로드 등을 수행할 수 있습니다.
            },
            error: function(xhr, status, error){
                // AJAX 요청이 실패했을 때 수행할 작업을 여기에 추가하세요
                console.error("마이너스 요청이 실패했습니다. 오류: " + error);
            }
        });
	});
	
});