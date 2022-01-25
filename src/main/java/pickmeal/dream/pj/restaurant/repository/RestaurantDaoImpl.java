package pickmeal.dream.pj.restaurant.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import pickmeal.dream.pj.restaurant.domain.Restaurant;

@Repository("restaurantDao")
public class RestaurantDaoImpl implements RestaurantDao {
	
	@Autowired
	JdbcTemplate jt;
	
	@Override
	public void insertRestaurant(Restaurant restaurant) {
		// apiId로 비교하여 테이블에 없으면 insert, 있으면 무시.
		String sql = "INSERT IGNORE INTO Restaurant(lat, lng, address, rName, apiId) VALUES(?, ?, ?, ?, ?)";
		
		jt.update(sql, restaurant.getLat(), restaurant.getLng(), restaurant.getAddress(), restaurant.getRName(), restaurant.getApiId());
	}
	
	@Override
	public Restaurant findRestaurantByAddress(Restaurant restaurant) {
		String sql = "SELECT id, rType, lat, lng, address, rName"
				+ " FROM Restaurant WHERE address = ?";
		restaurant = jt.queryForObject(sql, new RestaurantRowMapper(), restaurant.getAddress()); 
		
		return restaurant;
	}

	@Override
	public Restaurant findRestaurantByrType(Restaurant restaurant) {
		String sql = "SELECT id, rType, lat, lng, address, rName"
				+ " FROM Restaurant WHERE address = ?";
		restaurant = jt.queryForObject(sql, new RestaurantRowMapper(), restaurant.isRType());
		return restaurant;
	}

	@Override
	public Restaurant findRestaurantById(long id) {
		
		String sql = "SELECT id, apiId, rType, lat, lng, address, rName"
				+ " FROM Restaurant WHERE Id = ?";
		Restaurant restaurant = jt.queryForObject(sql, new RestaurantRowMapper(), id);
		return restaurant;
	}
	public Restaurant findRestaurantbyApiId(long apiId) {
		String sql = "SELECT id, apiId, rType, lat, lng, address, rName FROM Restaurant WHERE apiId = ?";
				
		return jt.queryForObject(sql, new RestaurantRowMapper(), apiId);
	}

}
