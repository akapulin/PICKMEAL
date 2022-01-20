package pickmeal.dream.pj.member.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.java.Log;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.posting.command.CommentCommand;
import pickmeal.dream.pj.posting.domain.Comment;
import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.service.CommentService;

/**
 * 마이페이지 네비게이션의 각 페이지를 호출한다.
 * @author kimjaeik
 *
 */

@Log
@Controller
public class MyPageController {
	
	@Autowired
	CommentService cs;
	
	//내 게시글
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
	
	//내 댓글
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
	//내 댓글 - 삭제
	@PostMapping("/member/delComment") 
	public String deleteComment(@ModelAttribute CommentCommand cc, @SessionAttribute("member") Member member) {
		log.info(cc.toString() + " " + member.toString());
		Comment comment = new Comment();
		comment.setId(cc.getId());
		comment.setPosting(new Posting((cc.getPostId()), cc.getCategory()));
		comment.setMember(member);
		
		cs.deleteComment(comment);
		
		return "redirect:/member/myComments";
	}
}
