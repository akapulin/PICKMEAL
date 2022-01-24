package pickmeal.dream.pj.message.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import pickmeal.dream.pj.game.domain.LastGame;
import pickmeal.dream.pj.game.service.GameService;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.member.service.MemberAchievementService;
import pickmeal.dream.pj.message.domain.Alarm;
import pickmeal.dream.pj.message.repository.AlarmDao;
import pickmeal.dream.pj.restaurant.domain.Restaurant;
import pickmeal.dream.pj.restaurant.domain.RestaurantGraph;
import pickmeal.dream.pj.restaurant.domain.VisitedRestaurant;
import pickmeal.dream.pj.restaurant.service.RestaurantReferenceService;
import pickmeal.dream.pj.restaurant.service.VisitedRestaurantService;

import static pickmeal.dream.pj.web.constant.SavingPointConstants.*;
import static pickmeal.dream.pj.web.constant.Constants.*;

@Service("alarmService")
@Slf4j
public class AlarmServiceImpl implements AlarmService {
	
	@Autowired
	private AlarmDao ad;
	
	@Autowired
	private GameService gs;
	
	@Autowired
	private VisitedRestaurantService vrs;
	
	@Autowired
	private RestaurantReferenceService rrs;
	
	@Autowired
	private MemberAchievementService mas;

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
		Member member = alarm.getMember();
		log.info("before member manner : " + member.getMannerTemperature());
		log.info("before member foodpower : " + member.getFoodPowerPoint());
		// 먹안먹
		if (alarm.getAlarmType() == 'L') {
			// 예 의 경우 식당 선호도 올리고, 내가 간 식당 추가
			if (answer.equals("yes")) {
				// 우선 last game record 에서 마지막 게임을 가져온다.
				// 식당 id 랑 member id 를 가져오기 위함
				LastGame lg = gs.findLastGameByMemberId(alarm.getMember().getId());
				
				// 가져온 게임 내역을 이용해서 식당 선호도, 내가 간 식당 추가
				// 식당 그래프 추가
				RestaurantGraph rg = new RestaurantGraph();
				rg.setMember(lg.getMember());
				rg.setRestaurant(new Restaurant(lg.getRestaurant().getId()));
				rrs.addRestaurantReference(rg);
				
				// 내가 간 식당 추가
				VisitedRestaurant vr = new VisitedRestaurant();
				vr.setMember(lg.getMember());
				vr.setRestaurant(rg.getRestaurant());
				vrs.addVisitedRestaurant(vr);
			}
			// 아니요의 경우 식당에 가지 않았기 때문에 그냥 알람만 삭제
			
			// 식력 포인트 적립
			member = mas.addFoodPowerPointItem(member, CHECK_MANNER);
			
		} else if (alarm.getAlarmType() == 'M') { // 신뢰 온도
			// 먼저 해당 멤버의 신뢰 온도 테이블 업데이트 & session 에서 가져온 member 신뢰온도 셋팅
			log.info("answer : " + answer);
			if (answer.equals("good")) {
				member = mas.updateMannerTemperature(member, GOOD);
			} else if (answer.equals("so so")) {
				member = mas.updateMannerTemperature(member, NORMAl);
			} else if (answer.equals("bad")) {
				member = mas.updateMannerTemperature(member, BAD);
			}
		}
		// 각 동작들이 완료되었다면 해당 알람은 테이블에서 삭제
		log.info("after member manner : " + member.getMannerTemperature());
		log.info("after member foodpower : " + member.getFoodPowerPoint());
		ad.deleteAlarm(alarm.getId());
		if (ad.isAlarm(alarm.getId())) { // 테이블에서 있다면 삭제가 되지 않은 것이다.
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
