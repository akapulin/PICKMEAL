package pickmeal.dream.pj.posting.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.repository.PostingLikesDao;

@Service("PostingLikesService")
public class PostingLikesServiceImpl implements PostingLikesService{

	@Autowired
	PostingLikesDao pld;
	
	@Autowired
	PostingService ps;
	
	@Override
	public int getPostingLikes(Posting posting) {
		return pld.getPostingLikes(posting);
	}

	/**
	 * 
	 * 나중에 설계하다보니 Posting의 Likes값도 수정해야하는 불편한 점이 생겼다.
	 * 
	 */
	@Override
	@Transactional
	public boolean addPostingLikes(Posting posting, Member member) {
		
		try {
			//PostingLike 테이블에 좋아요 레코드 추가하기
			pld.addPostingLikes(posting, member);
			
			//Posting 테이블에 좋아요 수 늘려주기
			ps.updatePostingLikes(posting, true);
			
			
			return true;
		}catch(Exception e) {
			return false;
		}
		
		

	}

	@Override
	@Transactional
	public boolean deletePostingLikes(Posting posting, Member member) {
		
		try {
			//PostingLike 테이블에 좋아요 레코드 삭제하기
			pld.deletePostingLikes(posting, member);
			
			//Posting 테이블에 좋아요 수 깍아주기
			ps.updatePostingLikes(posting, false);
			
			
			return true;
		}catch(Exception e) {
			return false;
		}
	}
	
	public boolean isPostingLikes(Posting posting, Member member) {
		return pld.isPostingLikes(posting,member);
	}

}
