
$(document).ready(function(){
	//모집중/모집완료 초기값 셋팅하기
	if($('#postRecruitment').val()=='true'){
		recruitmentON()
	}
	else{
		recruitmentOFF()
	}
	
	//맵셋팅
	setMap();
	
	
})

/**

	모집중 / 모집완료 / 식사완료 

 */
/*
	오른쪽 상단 모집중/모집완료 토글버튼
	1. 모집중<->모집완료
		1) 타이틀의 모집중 초/빨 상태변경
		2) 토글상태변경
		3) db값 변경
	
	2. 식사완료
		1) 타이틀 모집중 -> 식사완료로 변경
		2) 토글상태변경(상태변경못하게)
		3) db값 변경
		4) 식사매너온도체크를 위한 팝업창 띄우기 
*/
//모집 토글 상태변경
$('.rPostCheckbox').click(function(){	
	//DB에 값 바꾸기
	let postId =$('#postId').val();
	$.ajax({
		url: getContextPath()+"/posting/convertRecruitmentState",
		type: "post",
		data: {"postId":postId },
		success:function(data){
			//모집완료로 변환되었다면 상태 변환
			if(data=='true'){
				recruitmentON();
			}
			//모집중 상태로 변환
			else{
				recruitmentOFF();
			}
		}
		
	})
})
//모집완료상태 되기
function recruitmentOFF(){
	$('.rPostTagTogetherIng').addClass('rPostTagTogetherComp');
	$('.rPostCheckOn').hide();
	$('.rPostCheckOFF').show();
	$('.rPostCheckbox').attr("checked", "checked");
}
//모집중상태 되기
function recruitmentON(){
	$('.rPostTagTogetherIng').removeClass('rPostTagTogetherComp');
	$('.rPostCheckOn').show();
	$('.rPostCheckOFF').hide();
	$('.rPostCheckbox').removeAttr("checked");
}
//식사완료
$('#rPostCompMealBtn').on('click',function(e){
	e.prevendDefault();
	
})





/*

	작성자 매너온도 그래프
	1. html tag 프로그레스바 이용
*/

/*
	맵 
	1. 수정불가능하게 하기
*/
function setMap(){
	// 식당 좌표 받아오기(좌표로)
	//let lat = $('#addressLat').val();
	//let lng = $('#addressLng').val();
    //let currentPos = new kakao.maps.LatLng(lat, lng);

    var mapContainer = document.getElementById('rPostContentMap'), // 지도를 표시할 div
        mapOption = {
            //enter: new daum.maps.LatLng(lat, lng), // 지도의 중심좌표
             center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);

    // 마커 생성(좌표로)
    //let marker = new kakao.maps.Marker({
    //    position: currentPos
    //});

    // 마커표시(좌표로)
    //marker.setMap(map);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	//맵의 주소값
	let address = $('#rAddress').text();
	//let address="경북 경산시 펜타힐즈4로 1";
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(address, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            position: coords
	        });
			marker.setMap(map);
			
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	})
	
}


/*

	좋아요 누르기
	1. 좋아요 상태변경
		1) 이미지 변경
		2) DB 갔다오기
		3) DB에서 가져온 값으로 숫자변경

*/
$('.rPostLikesImg').click(function(){
	//이미 하트가 눌린상태
	if($(this).hasClass('rPostLikesImgSelected')){
		$(this).removeClass('rPostLikesImgSelected');
		//이미지 변경
		$(this).attr('src',getContextPath()+'/resources/img/posting/heart.png')
	}
	else{
		$(this).addClass('rPostLikesImgSelected');
		//이미지 변경
		$(this).attr('src',getContextPath()+'/resources/img/posting/heart_onclick.png')
	}
	
})

// ContextPath 구하는 함수
function getContextPath() {
    var hostIndex = location.href.indexOf(location.host) + location.host.length;
    return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
}







/*
	게시글 수정
*/
$('#rPostModifyBtn').on('click',function(){
	console.log('in modify?');
	
	let postId = $('#postId').val();
	let category = $('.rwPostTitleWrap > h3').data('category');
	let modifyForm = document.goModifyBoard;
	console.log('modi>'+modifyForm)
	if(category=='N'){
		modifyForm.action=getContextPath()+"/posting/notice/modify/"+postId;
	}else if(category=='R'){
		modifyForm.action=getContextPath()+"/posting/recommend/modify/"+postId;
	}else if(category=='E'){
		modifyForm.action=getContextPath()+"/posting/together/modify/"+postId;
	}
	modifyForm.method="get";
	modifyForm.submit();
})


/*
	게시글 삭제
		1) ajax로 삭제처리를 먼저 해준다
		2) 게시판 목록으로 이동
*/
$('#rPostRemoveBtn').on('click',function(){
	let postId = $('#postId').val();
	let category = $('.rwPostTitleWrap > h3').data('category');
	let json ={"postId":postId,"category":category };
	$.ajax({
		url: getContextPath()+"/posting/removePosting",
		type: "post",
		data: JSON.stringify(json),
		contentType: "application/json; charset=UTF-8",
		success:function(data){
			//게시글 지우기 성공
			if(data=='true'){
				alert('게시글을 삭제 했습니다');
				if(category=='N'){
					$('#goNoticeBoard').submit();
				}else if(category=='R'){
					$('#goRecommendBoard').submit();
				}else if(category=='E'){
					$('#goTogetherBoard').submit();
				}
			}
			//게시글 지우기 실패
			else{
				alert('게시글을 삭제 할 수 없습니다');
			}
		}
		
	})
})	
	
	
	
	
	
	
	
	
	
	
		