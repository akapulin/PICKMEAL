package pickmeal.dream.pj.restaurant.repository;

import pickmeal.dream.pj.restaurant.domain.Restaurant;

public interface RestaurantDao {
	
	/**
	 * 쿠폰 발급 시점
	 * @param address
	 * @return
	 */
	
	public void insertRestaurant(Restaurant restaurant); 
	
	public Restaurant findRestaurantByAddress(Restaurant restaurant);
	
	public Restaurant findRestaurantByrType(Restaurant restaurant);
	
	public Restaurant findRestaurantById(long id);
	
	public Restaurant findRestaurantbyApiId(long apiId);	
	
}
