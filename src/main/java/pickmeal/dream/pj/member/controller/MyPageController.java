package pickmeal.dream.pj.member.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.java.Log;
import pickmeal.dream.pj.member.domain.Member;
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
   
   @GetMapping("/member/myPostings/{type}")
   public ModelAndView myPostings(HttpSession session, @PathVariable String type, Criteria criteria) {
      ModelAndView mav = new ModelAndView();
      Member member = (Member) session.getAttribute("member");
      if(member == null) {
         mav.setViewName("redirect:/member/viewSignIn");
         return mav;
      }

      criteria.setType(type);

      PageMaker pageMaker = new PageMaker(ps.getPostingCountByCategory(criteria.getType()),criteria);
      log.info("PageMaker type : "+ pageMaker.getCriteria().getType()+" page : "+pageMaker.getCriteria().getPage()+" totalCnt : "+pageMaker.getTotal());
      mav.addObject("pageMaker", pageMaker);

      List<Posting> myPostings = ps.findPostingsPerPageByMemberId(member.getId(), pageMaker.getCriteria());
      mav.addObject("myPostings", myPostings);
      
      mav.addObject("here", "myPostings");
      
      mav.setViewName("member/my_postings");
      return mav;
   }
   
//   @GetMapping("/posting/{type}")
//   public ModelAndView listPostView(Criteria criteria, @PathVariable String type ) {
//      ModelAndView mav = new ModelAndView();
//      
//      //게시판 카테고리별 셋팅 1줄로 가능!
//      criteria.setType(type);
//      
//      //게시판 페이징 처리 클래스 셋팅하기
//      PageMaker pageMaker = new PageMaker(ps.getPostingCountByCategory(criteria.getType()),criteria);
//      log.info("PageMaker type : "+ pageMaker.getCriteria().getType()+" page : "+pageMaker.getCriteria().getPage()+" totalCnt : "+pageMaker.getTotal());
//      mav.addObject("pageMaker", pageMaker);
//      
//      //게시물 불러오기
//      List<Posting> postings = ps.findPostingsPerPageByCategory(pageMaker.getCriteria());
//      mav.addObject("postings", postings);
//      
//      //게시판이 밥친구일 경우, 업캐스팅 해준다
//      if(pageMaker.getCriteria().getType()=='E') {
//         @SuppressWarnings("unchecked")
//         List<TogetherEatingPosting> togetherPostings = (List<TogetherEatingPosting>)(Object)postings;
//         mav.addObject("postings", togetherPostings);
//      }
//      
//      mav.setViewName("/posting/post_list");
//      return mav;
//      
//      
//   }
}