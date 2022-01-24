package pickmeal.dream.pj.message.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pickmeal.dream.pj.game.domain.LastGame;
import pickmeal.dream.pj.game.service.GameService;
import pickmeal.dream.pj.message.domain.Alarm;
import pickmeal.dream.pj.message.repository.AlarmDao;
import pickmeal.dream.pj.restaurant.service.RestaurantReferenceService;
import pickmeal.dream.pj.restaurant.service.VisitedRestaurantService;

@Service("alarmService")
public class AlarmServiceImpl implements AlarmService {
	
	@Autowired
	private AlarmDao ad;
	
	@Autowired
	private GameService gs;
	
	@Autowired
	private VisitedRestaurantService vrs;
	
	@Autowired
	RestaurantReferenceService rrs;

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
		if (alarm.getAlarmType() == 'L') { // 먹안먹
			// 아니요의 경우 식당에 가지 않았기 때문에 그냥 알람만 삭제
			if (answer.equals("no")) {
				ad.deleteAlarm(alarm.getId());
				// 예 의 경우 식당 선호도 올리고, 내가 간 식당 추가
			} else if (answer.equals("yes")) {
				// 우선 last game record 에서 마지막 게임을 가져온다.
				// 식당 id 랑 member id 를 가져오기 위함
				LastGame lg = gs.findLastGameByMemberId(alarm.getMember().getId());
				// 가져온 게임 내역을 이용해서 식당 선호도, 내가 간 식당 추가
				
			}
			
		} else if (alarm.getAlarmType() == 'M') { // 신뢰 온도
			
		}
		if (ad.isAlarm(alarm.getId())) {
			return false;
		}
		return true;
	}

	@Override
	public boolean deleteAlarm(Alarm alarm) {
		// 채팅의 경우 id 가 아닌 memberId, friendId 를 이용해서 삭제
		ad.deleteChatAlarm(alarm);
		if (ad.isChatAlarmByMemberIdFriendId(alarm)) {
			return false;
		}
		return true;
	}

}
