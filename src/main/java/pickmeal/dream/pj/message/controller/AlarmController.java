package pickmeal.dream.pj.message.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.message.domain.Alarm;
import pickmeal.dream.pj.message.service.AlarmService;

@Controller
public class AlarmController {
	
	@Autowired
	AlarmService as;
	
	@GetMapping("/chat/viewAlarmRecord")
	public ResponseEntity<?> viewAlarmRecord(@SessionAttribute("member") Member member) {
		List<Alarm> alarms = as.findAllAlarmByMemberId(member.getId());
		
		return ResponseEntity.ok(alarms);
	}
}
