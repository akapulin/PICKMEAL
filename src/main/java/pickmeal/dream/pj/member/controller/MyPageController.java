package pickmeal.dream.pj.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.posting.domain.Comment;
import pickmeal.dream.pj.posting.service.CommentService;

@Controller
public class MyPageController {
	
	@Autowired
	CommentService cs;
	
//	@GetMapping("/member/myPage")
//	public ModelAndView myPage(@SessionAttribute("member") Member member) {
//		ModelAndView mav = new ModelAndView();
//		System.out.println(member);
//		mav.setViewName("member/my_page");
//		return mav;
//	}
	
	@GetMapping("/member/myPostings")
	public ModelAndView myPostings(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member member = (Member) session.getAttribute("member");
		if(member == null) {
			mav.setViewName("redirect:/member/viewSignIn");
			return mav;
		}
		
		mav.addObject("here", "myPostings");
		
		mav.addObject("memberId", member.getId());
		
		mav.setViewName("member/my_postings");
		return mav;
	}
	
	@GetMapping("member/myComments")
	public ModelAndView myComments(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member member = (Member) session.getAttribute("member");
		if(member == null) {
			mav.setViewName("redirect:/member/viewSignIn");
			return mav;
		}
		
		mav.addObject("here", "myComments");
		
		List<Comment> rComments = cs.findAllCommentByMemberId(member.getId(), 'R');
		List<Comment> eComments = cs.findAllCommentByMemberId(member.getId(), 'E');
		
		mav.addObject("rComments", rComments);
		mav.addObject("eComments", eComments);
		
		mav.setViewName("member/my_comments");
		return mav;
	}
}
