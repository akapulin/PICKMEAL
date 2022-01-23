package pickmeal.dream.pj.posting.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.java.Log;
import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.service.PostingService;

/**
 * 
 * @author 윤효심
 *
 */
@Controller
@Log
public class ReadingPostController {
	
	@Autowired
	PostingService ps;
	
	/**
	 * 게시글 읽어오기
	 * 
	 * @param id
	 * @return
	 */
	@GetMapping("/posting/{type}/{id}")
	public ModelAndView readPostView(@PathVariable int id, @PathVariable String type) {
		ModelAndView mav = new ModelAndView();
		
		Posting posting;
		if(type.equals("notice")) {
			posting = ps.findPostingById('N', id);
		}else if(type.equals("recommend")) {
			posting = ps.findPostingById('R', id);
		}else {
			posting = ps.findPostingById('E', id);
		}
		mav.addObject("post", posting);
		
		mav.setViewName("posting/post_read");
		return mav;
	}
}
