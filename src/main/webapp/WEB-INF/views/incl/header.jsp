<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<header>
	<h1><a class="logo" href="${pageContext.request.contextPath}/index">밥찡코</a></h1>
	<nav id="gnb">
		<h2 class="hidden">게시판메뉴</h2>
		<ul>
		 <li><a href="${pageContext.request.contextPath}/posting/notice">공지사항</a></li>
         <li><a href="${pageContext.request.contextPath}/posting/recommend">식당추천</a></li>
         <li><a href="${pageContext.request.contextPath}/posting/together">밥친구</a></li>
		<!--  
		<c:if test="${not empty member.id }">
         <li><a href="${pageContext.request.contextPath}/posting/notice">공지사항</a></li>
         <li><a href="${pageContext.request.contextPath}/posting/recommend">식당추천</a></li>
         <li><a href="${pageContext.request.contextPath}/posting/together">밥친구</a></li>
        </c:if>
        <c:if test="${empty member.id }">
         <li><a href="#">공지사항</a></li>
         <li><a href="#">식당추천</a></li>
         <li><a href="#">밥친구</a></li>
        </c:if>-->
      </ul>
	</nav>
	<nav id="snb">
		<h2 class="hidden">유저메뉴</h2>
		<input type="hidden" id="headerMember" value="${member.id}"/>
		<c:if test="${not empty member }">
			<ul>
				<li><span class="navi_nickname">${member.nickName }님 맛점하세요:)</span></li>
				<li class="snbProfileLine">
					<div class="profileImgWrap">
						<img src="/pickmeal/resources/img/profile/nonUser.png"
							alt="프로필아이콘" class="profileImg">
					</div>
					<div class="profileAreaWrap navAlarmTextCom">
						<ul class="profileArea">
							<li><a href="${pageContext.request.contextPath}/member/signOutMember">로그아웃</a></li>
							<li><a href="${pageContext.request.contextPath}/member/updateAchievementInfo">마이페이지</a></li>
						</ul>
					</div>
				</li>
				<li>
					<div class="alarmIconWrap comIconWrap">
						<img src="/pickmeal/resources/img/header/bell_alarm.png"
							alt="알림아이콘" class="alarmImg comIconImg">
						<div class="alarmMark comIconMark">!</div>
					</div>
					<div class="alarmAreaWrap navAlarmTextCom">
						<div class="alarmTitle">알림내역</div>
						<ul class="alarmArea">
						<!-- 알람 리스트가 들어갈 자리 -->
						</ul>
					</div>
				</li>
				<li>
					<div class="chatIconWrap comIconWrap">
						<a href="${pageContext.request.contextPath}/chat/chatListByIcon" onclick="removeChatAlarmMark(this);">
							<img src="/pickmeal/resources/img/header/chat_alarm.png"
								alt="알림아이콘" class="chatImg comIconImg">
						</a>
						<div class="chatAlarmMark comIconMark">!</div>
					</div>
				</li>
			</ul>
		</c:if>
		<c:if test="${empty member }">
			<ul>
				<li><span class="navi_nickname">오늘은 뭐 먹지?</span></li>
				<li class="snbProfileLine">
					<div class="profileImgWrap">
						<img src="/pickmeal/resources/img/profile/nonUser.png"
							alt="프로필아이콘" class="profileImg">
					</div>
					<div class="profileAreaWrap navAlarmTextCom">
						<ul class="profileArea">
							<li><a href="${pageContext.request.contextPath}/member/viewSignIn">로그인</a></li>
							<li><a href="${pageContext.request.contextPath}/member/viewSignUp">회원가입</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</c:if>
	</nav>
</header>

