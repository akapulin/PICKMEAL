package pickmeal.dream.pj.message.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pickmeal.dream.pj.message.domain.Alarm;
import pickmeal.dream.pj.message.repository.AlarmDao;

@Service("alarmService")
public class AlarmServiceImpl implements AlarmService {
	
	@Autowired
	private AlarmDao ad;

	@Override
	public void addAlarm(Alarm alarm) {
		// 채팅에 대한 알람일 경우
		if (alarm.getAlarmType() == 'C') {
			// 해당 member, friend 에 해당하는 채팅 기록이 있다면 날짜만 업데이트만 할 것
			if (ad.isChatAlarmByMemberIdFriendId(alarm) ) {
				ad.updateChatAlarm(alarm);
			} else {
				ad.addAlarm(alarm);
			}
		} else { // 채팅이 아닐 경우 무조건 추가
			ad.addAlarm(alarm);
		}
	}

	@Override
	public List<Alarm> findAllAlarmByMemberId(long memberId) {
		List<Alarm> alarms = new ArrayList<Alarm>();
		if (ad.isAlarmByMemberId(memberId)) {
			alarms = ad.findAllAlarmByMemberId(memberId);
		}
		return alarms;
	}

	@Override
	public boolean deleteAlarm(Alarm alarm, String answer) {
		// 채팅의 경우 id 가 아닌 memberId, friendId 를 이용해서 삭제
		if (alarm.getAlarmType() == 'C') {
			ad.deleteChatAlarm(alarm);
			if (ad.isChatAlarmByMemberIdFriendId(alarm)) {
				return false;
			}
			return true;
		}
		ad.deleteAlarm(alarm.getId());
		if (ad.isAlarm(alarm.getId())) {
			return false;
		}
		return true;
	}

}
