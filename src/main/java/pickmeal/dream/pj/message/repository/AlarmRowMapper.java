package pickmeal.dream.pj.message.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.message.domain.Alarm;

public class AlarmRowMapper implements RowMapper<Alarm> {

	@Override
	public Alarm mapRow(ResultSet rs, int rowNum) throws SQLException {
		Alarm alarm = new Alarm();
		alarm.setId(rs.getLong("id"));
		alarm.setMember(new Member(rs.getLong("memberId")));
		alarm.setFriend(new Member(rs.getLong("friendId")));
		alarm.setAlarmType(rs.getString("alarmType").charAt(0));
		alarm.setContent(rs.getString("content"));
		alarm.setRegDate(new Date(rs.getTimestamp("regDate").getTime()));
		
		return alarm;
	}

}
