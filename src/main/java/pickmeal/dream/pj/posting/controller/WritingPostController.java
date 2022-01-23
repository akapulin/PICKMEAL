package pickmeal.dream.pj.posting.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.java.Log;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.posting.command.PostingCommand;
import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.service.PostingService;
import pickmeal.dream.pj.restaurant.domain.Restaurant;
/**
 * 
 * @author 윤효심	
 *
 */

@Controller
@Log
public class WritingPostController {
	@Autowired
	PostingService ps;
	
	
	/**
	 * 글쓰기 폼으로 이동
	 * 		- 각 게시판에서 글쓰기 버튼을 누를때, 
	 * 		  게시판에 해당하는 글쓰기 폼으로 간
	 * 	
	 * @param request
	 * @return
	 */

	@GetMapping("/posting/{type}/write")
	public ModelAndView writingPostMain(@PathVariable String type) {
			
		ModelAndView mav = new ModelAndView();
		if(type.equals("notice")) {
			mav.addObject("postType",'N');
		}else if(type.equals("recommend")) {
			mav.addObject("postType",'R');
		}else {
			mav.addObject("postType",'E');
		}
		
		mav.setViewName("posting/post_write");
		return mav;
	}
	
	/**
	 * 글쓰기 완료
	 * 		1) 테이블에 포스팅 정보 저장
	 * 		2) 저장한 정보 다시 테이블에서 불러서 글 읽기 폼으로 전달
	 * @param pc
	 * @return
	 */
	@PostMapping("completeWritingPost")
	public ModelAndView completeWritingPost(@ModelAttribute PostingCommand pc) {

		
		log.info("hi complete"+pc.toString());
		
		
		
		
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("posting/post_read");
		return mav;
	}

}
