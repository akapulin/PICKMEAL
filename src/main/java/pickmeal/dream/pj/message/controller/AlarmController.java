package pickmeal.dream.pj.message.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.message.command.AlarmCommand;
import pickmeal.dream.pj.message.domain.Alarm;
import pickmeal.dream.pj.message.service.AlarmService;

@Controller
public class AlarmController {
	
	@Autowired
	AlarmService as;
	
	/**
	 * 알람 내역들 가져오기
	 * setInterval로 계속해서 가지고 온다.
	 * @param member
	 * @return
	 */
	@GetMapping("/chat/viewAlarmRecord")
	public ResponseEntity<?> viewAlarmRecord(@SessionAttribute("member") Member member) {
		List<Alarm> alarms = as.findAllAlarmByMemberId(member.getId());
		
		return ResponseEntity.ok(alarms);
	}

	/**
	 * 먹?안먹? / 신뢰 온도 알람 제거
	 * @param alarmCommand
	 * @return
	 */
	@PostMapping("/chat/removeAlarmType")
	public ResponseEntity<?> removeAlarmType(@ModelAttribute AlarmCommand alarmCommand, 
			@SessionAttribute("member") Member member) {
		Alarm alarm = new Alarm();
		alarm.setAlarmType(alarmCommand.getAlarmType()); // 알람 타입
		alarm.setId(alarmCommand.getId()); // 알람 sql 아이디
		alarm.setMember(member); // 누구의 알람인지
		alarm.setFriend(new Member(alarmCommand.getFriendId())); // 상대방은 누구인지
		
		return ResponseEntity.ok(as.deleteAlarm(alarm, alarmCommand.getAnswer()));
	}
}
