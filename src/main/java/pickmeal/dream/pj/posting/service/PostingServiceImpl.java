package pickmeal.dream.pj.posting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.java.Log;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.member.service.MemberService;
import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.repository.PostingDao;
import pickmeal.dream.pj.posting.util.Criteria;
import pickmeal.dream.pj.restaurant.domain.Restaurant;
import pickmeal.dream.pj.restaurant.repository.RestaurantDao;

/**
 * 
 * @author 윤효심
 *
 */
@Service("postingService")
@Log
public class PostingServiceImpl implements PostingService {

	@Autowired
	PostingDao pd;
	
	@Autowired
	CommentService cs;
	
	@Autowired
	MemberService ms;
	
	@Autowired
	RestaurantDao rd;
	
	@Override
	public void addPosting(Posting posting) {
		pd.addPosting(posting);
	}

	@Override
	public void updatePosting(Posting posting) {
		pd.updatePosting(posting);
	}

	@Override
	public void deletePosting(Posting posting) {
		pd.deletePosting(posting);
	}
	
	@Override
	public int getPostingCountByCategory(char category) {
		return pd.getPostingCountByCategory(category);
	}
	
	@Override
	public List<Posting> findPostingsPerPageByCategory(Criteria criteria) {
		
		/*
		 * (공통)
		 * 페이지별로 12개씩 들고온다
		 * 1page / 0-11
		 * 2page / 12-23
		 * 3page / 24-35
		 * 4page / 36-47
		 * 5page / 48-59
		 */
		int pageStart = (criteria.getPage()-1)*criteria.getCntPerPage();		//0, 12, 24, 36, 48...
		int pageReadCnt = criteria.getCntPerPage();
		log.info("pageStart : "+pageStart);
		
		List<Posting> postings = pd.findPostingsPerPageByCategory(criteria.getType(),pageStart,pageReadCnt);
		log.info("postingCount(default:12) : "+postings.size());
		
		
		//코멘트 갯수 & 레스토랑정보 가져오기
		postings = setCommentCntAndRestaurantForPosting(postings);
		//멤버정보 가져오기
		postings = setMemberForPosting(postings);

		
		return postings;
	}
	
	/**
	 * (공통)
	 * 게시글별 사용자 정보 불러오기
	 * 		- MemberService를 이용한다
	 * 		- id로 멤버를 찾는다
	 * 	    - 필요한 정보
	 * 			-memberType(멤버타입/관리자인지아닌지) 
	 * 			- nickName(닉네임)
	 * 			- mannerTemperature(매너온도) 
	 * 			- profileImgPath(프로필사진경로)
	 * 
	 * @param postings
	 * @return
	 * @author 윤효심
	 */
	private List<Posting> setMemberForPosting(List<Posting> postings){
		for(Posting post : postings) {
			Member member = ms.findMemberById(post.getMember().getId());
			
			//멤버는 필요한 정보들만 들고간다.
			Member getM = new Member();
			getM.setId(member.getId());
			getM.setMemberType(member.getMemberType());
			getM.setNickName(member.getNickName());
			getM.setMannerTemperature(member.getMannerTemperature());
			getM.setProfileImgPath(member.getProfileImgPath());
			
			//멤버셋팅
			post.setMember(getM);
			
		}
		return postings;
	}
	
	/**
	 * (식당추천, 밥친구 게시판)
	 * 게시글별 댓글 갯수 불러오기
	 * 		- CommentService를 이용한다
	 * 		- 공지사항 게시판은 제외한다
	 * 
	 * 게시글별 레스토랑 정보 불러오기
	 * 		- RestaurantDao를 이용한다
	 * 		- id로 레스토랑 정보를 찾는다.
	 * 		- 필요한 정보
	 * 			- rType(레스토랑타입)
	 * 			- lat,lng (위치정보)
	 * 			- address (주소) 
	 * @param postings
	 * @return
	 */
	private List<Posting> setCommentCntAndRestaurantForPosting(List<Posting> postings) {
		
		if(!(postings.get(0).getCategory()=='N')) {
			for(Posting post : postings) {
				//댓글 갯수
				post.setCommentsNumber(cs.countCommentByPostId(post.getId(),post.getCategory()));
				//레스토랑정보
				post.setRestaurant(rd.findRestaurantById(post.getRestaurant().getId()));
			}
		}
		return postings;
	}
	



	

}
