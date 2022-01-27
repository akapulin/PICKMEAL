package pickmeal.dream.pj.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.java.Log;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.member.service.MemberService;
import pickmeal.dream.pj.member.util.PasswordDecoding;
import pickmeal.dream.pj.member.util.PasswordEncoding;
import pickmeal.dream.pj.posting.command.CommentCommand;
import pickmeal.dream.pj.posting.domain.Comment;
import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.domain.TogetherEatingPosting;
import pickmeal.dream.pj.posting.service.CommentService;
import pickmeal.dream.pj.posting.service.PostingService;
import pickmeal.dream.pj.posting.util.Criteria;
import pickmeal.dream.pj.posting.util.PageMaker;

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
	
	@Autowired
	PostingService ps;
	
	@Autowired
	MemberService ms;
	
	@Autowired
	PasswordDecoding pd;
	
	@Autowired
	private PasswordEncoding pe;
	
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
		for(Comment c : rComments) {
			Posting po = c.getPosting();
			po.setTitle(ps.findPostingTitleById('R', po.getId()));
			c.setPosting(po);
		}
		
		List<Comment> eComments = cs.findAllCommentByMemberId(member.getId(), 'E');
		for(Comment c : eComments) {
			Posting po = c.getPosting();
			po.setTitle(ps.findPostingTitleById('E', po.getId()));
			c.setPosting(po);
		}
		
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
	
	//내 게시글
	@GetMapping("/member/myPostings")
	public ModelAndView myPostings(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member member = (Member) session.getAttribute("member");
		if(member == null) {
			mav.setViewName("redirect:/member/viewSignIn");
			return mav;
		}
		
		mav = myPostings(session, "recommend", new Criteria());
		
		mav.setViewName("member/my_postings");
		return mav;
	}
	//내 게시글 - 분류
	@GetMapping("/member/myPostings/{type}")
	public ModelAndView myPostings(HttpSession session, @PathVariable String type, Criteria criteria) {
		ModelAndView mav = new ModelAndView();
		Member member = (Member) session.getAttribute("member");
		if(member == null) {
			mav.setViewName("redirect:/member/viewSignIn");
			return mav;
		}
		
		mav.addObject("postType", type.equals("recommend")? 'R':(type.equals("together")? 'E':'N'));

		criteria.setType(type);
		int postTotalCnt = ps.getPostingCountByCategoryAndMemberId(member.getId(), criteria.getType());
		if(postTotalCnt > 0) {
			int pageTotal = postTotalCnt%12 > 0 ? (postTotalCnt/12)+1 : postTotalCnt/12;
			if(postTotalCnt > 10 && pageTotal < criteria.getPage()) {
				mav.setViewName("redirect:/member/myPostings/"+ type +"?page="+pageTotal);
				return mav;
			}
			
			PageMaker pageMaker = new PageMaker(postTotalCnt,criteria);
			log.info("PageMaker type : "+ pageMaker.getCriteria().getType()+" page : "+pageMaker.getCriteria().getPage()+" totalCnt : "+pageMaker.getTotal());
			mav.addObject("pageMaker", pageMaker);

			List<Posting> myPostings = ps.findPostingsPerPageByMemberId(member.getId(), pageMaker.getCriteria());
			mav.addObject("myPostings", myPostings);	
		}
		mav.addObject("here", "myPostings");
		mav.setViewName("member/my_postings");
		return mav;
	}
	//내 게시글 - 삭제
	@PostMapping("/member/delPost/{type}")
	public ModelAndView delPost(@PathVariable String type, @RequestParam("postId") long postId) {
		ModelAndView mav = new ModelAndView();
		Posting post = null;
		
		if(type.equals("recommend")) {
			post = new Posting(postId,'R');
		} else if(type.equals("together")) {
			post = new TogetherEatingPosting();
			post.setId(postId);
			post.setCategory('E');
		}
		ps.deletePosting(post);
		log.info("postId: " + post.getId() + " category: " + post.getCategory());
		log.info("post has been deleted.");
		
		mav.setViewName("redirect:/member/myPostings/"+type);
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
		
		mav.addObject("member", member);
		mav.setViewName("member/my_information");
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping(value="/checkOriginPw")
	public String checkOriginPw(@RequestParam("originPw")String originPw, HttpSession session){
		Member member = (Member)session.getAttribute("member");
		
		String check = null;
		
		member = ms.findMemberByMemberEmail(member.getEmail());
		
		member = pd.convertPassword(member); 
		
		//비밀번호 확인시 정확하게 비밀번호 입력했을 때
		if(originPw.equals(member.getPasswd()) ) {
			check = "S";
		}else { // 틀리게 입력했을 때
			check = "F";
		}
		return check;
	}
	
	@ResponseBody
	@PostMapping(value="/changePw")
	public void changePw(@RequestParam("newPw")String newPw, HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		
		member.setPasswd(newPw);
		
		member = pe.convertPassword(member);
		
		//새 비밀번호 db에 세팅
		ms.updatePasswd(member);
		
		member.setPasswd("");

		session.setAttribute("member", member);
	}
	
	@ResponseBody
	@GetMapping(value="/deleteMember")
	public void deleteBtn(HttpSession session) {
		Member member = (Member)session.getAttribute("member");

		//삭제시 db에 멤버 타입 D로 변경
		member.setMemberType('D');
		
		ms.deleteMember(member);
	}
}
