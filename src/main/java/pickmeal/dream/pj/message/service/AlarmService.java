package pickmeal.dream.pj.message.service;

import java.util.List;

import pickmeal.dream.pj.message.domain.Alarm;

public interface AlarmService {
	
	/**
	 * 알람 추가
	 * @param alarm
	 */
	public void addAlarm(Alarm alarm);
	
	/**
	 * 해당 사용자의 알람 메세지 다 가져오기
	 * @param memberId
	 * @return
	 */
	public List<Alarm> findAllAlarmByMemberId(long memberId);
	
	/**
	 * 확인했을 경우 해당 알람 지우기
	 * 먹안먹, 신뢰온도
	 * @param id
	 * @return
	 */
	public boolean deleteAlarm(Alarm alarm, String answer);
	
	/**
	 * 확인했을 경우 채팅 알람 지우기
	 * 채팅에서만 사용
	 * @param id
	 * @return
	 */
	public boolean deleteAlarm(Alarm alarm);
}
