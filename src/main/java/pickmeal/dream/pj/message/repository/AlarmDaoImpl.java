package pickmeal.dream.pj.message.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import pickmeal.dream.pj.message.domain.Alarm;

@Repository("alarmDao")
public class AlarmDaoImpl implements AlarmDao {
	
	@Autowired
	private JdbcTemplate jt;

	@Override
	public void addAlarm(Alarm alarm) {
		String sql = "INSERT INTO AlarmRecord(memberId, friendId, alarmType, content)"
				+ " VALUES (?, ?, ?, ?)";
		jt.update(sql, alarm.getMember().getId(), alarm.getFriend().getId(), String.valueOf(alarm.getAlarmType()), alarm.getContent());
	}

	@Override
	public List<Alarm> findAllAlarmByMemberId(long memberId) {
		String sql = "SELECT id, memberId, friendId, alarmType, content, regDate"
				+ " FROM AlarmRecord WHERE memberId=?";
		return jt.query(sql, new AlarmRowMapper(), memberId);
	}

	@Override
	public void deleteAlarm(long id) {
		String sql = "DELETE FROM AlarmRecord WHERE id=?";
		jt.update(sql, id);
	}

	@Override
	public boolean isAlarm(long id) {
		String sql = "SELECT EXISTS (SELECT id FROM AlarmRecord WHERE id=?)";
		return jt.queryForObject(sql, Boolean.class, id);
	}

	@Override
	public boolean isAlarmByMemberId(long memberId) {
		String sql = "SELECT EXISTS (SELECT id FROM AlarmRecord WHERE memberId=?)";
		return jt.queryForObject(sql, Boolean.class, memberId);
	}

}
