package pickmeal.dream.pj.restaurant.service;

import pickmeal.dream.pj.restaurant.domain.RestaurantGraph;
import pickmeal.dream.pj.restaurant.domain.RestaurantReference;

/**
 * 
 * @author 윤효심
 *
 */
public interface RestaurantReferenceService {
	
	/**
	 * 해당 레스토랑 ID를 가지고, 레스토랑의 성별 정보를 DAO에서 가져온다
	 * @param restaurantId
	 * @return
	 */
	public RestaurantReference getRestaurantReference(long restaurantId);
	
	/**
	 * 레스토랑 성별 그래프 테이블 추가
	 * @param rg
	 */
	public void addRestaurantReference(RestaurantGraph rg);
}
