package pickmeal.dream.pj.game.controller;

import static pickmeal.dream.pj.web.constant.SavingPointConstants.*;
import java.util.ArrayList;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.java.Log;
import pickmeal.dream.pj.coupon.domain.CouponCategory;
import pickmeal.dream.pj.coupon.service.CouponService;
import pickmeal.dream.pj.game.service.GameService;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.member.service.MemberAchievementService;
import pickmeal.dream.pj.message.domain.Alarm;
import pickmeal.dream.pj.message.service.AlarmService;
import pickmeal.dream.pj.message.service.MessageService;
import pickmeal.dream.pj.restaurant.command.RestaurantCommand;
import pickmeal.dream.pj.restaurant.domain.Restaurant;
import pickmeal.dream.pj.restaurant.service.FavoriteRestaurantSerivce;

import pickmeal.dream.pj.restaurant.service.RestaurantService;
import pickmeal.dream.pj.web.util.Validator;


@Controller
@Log
public class GameController {
	
	@Autowired
	AlarmService as;
	
	@Autowired
	GameService gs;
	
	@Autowired
	MessageService msgs;
	
	@Autowired
	Validator validator;
	
	/*쿠폰 서비스 추가 - 정원식*/
	@Autowired
	CouponService cs;
	/*찜 버튼 추가 -정원식*/
	@Autowired
	FavoriteRestaurantSerivce frs;
	
	@Autowired
	MemberAchievementService mas;
	
	@Autowired
	RestaurantService rs;
	
	@GetMapping("/openGamePopUp")
	public String openGamePopUp() {
		return "gamePlay";
	}
	
