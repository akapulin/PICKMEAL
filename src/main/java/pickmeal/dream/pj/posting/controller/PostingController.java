package pickmeal.dream.pj.posting.controller;

import static pickmeal.dream.pj.web.constant.Constants.COMMENT_LIST;
import static pickmeal.dream.pj.web.constant.SavingPointConstants.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;
import lombok.extern.java.Log;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.member.service.MemberAchievementService;
import pickmeal.dream.pj.posting.command.PostingCommand;
import pickmeal.dream.pj.posting.domain.Comment;
import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.domain.TogetherEatingPosting;
import pickmeal.dream.pj.posting.service.CommentService;
import pickmeal.dream.pj.posting.service.PostingService;
import pickmeal.dream.pj.posting.util.Criteria;
import pickmeal.dream.pj.posting.util.PageMaker;
import pickmeal.dream.pj.web.util.Validator;

/**
 * 
 * @author 윤효심
 *
 */
@Controller
@Log
public class PostingController {
	
	@Autowired
	PostingService ps;

	@Autowired
	CommentService cs;
	
	@Autowired
	Validator v;
	
	@Autowired
	MemberAchievementService mas;

	/* 
	 * 
	 * 이슈1) 
	 * 게시판별 변수 2개만 셋팅해줬을 뿐인데 이런 코드 길이가~~?
	 * !!!! 이렇게는 만들지 말자~! => 다중매핑사용
	 * 
	 * 
	 * 
	@GetMapping("/post_list/notice")
	public ModelAndView listPostNotice(@RequestParam int page) {
		ModelAndView mav = new ModelAndView();
		int postCnt=0;
		
		//총 게시물 수 ( 페이징 관련 )
		postCnt = ps.getPostingCountByCategory('N');
		
		//1page당 보여질 게시물
		List<Posting> listPost = ps.findPostingsPerPageByCategory('N', page);
		
		mav.addObject("postCnt", postCnt);
		mav.addObject("listPost", listPost);
		mav.setViewName("posting/post_list");
		return mav;
	}
	@GetMapping("/post_list/recommend")
	public ModelAndView listPostRecommendRestaurant(@RequestParam int page) {
		ModelAndView mav = new ModelAndView();
		int postCnt=0;
		
		//총 게시물 수 ( 페이징 관련 )
		postCnt = ps.getPostingCountByCategory('R');
		
		//1page당 보여질 게시물
		List<Posting> listPost = ps.findPostingsPerPageByCategory('R', page);
		
		mav.addObject("postCnt", postCnt);
		mav.addObject("listPost", listPost);
		mav.setViewName("posting/post_list");
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	@GetMapping("/post_list/together")
	public ModelAndView listPostTogetherEating(@RequestParam int page) {
		ModelAndView mav = new ModelAndView();
		int postCnt=0;
		
		//총 게시물 수 ( 페이징 관련 )
		postCnt = ps.getPostingCountByCategory('E');
		
		//1page당 보여질 게시물
		List<Posting> listPostT = ps.findPostingsPerPageByCategory('E', page);
		//List 업캐스팅
		List<TogetherEatingPosting> listPost = (List<TogetherEatingPosting>)(Object)listPostT;
		
		mav.addObject("postCnt", postCnt);
		mav.addObject("listPost", listPost);
		mav.setViewName("posting/post_list");
		return mav;
	}
	*/
	
	
	
