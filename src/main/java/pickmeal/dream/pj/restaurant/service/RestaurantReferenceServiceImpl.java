package pickmeal.dream.pj.restaurant.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pickmeal.dream.pj.restaurant.domain.RestaurantGraph;
import pickmeal.dream.pj.restaurant.domain.RestaurantReference;
import pickmeal.dream.pj.restaurant.repository.RestaurantReferenceDao;

@Service("restarauntReferenceService")
public class RestaurantReferenceServiceImpl implements RestaurantReferenceService {
	
	@Autowired
	RestaurantReferenceDao rrd;

	@Override
	public RestaurantReference getRestaurantReference(long restaurantId) {
		return rrd.getRestaurantReference(restaurantId);
	}

	@Override
	public void addRestaurantReference(RestaurantGraph rg) {
		// 우선 나이를 셋팅하고
		rg.makeAge();
		// 테이블에 추가
		rrd.addRestaurantReference(rg);
	}
	
	
}
