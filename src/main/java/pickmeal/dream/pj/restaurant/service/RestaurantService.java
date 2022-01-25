package pickmeal.dream.pj.restaurant.service;

import java.util.List;
import java.util.Map;

import pickmeal.dream.pj.restaurant.domain.Restaurant;

public interface RestaurantService {
	public List<Restaurant> bringResList(List<Map<String, Object>> resultMap); 
	
	public Restaurant findRestaurantByAddress(Restaurant restaurant);
	
	public Restaurant findRestaurantByrType(Restaurant restaurant);
	
	public Restaurant findRestaurantById(long id);
	
	public Restaurant findRestaurantbyApiId(long apiId);
}