	/*
	 * 
	 * 다중매핑으로 한개의 함수로 사용하는건 좋았으나...
	 * 이슈2)  
	 * 		어떻게든 지저분하게 URI를 만들고 싶지 않다.
	 * 		그러나 무슨 게시판인지 type설정해줘야했다.
	 * 
	 * 		요구사항 
	 * 				:	URL을 읽고 어떻게는 무슨 게시판인지는 알게 해야겠음
	 *				ex)  http://localhost:8080/pickmeal/posting/notice
	 * 
	 * 		원래방법1) URL에 http://localhost:8080/pickmeal/posting/notice?page=1
	 * 				+) 코드에 아래와 같이 if문 8줄 추가 정말 싫음 
	 * 
	 * 		원래방법2) URL에 Criteria 클래스 안에 있는 type을 지정
	 * 				 http://localhost:8080/pickmeal/posting/notice?type=N&page=1
	 *				-> 게시판 카테고리 정보가 2번이나 들어가서 참을 수가 없음
	 
		//@GetMapping(value = {"/posting/notice", "/posting/recommend", "/posting/together"})
		public ModelAndView listPostView(HttpServletRequest request,Criteria criteria  ) {
			/*
			 * 게시판 카테고리별 셋팅해주기
			 */
			/*
			//현재 페이지 URI 불러오기( ex. /pickmeal/post_list/notice ) 
			String currentURI = request.getRequestURI();
			currentURI = currentURI.split("/")[3];
			
					
			if(currentURI.equals("notice")) {
				criteria.setType('N');
			}
			else if(currentURI.equals("recommend")){
				criteria.setType('R');
			}else {
				criteria.setType('E');
			}
		
	
			PageMaker pageMaker = new PageMaker(ps.getPostingCountByCategory(criteria.getType()),criteria);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/posting/post_list");
			return mav;
			
			
			
		}
		
		*/
		
		
	/**
	 * 카테고리별 게시글 목록 불러오기
	 * 		1) @PathVariable을 이용한다
			2) 게시판 페이별 정보 읽어오는 것은 Criteria 클래스로 처리한다.
	 * 		3) 게시판 페이징 처리는 PageMaker 클래스로 처리한다.
	 * 
	 * 		조건
	 * 		1) 게시판 불러오기 / 게시판 작성 / 게시판 읽기 모두 같은 함수를 실행하도록 한다. => 코드의 재사용성을 높인다
	 * @param page
	 * @return
	 */
	@GetMapping("/posting/{type}")
	public ModelAndView listPostView(Criteria criteria, @PathVariable String type ) {
		ModelAndView mav = new ModelAndView();
		
		//게시판 카테고리별 셋팅 1줄로 가능!
		criteria.setType(type);
		
		//게시판 페이징 처리 클래스 셋팅하기
		PageMaker pageMaker = new PageMaker(ps.getPostingCountByCategory(criteria.getType()),criteria);
		log.info("PageMaker type : "+ pageMaker.getCriteria().getType()+" page : "+pageMaker.getCriteria().getPage()+" totalCnt : "+pageMaker.getTotal());
		log.info("PageStartNum : "+pageMaker.getStartNum()+"PageEndNum : "+pageMaker.getEndNum());
		mav.addObject("pageMaker", pageMaker);
		
		//게시물 불러오기
		List<Posting> postings = ps.findPostingsPerPageByCategory(pageMaker.getCriteria());
		mav.addObject("postings", postings);
		
		//게시판이 밥친구일 경우, object로 업캐스팅 해준다
		if(pageMaker.getCriteria().getType()=='E') {
			@SuppressWarnings("unchecked")
			List<TogetherEatingPosting> togetherPostings = (List<TogetherEatingPosting>)(Object)postings;
			mav.addObject("postings", togetherPostings);
		}
		
		
		
		
		mav.setViewName("/posting/post_list");
		return mav;
		
		
	}
	
	
	
