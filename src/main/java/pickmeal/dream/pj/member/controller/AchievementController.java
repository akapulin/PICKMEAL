package pickmeal.dream.pj.member.controller;

import static pickmeal.dream.pj.web.constant.Constants.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.java.Log;
import pickmeal.dream.pj.member.domain.FoodPowerPointItem;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.member.service.MemberAchievementService;
import pickmeal.dream.pj.web.constant.Constants;

@Log
@Controller
public class AchievementController {
	
	@Autowired
	MemberAchievementService mas;
	
	@GetMapping("/member/updateAchievementInfo")
	@ResponseBody
	public ModelAndView updateAchievementInfo(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member member = (Member)session.getAttribute("member");
		
		System.out.println(member); 
		List<FoodPowerPointItem> fppList = new ArrayList<FoodPowerPointItem>();
			
		// 식력 포인트 보내기
		Constants fppMin = null;
		Constants fppMax = null;
		
		if(member == null) {
			mav.setViewName("redirect:/member/viewSignIn");
			return mav;
		}
		
		if(member.getFoodPowerPoint() <= LEVEL1.getPoint()) { // 0 ~ 300
			fppMin = LEVEL0;
			fppMax = LEVEL1;
		}else if(member.getFoodPowerPoint() <= LEVEL2.getPoint()) { // 300 ~ 1000
			fppMin = LEVEL1;
			fppMax = LEVEL2;
		}else if(member.getFoodPowerPoint() <= LEVEL3.getPoint()) { // 1000 ~ 5000
			fppMin = LEVEL2;
			fppMax = LEVEL3;
		}else if(member.getFoodPowerPoint() <= LEVEL4.getPoint()) { // 5000 ~ 15000 
			fppMin = LEVEL3;
			fppMax = LEVEL4;
		}else if(member.getFoodPowerPoint() <= LEVEL5.getPoint()){ // 15000 ~ 50000
			fppMin = LEVEL4;
			fppMax = LEVEL5;
		}else{//5만 이상
			fppMin = LEVEL5;
			fppMax = LEVEL5;
		}
		
		System.out.println(fppMin);
		System.out.println(fppMin.getImgPath());
		System.out.println(fppMax);
		
		double necessaryPoint = fppMax.getPoint() - fppMin.getPoint();
		System.out.println(necessaryPoint);
		// 식력 내역 보내기
		fppList = mas.findFoodPowerPointRecordByMemberId(member.getId());
		
		// 당연히 member가 있을 수 밖에 없긴 한데 도메인으로 들어오는 경우를 생각해서 걸러줘야 하는거 아닌가?
		
		mav.addObject("member", member);
		
		mav.addObject("necessaryPoint",necessaryPoint);
		mav.addObject("fppMin", fppMin);
		mav.addObject("fppMax", fppMax);
		
		mav.addObject("fppList", fppList);
		
		mav.addObject("here", "achievment");
		mav.setViewName("member/achievement");
		return mav;
	}

}
