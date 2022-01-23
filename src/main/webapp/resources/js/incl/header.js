/*

    프로필 & 알림 영역

*/
/*
    헤더 공통
*/
//서브네비게이션 바깥 부분 눌러주면 켜져있는 서브네비 꺼주기
$('html').click(function(e) {
  if(!$(e.target).hasClass('profileImg')) {
    closeProfileSubNav();
  }
  if(!$(e.target).hasClass('alarmImg')){
    closeAlarmSubNav();
  }

});




/*
    프로필사진 hover
*/
$('.profileImg').hover(function(){
  //클릭한 상태가 아니면 프로필사진 변경시켜준다
  if(!$(this).hasClass('header_IconOnclick')){
    $(this).attr('src','/pickmeal/resources/img/profile/nonUser_click.png');
  }
}, function(){
  //클릭한 상태가 아니면 프로필사진 원상복귀
  if(!$(this).hasClass('header_IconOnclick')){
    $(this).attr('src','/pickmeal/resources/img/profile/nonUser.png');
  }
})


/*
    프로필사진 onclick
*/

$('.profileImg').on('click',function(){
  //알림 서브네비게이션 열려있으면 닫아주기
  closeAlarmSubNav();

  //클릭하면
  if(!$(this).hasClass('header_IconOnclick')){
    //클릭한 상태로 만들어주고
    $(this).addClass('header_IconOnclick');
    //클릭한 프로필사진으로 변경시켜준다
    $(this).attr('src','/pickmeal/resources/img/profile/nonUser_click.png');
    
    //서브네비게이션 열어주기
    $('.profileAreaWrap').show();
  }
  //클릭한 상태이면
  else{
    //서브네비게이션 닫아주기
    closeProfileSubNav();
  }
})


// 프로필 서브네비게이션 열려 있으면 닫아주는 함수
function closeProfileSubNav(){
  if($('.profileImg').hasClass('header_IconOnclick')){
    $('.profileImg').removeClass('header_IconOnclick');
    $('.profileImg').attr('src','/pickmeal/resources/img/profile/nonUser.png');
    $('.profileAreaWrap').hide();
  }
}



/*
    알림 hover
*/
$('.alarmImg').hover(function(){
  //클릭한 상태가 아니면 알림 변경시켜준다
  if(!$(this).hasClass('header_IconOnclick')){
    $(this).attr('src','/pickmeal/resources/img/header/bell_clickAlarm.png');
  }
}, function(){
  //클릭한 상태가 아니면 알림 원상복귀
  if(!$(this).hasClass('header_IconOnclick')){
    $(this).attr('src','/pickmeal/resources/img/header/bell_alarm.png');
  }
})

// 알림 서브네비게이션 열려 있으면 닫아주는 함수
function closeAlarmSubNav(){
  if($('.alarmImg').hasClass('header_IconOnclick')){
    $('.alarmImg').removeClass('header_IconOnclick');
    $('.alarmImg').attr('src','/pickmeal/resources/img/header/bell_alarm.png');
    $('.alarmAreaWrap').hide();
  }
}

/*
    알림 onclick
*/

$('.alarmImg').on('click',function(){
  //프로필 서브네비게이션이 켜져있으면 닫아주기
  closeProfileSubNav();
  
  //클릭하면
  if(!$(this).hasClass('header_IconOnclick')){
    //클릭한 상태로 만들어주고
    $(this).addClass('header_IconOnclick');
    //클릭한 알림사진으로 변경시켜준다
    $(this).attr('src','/pickmeal/resources/img/header/bell_clickAlarm.png');
    
    //서브네비게이션 열어주기
    $('.alarmAreaWrap').show();
  }
  //클릭한 상태이면
  else{
    closeAlarmSubNav();
  }
})

/*
    채팅 hover
*/
$('.chatImg').hover(function(){
  $(this).attr('src','/pickmeal/resources/img/header/chat_clickAlarm.png');
},function(){
  $(this).attr('src','/pickmeal/resources/img/header/chat_alarm.png');
})





/*

    게시판 메뉴 영역

*/
/*
    게시판 메뉴 리스트 hover
*/
$('#gnb ul li a').hover(function(){
  if(!$(this).hasClass('header_BoardOnclick')){
    $(this).css({color:'#f23f3f',cursor:'pointer'});
  }
},function(){
  if(!$(this).hasClass('header_BoardOnclick')){
    $(this).css({color:'#000',cursor:'pointer'});
  }
})

/*
    게시판 메뉴 리스트 onclick
*/
$('#gnb ul li a').on('click',function(){
  console.log('hi')
  $('#gnb ul li').removeClass('header_BoardOnclick');
  $('#gnb ul li').css({color:'#000'});
  $(this).addClass('header_BoardOnclick');

})

// 처음에 한번 실행
setTimeout(function() {
	let checkMember = $("#headerMember").val();
	if (checkMember != "") {
		$.ajax({
			url: getContextPath() + "/chat/viewAlarmRecord",
			type: "get",
			success: function(data) {
				createAlarm(data);
			}
		})
	}
}, 1)
// 알람 레코드 불러서 있으면 추가해야한다.
let alarmTimer = setInterval(function() {
	let checkMember = $("#headerMember").val();
	if (checkMember != "") {
		$.ajax({
			url: getContextPath() + "/chat/viewAlarmRecord",
			type: "get",
			success: function(data) {
				createAlarm(data);
			}
		})
	}
}, 5000) // 60000 : 1분

function createAlarm(data) {
	if (data.length == 0) {
		return;
	}
	for(let i=0; i<data.length; i++) {
		let type = data[i].alarmType;
		if (type == 'C') { // type 이 C 인 경우 채팅
			$(".chatAlarmMark").show();
		} else {
			$(".alarmMark").show();
			let imgTag;
			let contentTag;
			let timeTag;
			let timeHD = Date.parse(new Date()) - Date.parse(data[i].regDate);
			
			if (timeHD > 3600000) { // 1시간 보다 클 경우
				let hourHD = parseInt(timeHD / 3600000); // 시간으로 나누기
				timeTag = hourHD + " 시간 전"
			} else {
				let minuteHD = parseInt(timeHD / 60000); // 분
				timeTag = minuteHD + " 분 전"
			}
			
			if (data[i].alarmType == 'L') {
				imgTag = '<img src="' + getContextPath() + '/resources/img/header/store.png" alt="프로필사진" class="alarmProfileImg">';
				contentTag = '식당에서 식사는 맛있으셨나요?';
			} else {
				imgTag = '<img src="' + getContextPath() + '/resources/img/header/store.png" alt="프로필사진" class="alarmProfileImg">';
				contentTag = '님과의 식사는 어떠셨나요?';
			}
			// 알람 메시지를 넣어줘야한다.
			if ($("#alarm" + data[i].id).length == 0) { // 해당 알람이 없을 경우
				$("ul.alarmArea").append(
						'<li onclick="removeAlarm(this)" data-friend="' + data[i].friendId + '" data-alarmType="' + data[i].alarmType + '" id="alarm' + data[i].id + '">' + imgTag + 
							'<span class="alarmTextBold">[' + data[i].content + '] </span>' + contentTag + 
							'<span class="alarmTextClock">' + timeTag + '</span>' + 
						'</li>'
				)
			}
		}
	}
}

function removeAlarm(a) {
	
}