	/**
	 * 게시글 읽어오기
	 * 
	 * @param id
	 * @return
	 */
	@GetMapping("/posting/{type}/{id}")
	public ModelAndView readPostView(@PathVariable int id, @PathVariable String type, @RequestParam("cpageNum") int cpageNum) {
		ModelAndView mav = new ModelAndView();
		
		Posting posting;
		char category = getPostCategory(type);		

		
		//게시글 정보 불러오기
		posting = ps.findPostingById(category, id);
		//조회수 업데이트해주기
		ps.updatePostingViews(category, id);
		posting.setViews(posting.getViews()+1);
		

		mav.addObject("post", posting);
		
		
		
		
		/*
			
			코멘트 - 김보령
		
		*/
		// 항상 pageNum은 1이 default 이다.
		List<Comment> comments = cs.findCommentsByPostId(posting.getId(), category, cpageNum); // 게시물 댓글 1페이지
		int allCmtNum = cs.countCommentByPostId(posting.getId(), category); // 해당 게시글의 총 댓글 수
		// double 형으로 캐스팅을 한 후에 나누기를 해줘야 소수점이 제대로 나온다
		int allPageNum = (int)Math.ceil((double)allCmtNum / (int)COMMENT_LIST.getPoint()); // 페이지 개수 구하기
	
		if (cpageNum > allPageNum) { // 만일 사용자가 url 에 더 큰 값을 적는다면 가장 큰 페이지로 가도록 한다
			cpageNum = allPageNum;
		}
		log.info(String.valueOf(cpageNum));
	
		mav.addObject("comments", comments);
		mav.addObject("allPageNum", allPageNum);
		mav.addObject("allCmtNum", allCmtNum);
		mav.addObject("cpageNum", cpageNum);
		mav.addObject("viewPageNum", (int)COMMENT_LIST.getPoint());
			
		
		
		
		
		
		
		
		
		mav.setViewName("posting/post_read");
		return mav;
	}

		
	/**
	 * 글쓰기 폼으로 이동
	 * 		- 각 게시판에서 글쓰기 버튼을 누를때, 
	 * 		  게시판에 해당하는 글쓰기 폼으로 간
	 * 	****
	 *  항상 수정과 글쓰기 작동이 따로 이루어진다는걸 염두하기
	 * @param request
	 * @return
	 */

	@GetMapping("/posting/{type}/write")
	public ModelAndView writingPostMain(@PathVariable String type) {
			
		ModelAndView mav = new ModelAndView();
		char category = getPostCategory(type);
		
		mav.addObject("modifyState", false);		//수정,글쓰기가 같은 view를 이용하기 때문에 
		mav.addObject("postType",category);
		mav.setViewName("posting/post_write");
		return mav;
	}
	
	/**
	 * 글쓰기 완료
	 * 		1) 테이블에 포스팅 정보 저장
	 * 		2) 저장한 정보 다시 테이블에서 id값 불러서 글 읽기 폼으로 전달
	 * 
	 * 		필요한 후처리
	 * 		- 글쓰기 후 글읽기로가면 뒤로가기 막아야함 
	 * @param pc
	 * @return
	 */
	@PostMapping("/posting/completeWritingPost")
	public String completeWritingPost(@ModelAttribute PostingCommand pc, @SessionAttribute("member") Member member) {
		
		
		log.info("hi posting complete"+pc.toString());
		long memberId = member.getId();
		//long memberId = 4;
	
		//식력포인트 올리기
		member = mas.addFoodPowerPointItem(member, WRITE_POST);
		
		//수정상태면!!!!!!!!!!!!!!
		if(pc.isModifyState()) {
			if(pc.getCategory()=='N') {
				
				Posting post = setNoticePosting(pc,memberId);
				post.setId(pc.getPostId());
				ps.updatePosting(post);
				
				return ("redirect:/posting/notice/"+post.getId()+"?cpageNum=1");
			}else if(pc.getCategory()=='R') {
				Posting post = setRecommendPosting(pc,memberId);
				post.setId(pc.getPostId());
				ps.updatePosting(post);
				
				return ("redirect:/posting/recommend/"+post.getId()+"?cpageNum=1");
			}else{
				Posting post = setTogetherPosting(pc,memberId);
				post.setId(pc.getPostId());
				ps.updatePosting(post);
				
				return ("redirect:/posting/together/"+post.getId()+"?cpageNum=1");
			}
		}
		//글쓰기상태면
		else {
			if(pc.getCategory()=='N') {
				Posting post = ps.addPosting(setNoticePosting(pc,memberId));
				return ("redirect:/posting/notice/"+post.getId()+"?cpageNum=1");
			}else if(pc.getCategory()=='R') {
				Posting post = ps.addPosting(setRecommendPosting(pc,memberId));
				return ("redirect:/posting/recommend/"+post.getId()+"?cpageNum=1");
			}else{
				Posting post = ps.addPosting(setTogetherPosting(pc,memberId));
				return ("redirect:/posting/together/"+post.getId()+"?cpageNum=1");
			}
		}
		
		
		
		

	}
	
