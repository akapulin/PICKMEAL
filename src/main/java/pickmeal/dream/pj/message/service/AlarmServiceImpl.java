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
		ad.addAlarm(alarm);
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
	public boolean deleteAlarm(long id) {
		ad.deleteAlarm(id);
		if (!ad.isAlarm(id)) {
			return false;
		}
		return true;
	}

}
