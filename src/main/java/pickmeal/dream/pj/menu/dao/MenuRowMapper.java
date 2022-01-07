package pickmeal.dream.pj.menu.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import pickmeal.dream.pj.menu.domain.Menu;
import pickmeal.dream.pj.menu.domain.Menuclassify;

public class MenuRowMapper implements RowMapper<Menu>{

	@Override
	public Menu mapRow(ResultSet rs, int rowNum) throws SQLException {
		Menu menu = new Menu();
		menu.setId(rs.getLong("id"));
		Menuclassify menuclassify = new Menuclassify(rs.getInt("soupy"),rs.getInt("hot_ice"),rs.getInt("carhobydrate"),rs.getInt("mainFood"),rs.getInt("spicy"));
//		Menu menu = new Menu(rs.getLong("id"),rs.getString("Menuname"),rs.getInt("weather"),rs.getString("imgPath"),rs.getObject(menuclassify));
		menu.setMenuname(rs.getString("menuname"));
		menu.setWeather(rs.getInt("weather"));
		menu.setImgPath(rs.getString("imgPath"));
		menu.setMenuclassify(menuclassify);
		
		return menu;
	}

}