	/**
	 * 공지사항 게시판 Posting 셋팅해주기
	 * 		- memberId, title, content, views
	 * 
	 * @param pc
	 * @param memberId
	 * @return
	 */
	private Posting setNoticePosting(PostingCommand pc, long memberId){
		Posting post = new Posting();
		post.setCategory('N');
		post.setMember(new Member(memberId));
		post.setTitle(pc.getTitle());
		post.setContent(pc.getContent());
		post.setViews(1);
		return post;
	}
	
	private Posting setRecommendPosting(PostingCommand pc, long memberId) {
		Posting post = new Posting();
		post.setCategory('R');
		post.setMember(new Member(memberId));
		post.setAddress(pc.getAddress());
		post.setTitle(pc.getTitle());
		post.setContent(pc.getContent());
		post.setLikes(0);
		post.setViews(1);
		return post;
		
	}
	
	private Posting setTogetherPosting(PostingCommand pc, long memberId) {
		TogetherEatingPosting post = new TogetherEatingPosting();
		post.setCategory('E');
		post.setMember(new Member(memberId));
		post.setAddress(pc.getAddress());
		post.setTitle(pc.getTitle());
		post.setContent(pc.getContent());
		post.setLikes(0);
		post.setViews(1);
		post.setMealTime(setMealTimeToDate(pc.getDate(),pc.getTime()));
		post.setRecruitment(true);
		post.setMealChk(false);
		return post;
	
	}
	
	/**
	 * 글쓰기에서 따로 받은 날짜와 시간을 java.util.date 로 바꿔준다.
	 * @param date
	 * @param time
	 * @return
	 */
	private Date setMealTimeToDate(String date, String time) {
		String totalDate = date+" "+time+":00";
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date mealTime = new Date();
		try {
			mealTime = transFormat.parse(totalDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return mealTime;
	}
	
	/**
	 * 비동기
	 * 		- 밥친구 게시판의 모집상태를 변경한다
	 * @param postId
	 */
	@PostMapping("/posting/convertRecruitmentState")
	@ResponseBody
	public String convertRecruitmentState(@RequestParam long postId) {
		boolean state = ps.convertRecruitmentState(postId);
		if(state) {
			return "true";
		}else {
			return "false";
		}
	}
	
	@PostMapping("/posting/removePosting")
	@ResponseBody
	public String deletePosting(@RequestBody HashMap<String,Object> postInfo) {
		char category = postInfo.get("category").toString().charAt(0);
		long postId = Long.parseLong(postInfo.get("postId").toString()); 
		int deleteCnt;
		if(category=='E') {
			deleteCnt = ps.deletePosting(new TogetherEatingPosting(postId,category));
		}else {
			deleteCnt = ps.deletePosting(new Posting(postId,category));
		}
		
		if(deleteCnt>0) {
			return "true";
		}else {
			return "false";
		}

	}
	
	/**
	 * 게시글 수정 
	 * @param type
	 * @return
	 */
	@GetMapping("/posting/{type}/modify/{id}")
	public ModelAndView modifyPostMain(@PathVariable String type, @PathVariable long id) {
			
		ModelAndView mav = new ModelAndView();
		
		char category = getPostCategory(type);
	
		
		Posting posting = ps.findPostingById(category, id);
		
		mav.addObject("modifyState", true);
		mav.addObject("postType",category);
		mav.addObject("postId",id);
		mav.addObject("post",posting);
		mav.setViewName("posting/post_write");
		return mav;
	}
	
	/**
	 * 조건연산자, 삼항연산자를 이용해 코드 줄이기!
	 * @param type
	 * @return
	 */
	public char getPostCategory(String type) {
		
		
		char n =  type.equals("notice") ? 'N':type.equals("recommend") ? 'R':'E';
		return n;
	
		/*
		if(type.equals("notice")) {
			return 'N';
		}else if(type.equals("recommend")) {
			return 'R';
		}else {
			return 'E';
		}
		*/
	}
	
	
}











