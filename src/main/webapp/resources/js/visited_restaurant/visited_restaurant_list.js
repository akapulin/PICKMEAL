/**
 * 초기 화면의 기본 값 입니다.
 */



function reviewClick(){
	var reviewradio = $("input[name='vrreviewradio']:checked").val();
	var restaurantName = $("#restaurantNameis"+reviewradio).val();
	var restaurantTableId=$("#restaurantrealid"+reviewradio).val();
	console.log("내간식 id"+reviewradio);
	console.log("찐식 id"+restaurantTableId);
	console.log("레스토랑 명 : " + restaurantName);
	$('#explainWrap').hide();
	$('#Reviewcheck').show();
	$('#rightdiv').css({'border': '5px solid #ffecec'});
	$('#reviewButtonWrap').show();
	$("#reviewRName").val(restaurantName+" 식당리뷰!");
	$("#submititem").val(restaurantTableId);
	$("#visitedRestaurantId").val(reviewradio);
	
}
/*찜 하기 */
function jjimrestaurant(){
	var radiojjim = $("input[name='vrfavoriteradio']:checked").val();
	
	console.log(radiojjim);
	
	$.ajax({
		url: "http://localhost:8080/pickmeal/jjimclickBtn",
		type: "post",
		data: JSON.stringify({"id" : radiojjim}),
		contentType:'application/json; charset=utf-8',
		
		success: function(data){
			//$("#jjimdiv"+radiojjim).children().remove();
			var restaurantid = $("#favoritelabel"+radiojjim).data("restaurantid");
			//console.log($(".favoritebutton"+restaurantid));
			$(".favoritebutton"+restaurantid).children().remove();
			
		}
		
	});
}

function removeClick(){
	var removeradio = $("input[name='removeradio']:checked").val();
	console.log("삭제할 아이디 : "+ removeradio);
	
	$.ajax({
		url: "http://localhost:8080/pickmeal/removeVisited",
		type:"post",
		data: JSON.stringify({"id" : removeradio}),
		contentType:'application/json; charset=utf-8',
		
		success: function(data){
			$("#vrdivs"+removeradio).remove();
		}
	});
}
/*버튼 호버시 변경 */
$(".removeInlabel").hover(function(){
	$(this).parent().css({'backgroundColor' : '#ffecec'});
	$(this).prev().prev().css({'backgroundColor' : '#ffecec'})
},function(){
	$(this).parent().css({'backgroundColor' : 'white'});
	$(this).prev().prev().css({'backgroundColor' : 'white'})
})
$(".reviewInlabel").hover(function(){
	$(this).parent().css({'backgroundColor' : '#ffecec'});
	$(this).prev().prev().css({'backgroundColor' : '#ffecec'})
},function(){
	$(this).parent().css({'backgroundColor' : 'white'});
	$(this).prev().prev().css({'backgroundColor' : 'white'})
})
$(".favoriteInlabel").hover(function(){
	$(this).parent().css({'backgroundColor' : '#ffecec'});
},function(){
	$(this).parent().css({'backgroundColor' : 'white'});
})

//체크박스 5개 까지만 고르고 값 변경 해주기 완료
$(document).ready(function() {
	$("input:checkbox").on('click', function(){
		let count = $("input:checked[type='checkbox']").length;
		
		if(count>5){
			$(this).prop("checked",false);
			Swal.fire({
  			title: '리뷰 과선택',
  				text: "식당리뷰는 최대 5개 선택 할 수 있습니다.",
  				icon: 'warning',
			  	confirmButtonColor: '#3085d6',
			  	confirmButtonText: '확인'
				})
		}else{
			if ( $(this).prop('checked') ){
				$(this).val(1);
				$(this).next().next().css('color','#f23f3f');
				$(this).parent().css({'backgroundColor' : '#fff', 'border-bottom' : '1px solid #f23f3f'});
	 		}else{
				$(this).val(0);
				$(this).css('border','0px');
				$(this).next().next().css('color','black');
				$(this).parent().css({'backgroundColor' : 'white', 'border' : '0px'});
			}
		}
		
	});
	 
});

var reviewradio = $("input[name='vrreviewradio']:checked").val();
$('#reviewlabel'+reviewradio).on('click', function(){
	$('#Reviewcheck').css({'display' : ''})
})

$('#reviewButton').on('click', function(e){
	let count = $("input:checked[type='checkbox']").length;
	if(count == 0){
		Swal.fire({
  			title: '리뷰미선택',
  				text: "식당 리뷰는 1~5개 선택해야 합니다.",
  				icon: 'warning',
			  	confirmButtonColor: '#3085d6',
			  	confirmButtonText: '확인'
				})
	}else{
		$('#rightdiv').css({'border': '0px'});
		reviewinform.submit()
	}
})