	@GetMapping("/sendDataToPopUp")
	public ModelAndView sendDataToPopUp(@RequestParam("radius")String radius, @RequestParam("category")String category, 
			@RequestParam("nowLat")String nowLat, @RequestParam("nowLng")String nowLng, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();		
		
		Member member = (Member)session.getAttribute("member");
		
		int diffOfDate = 0;
		
		if(validator.isEmpty(member)) {
			// 비회원 일 때.
		} else {
			// 회원일 때. cntForRetry도 무조건 있다는 말이긴 함.
			int cntForRetry = (int)session.getAttribute("cntForRetry");			
			cntForRetry++;

			String firstGameMsg;
			
			
			// 마지막 게임이 언제였는지를 오늘 날짜와 차이로 나타내준다.
			// LastGameRecord 테이블 안에 로그인한 Id의 게임 기록이 없을 때. 어떻게 할 것인가. 
			diffOfDate = gs.checkLastGameRecord(member.getId());
			//차이가 0이 아니면 => 즉, 오늘 첫게임이면 first msg 보낸다.
			if(diffOfDate != 0) {
				firstGameMsg = msgs.bringFirstMsg();
				mav.addObject("firstGameMsg", firstGameMsg); //첫 게임일 경우 안내 메세지 보냄.
			} else {}
			session.setAttribute("cntForRetry", cntForRetry);
			mav.addObject("cntForRetry", cntForRetry);
		}
		session.removeAttribute("couponCategory");
		mav.addObject("radius", radius);
		mav.addObject("category", category);
		mav.addObject("nowLat", nowLat);
		mav.addObject("nowLng", nowLng);
		mav.addObject("diffOfDate", diffOfDate); // 얘는 첫 겜인지 아닌지 js에서 조건 줄 때 쓰려고 보냄.
		
		mav.setViewName("game/gamePlay");
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping(value="/bringResListForCardGame", produces="application/json; charset=utf8")
	public ResponseEntity<?> bringResListForCardGame(@RequestParam("jsonOfFinalArr")String fiveRes, @RequestParam("gameType")char gameType) {
		Map<String, Object> res = new HashMap<String, Object>();
		List<Restaurant> resList;
		
		List<Map<String, Object>> resultMap = JSONArray.fromObject(fiveRes);
				
		resList = rs.bringResList(resultMap);

		return ResponseEntity.ok(resList);
	}
	
	@ResponseBody
	@PostMapping(value="/bringResListForLadderGame", produces="application/json; charset=utf8")
	public Map<String, Object> bringResListForLadderGame(@RequestParam("jsonOfFinalArr")String fiveRes, @RequestParam("gameType")char gameType) {
		Map<String, Object> res = new HashMap<String, Object>();
		Map<String, Object> sendMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> sendData = new ArrayList<HashMap<String,Object>>();
		
		List<Restaurant> resList;
		
		List<Map<String, Object>> resultMap = JSONArray.fromObject(fiveRes);
		
		resList = rs.bringResList(resultMap);
		
		// 여기서는 사다리 값이랑 같이 세팅해서 던져야한다.
		String[][] ladder;
		Map<Integer, List<String>>setOfRoute = new HashMap<Integer, List<String>>(); 
		
		ladder = gs.makeLadder(resList);
		gs.makeRoute(ladder, setOfRoute);
		
		sendMap.put("ladder", ladder);
		sendMap.put("setOfRoute", setOfRoute);
		sendMap.put("resList", resList); // 레스토랑 5개 리스트도 보낸다. 
		
		//resList 를 가지고 게임서비스로 고고. 
		return sendMap;
	}
	
	@ResponseBody
	@PostMapping(value="/bringResResultOfGame", produces="application/json; charset=utf8")
	public ResponseEntity<?> bringResResultOfGame(@ModelAttribute RestaurantCommand rc, HttpSession session) {
		
		Restaurant restaurant = new Restaurant();
		
		restaurant.setId(rc.getId());
		restaurant.setAddress(rc.getAddress());
		restaurant.setApiId(rc.getApiId());
		restaurant.setRName(rc.getRname());
		restaurant.setLat(rc.getLat());
		restaurant.setLng(rc.getLng());
		restaurant.setRType(rc.isRtype());
		
		Member member = (Member)session.getAttribute("member");
		HashMap<String,String> map = new HashMap<String, String>();
		
		if(validator.isEmpty(member)) {
			// 비회원 일 때.
		} else {
			//회원일 때 가장 최근 게임을 테이블에 넣기.
			gs.insertLastGameRecord(member.getId(), restaurant.getId());
			 
			Alarm alarm = new Alarm();
			Member friend = new Member();
			friend.setId(0);
			alarm.setMember(member);
			alarm.setFriend(friend);
			alarm.setAlarmType('L');
			alarm.setContent(rc.getRname());
			
			as.addAlarm(alarm); // 알람 레코드에 추가
			
			member = mas.addFoodPowerPointItem(member, PLAY_GAME);
		}
		session.setAttribute("restaurant", restaurant);
		map.put("rid", Long.toString(restaurant.getId()));
		/**
		 * 정원식
		 * 쿠폰 발급 유무 추가
		 */
		if(restaurant.isRType()== true) {
			/*멤버라면?*/
			if(member !=null) {
				/*오늘 받은 쿠폰개수 확인 해주기*/
				if(cs.findCouponByMemberIdinToday(member.getId())==1) {
					if(cs.findCouponBymemberIdinTodayMax(member.getId())<=2) {
						
						/*제휴 레스토랑이면 메소드 돌려서 쿠폰나오면 발급 해주기*/
						CouponCategory couponCategory = cs.findCouponCategoryGo();
						
						/*쿠폰이 발급이 안된 경우 리턴값이 없을 경우 그냥 통과*/
						if(couponCategory == null) {
							/*찜식당 확인 찜식당 이면*/
							if(frs.isFavoriteRestaurant(member.getId(), restaurant.getId())) {
								return ResponseEntity.ok(null);
								/*찜식당 확인 찜식당 아니면*/
							}else {
								map.put("restaurant", "restaurant");
								return ResponseEntity.ok(map); 
							}
						}
						/*쿠폰이 발급 된 경우*/
						else{
							/*쿠폰이 발급이 되어 리턴값이 있을 경우는 세션에 저장 레스토랑, 쿠폰카테고리.*/
							session.setAttribute("couponCategory", couponCategory);
							
							/*리턴할 쿠폰, 찜식당 버튼을 위한 전달*/
							map.put("couponCategory", "couponCategory");
							if(frs.isFavoriteRestaurant(member.getId(), restaurant.getId())) {
								return ResponseEntity.ok(map);
							}else {
								map.put("restaurant", "restaurant");
								return ResponseEntity.ok(map); 
							}
						}
					}
					/*오늘받은 쿠폰이 3개인 경우 그냥 통과*/
					else {
						if(frs.isFavoriteRestaurant(member.getId(), restaurant.getId())) {
							return ResponseEntity.ok(null);
						}else {
							map.put("restaurant", "restaurant");
							return ResponseEntity.ok(map); 
						}						
					}
					/*오늘 발급 받은적 없으면*/
				}else {
					/*제휴 레스토랑이면 메소드 돌려서 쿠폰나오면 발급 해주기*/
					CouponCategory couponCategory = cs.findCouponCategoryGo();
					
					
					/*쿠폰이 발급이 안된 경우 리턴값이 없을 경우 그냥 통과*/
					if(couponCategory == null) {
						if(frs.isFavoriteRestaurant(member.getId(), restaurant.getId())) {
							return ResponseEntity.ok(null);
						}else {
							map.put("restaurant", "restaurant");
							return ResponseEntity.ok(map); 
						}
					}
					/*쿠폰이 발급 된 경우*/
					else{
						/*쿠폰이 발급이 되어 리턴값이 있을 경우는 세션에 저장 레스토랑, 쿠폰카테고리.*/
						session.setAttribute("couponCategory", couponCategory);
						
						/*리턴할 쿠폰, 찜식당 버튼을 위한 전달*/
						/*버튼을 위한것이라 리턴값에 그대로 전달.*/
						map.put("couponCategory", "couponCategory");
						if(frs.isFavoriteRestaurant(member.getId(), restaurant.getId())) {
							return ResponseEntity.ok(map);
						}else {
							map.put("restaurant", "restaurant");
							return ResponseEntity.ok(map); 
						}
					}
				}
			}
			/*제휴식당이면서, 멤버가 아니라면*/
			else {
				CouponCategory couponCategory = cs.findCouponCategoryGo();
				/*쿠폰이 발급이 안되서 리턴값이 없을 경우 그냥 통과*/
				if(couponCategory == null) {
				}else {

				session.setAttribute("couponCategory", couponCategory);
					map.put("couponCategory", "couponCategory");
					return ResponseEntity.ok(map);
					
				}
			}
		}
		/*제휴 없는 식당은 그냥 통과*/
		else {
			if(member !=null) {
				if(frs.isFavoriteRestaurant(member.getId(), restaurant.getId())) {
					return ResponseEntity.ok(null);
				}else {
					map.put("restaurant", "restaurant");
					return ResponseEntity.ok(map); 
				}	
			}	
		}
		return ResponseEntity.ok(null);
	}	
}

