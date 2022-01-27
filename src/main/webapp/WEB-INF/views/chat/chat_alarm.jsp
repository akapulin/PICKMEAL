<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section id="chatAlarmWrap">
	<div id="chatShowHide">
		<h4>채팅이 도착했어요!</h4>
		<button id="chatOff" onclick="closeChatAlarm();">X</button>
		<div id="chatMessageWrap">
			<p id="rcvMessage">
				향기 언니님 맞으신가요?<br>
				글 올렷던, 아루 누나입니다!
			</p>
			<form action="${pageContext.request.contextPath}/chat/chatListByComment" method="get" id="goChatForm">
				<input type="hidden" id="chatCount" value="${chatCount}" />
				<input type="hidden" name="commenter" id="commenter" data-nickname="" value="${commenter.id}" />
				<input type="hidden" name="writer" id="writer" data-nickname="" value="${writer.id}" />
				<input type="submit" name="goChatting" onclick="acceptChat();" id="goChatting" value="채팅 바로가기" />
			</form>
		</div>
	</div>
<script>


	/* 김보령 - 1대1 채팅방을 위한 사용자 추가 */
	let check = "<c:out value='${member.id}'/>";
	let urlChk = window.location.href;
	let urlArr = urlChk.split("/");
	let pageName = urlArr[urlArr.length - 1];
	let sockChat = null;
	
	console.log("check : " + check)
	
	if (check != "") {
		sockChat = new SockJS("<c:url value="/oneChatting"/>");
		sockChat.onmessage = onMessage;
	}
	
	function acceptChat() {
		$("#chatAlarmWrap").fadeOut();
		let writer = document.getElementById("writer");
		let commenter = document.getElementById("commenter");
		if (writer.dataset.nickname == "${member.nickName}") {
			sockChat.send(commenter.dataset.nickname + ":[${member.nickName}]님이 입장했습니다.");
		} else if (commenter.dataset.nickname == "${member.nickName}") {
			sockChat.send(writer.dataset.nickname + ":[${member.nickName}]님이 입장했습니다.");
		}
	}

	function closeChatAlarm() {
		$("#chatCount").val("false")
		$("#chatAlarmWrap").fadeOut();
		let writer = document.getElementById("writer");
		let commenter = document.getElementById("commenter");
		if (writer.dataset.nickname == "${member.nickName}") {
			sockChat.send(commenter.dataset.nickname + ":[${member.nickName}]님은 시간이 부족하네요ㅠㅠ");
		} else if (commenter.dataset.nickname == "${member.nickName}") {
			sockChat.send(writer.dataset.nickname + ":[${member.nickName}]님은 시간이 부족하네요ㅠㅠ");
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/chat/chatAlarm",
			type: "get",
			success: function(data) {
				console.log(data);
				$("#chatCount").val("true")
			}
		})
	}

	function onMessage(evt) {
		let data = evt.data;
		if (data.includes("와 채팅이 시작되었습니다.<br>채팅에 참석을 원한다면 아래의 채팅 바로가기 버튼을 눌러주세요.<br>참석을 원하지 않을 시 창을 닫아주세요.") && $("#chatCount").val() == "true") {
			let arr = data.split("//");
			console.log(data);
			let writer = document.getElementById("writer");
			let commenter = document.getElementById("commenter");
			$("#chatAlarmWrap").fadeIn(400);
			$("#rcvMessage").html(arr[0]);
			writer.value = arr[1];
			writer.dataset.nickname = arr[2];
			commenter.value = arr[3];
			commenter.dataset.nickname = arr[4];
		}
	}
</script>
</section>