package pickmeal.dream.pj.message.repository;

import java.util.List;

import pickmeal.dream.pj.message.domain.Alarm;

public interface AlarmDao {
	
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
	 * @param id
	 * @return
	 */
	public void deleteAlarm(long id);
	
	/**
	 * 해당 알람이 존재하는가?
	 * @param id
	 * @return
	 */
	public boolean isAlarm(long id);
	
	/**
	 * 해당 멤버에게 알람이 존재하는가?
	 * @param memberId
	 * @return
	 */
	public boolean isAlarmByMemberId(long memberId);
}