<section id="checkAlarmContent">
	<h2 class="hidden">알람 팝업</h2>
	<section class="questionWrap questionTypeL">
		<h3 class="hidden">식사 여부 질문</h3>
		<h4 class="question">혹시 [<span class="alarmContentInputL"><!-- content --></span>]에서 식사를 하셨나요?</h4>
		<section class="chkAlarmBtnWrap">
			<h4 class="hidden">선택</h4>
			<input type="button" onclick="removeAlarm(this);" class="chkAlarmBtn" name="chkAlarmBtnL" value="yes">
			<input type="button" onclick="removeAlarm(this);" class="chkAlarmBtn" name="chkAlarmBtnL" value="no">
		</section>
	</section>
	<section class="questionWrap questionTypeM">
		<h3 class="hidden">신뢰 온도 체크</h3>
		<h4 class="question">[<span class="alarmContentInputM"><!-- content --></span>]님과의 식사는 어떠셨나요?</h4>
		<section class="chkAlarmBtnWrap">
			<h4 class="hidden">선택</h4>
			<input type="button" onclick="removeAlarm(this);" class="chkAlarmBtn" name="chkAlarmBtnM" value="good">
			<input type="button" onclick="removeAlarm(this);" class="chkAlarmBtn" name="chkAlarmBtnM" value="so so">
			<input type="button" onclick="removeAlarm(this);" class="chkAlarmBtn" name="chkAlarmBtnM" value="bad">
		</section>
	</section>
	<script>
	function getContextPath() {
		let hostIndex = location.href.indexOf(location.host) + location.host.length;
		return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex+1));
	}
	// 처음에 한번 실행
	let checkMember = $("#headerMember").val();
	let alarmTimer;
	if (checkMember != "") {
		setTimeout(function() {
			$.ajax({
				url: getContextPath() + "/chat/viewAlarmRecord",
				type: "get",
				success: function(data) {
					createAlarm(data);
				}
			})
		}, 1)
		// 알람 레코드 불러서 있으면 추가해야한다.
		alarmTimer = setInterval(function() {
			$.ajax({
				url: getContextPath() + "/chat/viewAlarmRecord",
				type: "get",
				success: function(data) {
					createAlarm(data);
				}
			})
		}, 5000) // 60000 : 1분
	}
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
				} else if (timeHD > 60000) { // 1분 보다 클 경우
					let minuteHD = parseInt(timeHD / 60000); // 분으로 나누기
					timeTag = minuteHD + " 분 전"
				} else {
					timeTag = "방금 전"
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
							'<li onclick="popAlarmChkContent(this)" data-friend="' + data[i].friend.id + '" data-member="' + data[i].member.id + 
							'" data-alarmtype="' + data[i].alarmType + '" data-alarmid="' + data[i].id + '" data-alarmcontent="' + data[i].content + 
							'" id="alarm' + data[i].id + '">' + imgTag + 
								'<span class="alarmTextBold">[' + data[i].content + '] </span>' + contentTag + 
								'<span class="alarmTextClock">' + timeTag + '</span>' + 
							'</li>'
					)
				}
			}
		}
	}

	function popAlarmChkContent(a) {
		let alarmId = $(a).data("alarmid");
		let alarmType = $(a).data("alarmtype");
		let alarmMember = $(a).data("member");
		let alarmFriend = $(a).data("friend");
		let alarmContent = $(a).data("alarmcontent");
		
		// 둘 다 공통적으로 실행을 완료한 후 table 에서 레코드를 지워야한다.
		
		// alarmType == 'L' 인 경우에는 last game record 를 보고 식당 id 를 얻어와서
		// 내가 간 식당이랑 식당 선호도에 추가로 올려줘야한다.
		$("#checkAlarmContent").fadeIn(); // 팝업 표시
		// 먹?안먹 체크
		if (alarmType == 'L') {
			$(".questionTypeL").fadeIn(); // 먹?안먹? 표시
			$(".alarmContentInputL").html(alarmContent); // 해당 알람 내용 표시 (식당 이름)
			$(".chkAlarmBtn[name=chkAlarmBtnL]").data("alarmid", alarmId);
			$(".chkAlarmBtn[name=chkAlarmBtnL]").data("alarmtype", alarmType);
			$(".chkAlarmBtn[name=chkAlarmBtnL]").data("alarmmember", alarmMember);
			$(".chkAlarmBtn[name=chkAlarmBtnL]").data("alarmfriend", alarmFriend);
			$(".chkAlarmBtn[name=chkAlarmBtnL]").data("alarmcontent", alarmContent);
		}
		// 신뢰 온도 평가
		else if (alarmType == 'M') {
			$(".questionTypeM").fadeIn(); // 먹?안먹? 표시
			$(".alarmContentInputM").html(alarmContent); // 해당 알람 내용 표시 (식당 이름)
			$(".chkAlarmBtn[name=chkAlarmBtnM]").data("alarmid", alarmId);
			$(".chkAlarmBtn[name=chkAlarmBtnM]").data("alarmtype", alarmType);
			$(".chkAlarmBtn[name=chkAlarmBtnM]").data("alarmmember", alarmMember);
			$(".chkAlarmBtn[name=chkAlarmBtnM]").data("alarmfriend", alarmFriend);
			$(".chkAlarmBtn[name=chkAlarmBtnM]").data("alarmcontent", alarmContent);
		}
		
		// alarmType == 'M' 인 경우 > 매너 온도를 평가하는 것이다.
		// 좋아요 / 보통이에요 / 나빠요 이렇게 세가지가 있고 
		// 평가를 할 경우 상대방의 매너온도가 업데이트 되어야한다.
	}

	function removeAlarm(a) {
		let alarmId = $(a).data("alarmid");
		let alarmType = $(a).data("alarmtype");
		let alarmMember = $(a).data("alarmmember");
		let alarmFriend = $(a).data("alarmmember");
		let alarmContent = $(a).data("alarmcontent");
		
		$.ajax({
			url: "${pageContext.request.contextPath}/chat/removeAlarmType",
			type: "post",
			data: {
				"id": alarmId,
				"alarmType": alarmType,
				"memberId": alarmMember,
				"friendId": alarmFriend,
				"content": alarmContent,
				"answer": $(a).val()
			}, success: function(data) {
				if (data == true) {
					$(a).parents(".questionWrap").hide();
					$(a).parents("#checkAlarmContent").hide();
					$("li#alarm" + alarmId).remove();
					if ($("ul.alarmArea li").length == 0) {
						$(".alarmMark").hide();
					}
				}
			}
		})
	}
	</script>
</section>

<%@ include file="/WEB-INF/views/chat/chat_alarm.jsp"%>