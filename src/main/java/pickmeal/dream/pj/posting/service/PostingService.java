package pickmeal.dream.pj.posting.service;

import java.util.List;

import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.util.Criteria;

/**
 * 
 * @author 윤효심
 *
 */
public interface PostingService {

	/**
	 * 포스팅 추가
	 * @param posting
	 */
	public Posting addPosting(Posting posting);
	
	/**
	 * 포스팅 업데이트
	 * @param posting
	 */
	public int updatePosting(Posting posting);
	
	/**
	 * 포스팅 삭제
	 * @param posting
	 * @return
	 */
	public int deletePosting(Posting posting);
	
	/**
	 * 카테고리별 포스팅 갯수 불러오기
	 * @param category
	 * @return
	 */
	public int getPostingCountByCategory(Criteria criteria);
	
	/**
	 * 카테고리별 포스팅 불러오기
	 * 		- 게시판 목록에서만 불러올 것
	 * 		- 1페이지당 12개 게시물 불러오기
	 * 		- 게시글별 댓글 갯수 불러오기
	 * @param category
	 * @return
	 */
	public List<Posting> findPostingsPerPageByCategory(Criteria criteria);
	

	/**
	 * 포스팅 정보 1개 불러오기
	 * 		- 게시판 목록에서 1개 누르면, 게시판 읽기로 들어가기 위해 필요한 게시물 정보* 
	 * @param id
	 * @return
	 */
	public Posting findPostingById(char category, long id);
	
	
	public int getPostingCountByCategoryAndMemberId(long memberId, char category);
	
	public List<Posting> findPostingsPerPageByMemberId(long memberId, Criteria criteria);
	
	/**
	 * 게시물 조회수 업데이트
	 * @param category
	 * @param postId
	 */
	public int updatePostingViews(char category, long postId);
	
	/**
	 * 게시물 좋아요 업데이트
	 * @param category
	 * @param postId
	 */
	public int updatePostingLikes(Posting posting, boolean likesState);
	
	/**
	 * 밥친구 게시판 모집중 상태 변경
	 * @param postId
	 */
	public boolean convertRecruitmentState(long postId);

	/**
	 * 게시글의 제목만 불러오기
	 * 내 댓글 - 게시글 제목에 사용
	 * @param category
	 * @param id
	 * @return
	 */
	public String findPostingTitleById(char category, long id);
	
	/**
	 * 조회순으로 불러오기
	 * @param criteria
	 * @return
	 */
	//public List<Posting> findPostingsPerPageByCategoryAndBySorting(Criteria criteria, int switchNum);
	
}
