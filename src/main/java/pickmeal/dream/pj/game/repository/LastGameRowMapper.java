package pickmeal.dream.pj.game.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import pickmeal.dream.pj.game.domain.LastGame;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.restaurant.domain.Restaurant;

public class LastGameRowMapper implements RowMapper<LastGame> {

	@Override
	public LastGame mapRow(ResultSet rs, int rowNum) throws SQLException {
		LastGame lg = new LastGame();
		
		lg.setId(rs.getLong("id"));
		lg.setRestaurant(new Restaurant(rs.getLong("restaurantId")));
		lg.setMember(new Member(rs.getLong("memberId")));
		lg.setRegDate(new Date(rs.getTimestamp("regDate").getTime()));
		
		return lg;
	}

}
