package pickmeal.dream.pj.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.member.service.MemberService;
import pickmeal.dream.pj.member.util.PasswordDecoding;
import pickmeal.dream.pj.member.util.PasswordEncoding;

@Controller
public class MyPageController_SJW {
	
	@Autowired
	private PasswordDecoding pd;
	
	@Autowired
	private PasswordEncoding pe;
	
	@Autowired
	private MemberService ms;
	
	@GetMapping("/member/myPage_SJW")
	public ModelAndView myPage_SJW(@SessionAttribute("member") Member member) {
		ModelAndView mav = new ModelAndView();
		System.out.println(member);
		mav.setViewName("member/my_page_SJW");
		return mav;
	}
	
	@GetMapping("/member/myInformation")
	public ModelAndView myInformation(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		Member member = (Member)session.getAttribute("member");
		
		if(member == null) {
			mav.setViewName("redirect:/member/viewSignIn");
			return mav;
		}
		
		member = ms.findMemberById(member.getId());
		member.setPasswd("");
		
		System.out.println(member);
		System.out.println("오잉???");
		mav.addObject("member", member);
		mav.setViewName("member/myInformation");
		
		return mav;
	}
	
//	, produces="application/json; charset=utf8"
	
	@ResponseBody
	@PostMapping(value="/checkOriginPw")
	public String checkOriginPw(@RequestParam("originPw")String originPw, HttpSession session){
		Member member = (Member)session.getAttribute("member");
		
		System.out.println(originPw);
		System.out.println("controller ");

		String check = null;
		
//		System.out.println("아마 널 비번 : " + member.getPasswd());
		member = ms.findMemberByMemberEmail(member.getEmail());
		System.out.println("복호화 전 비번 : " + member.getPasswd());
		member = pd.convertPassword(member); 
		
		System.out.println("복호화 후 비번 : " + member.getPasswd());
		System.out.println("입력한 비번 : " + originPw);
		
		if(originPw.equals(member.getPasswd()) ) {
			// 정확하게 비번 입력함.
			check = "S";
			System.out.println("정확하게 입력");
		}else {
			// 틀리게 입력함.
			check = "F";
			System.out.println("틀림");
		}
		
		return check;
	}
	
	@ResponseBody
	@PostMapping(value="/changePw")
	public void changePw(@RequestParam("newPw")String newPw, HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		
		System.out.println("새 비밀번호 : " + newPw);
		member.setPasswd(newPw);
		System.out.println("비밀번호 변경할 member : "+ member);
		
		member = pe.convertPassword(member);
		
		ms.updatePasswd(member);
		
		System.out.println("변경 후 Member : "+ member);
		
		
		member.setPasswd("");
		System.out.println("변경 후 비번 빼고나서의 Member : "+ member);
		session.setAttribute("member", member);
	}
	@ResponseBody
	@GetMapping(value="/deleteMember")
	public void deleteBtn(HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		
		System.out.println("delete할 member: " + member);
		member.setMemberType('D');
		
		ms.deleteMember(member);
		System.out.println("delete 후 memberType확인 : " + member);
	}
}
