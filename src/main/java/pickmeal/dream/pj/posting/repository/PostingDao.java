package pickmeal.dream.pj.posting.repository;

import java.util.List;

import pickmeal.dream.pj.posting.domain.Posting;

/**
 * 
 * @author 윤효심
 *
 */
public interface PostingDao {

	/**
	 * 포스팅 추가
	 * @param posting
	 */
	public void addPosting(Posting posting);
	
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
	 * 카테고리별 게시물 갯수 불러오기
	 * @param category
	 * @return
	 */
	public int getPostingCountByCategory(char category);
	
	/**
	 * 카테고리별 포스팅 불러오기
	 * 		- 게시판 목록에서만 불러올 것
	 * 		- 1페이지당 12개 게시물 불러오기
	 * @param category
	 * @return
	 */
	public List<Posting> findPostingsPerPageByCategory(char category, int pageStart, int pageEnd);
	
	/**
	 * 포스팅 정보 1개 불러오기
	 * 		- 게시판 목록에서 1개 누르면, 게시판 읽기로 들어가기 위해 필요한 게시물 정보* 
	 * @param id
	 * @return
	 */
	public Posting findPostingById(char category, long id);
	
	
	
	public int getPostingCountByCategoryAndMemberId(long memberId, char category);
	/**
	 * 카테고리별 해당 유저의 게시글 불러오기
	 * 
	 */
	public List<Posting> findPostingsPerPageByMemberId(long memberId, char category, int pageStart, int pageReadCnt);


	/**
	 * 마지막으로 삽입한 포스팅 1개 가져오기
	 * @param category
	 * @return
	 */
	public Posting findLastPostingByCategory(char category);

	/**
	 * 조회수 업데이트
	 * @param category
	 * @param postId
	 */
	public int updatePostingViews(char category, long postId);

	/**
	 * 좋아요 업데이트
	 * @param category
	 * @param postId
	 */
	public int updatePostingLikes(char category, long postId);
	
	/**
	 * 밥친구 게시판 모집중 상태 변경
	 * @param postId
	 */
	public void convertRecruitmentState(long postId);
	
	/**
	 * 밥친구 게시판 모집상태 불러오기
	 * @param postId
	 * @return
	 */
	public boolean getRecruitmentState(long postId);

	
	/**
	 * 게시글 제목만 불러오기
	 * 내 댓글 - 게시글제목에 사용
	 * @param category
	 * @param id
	 * @return
	 */
	public String findPostingTitleById(char category, long id);
}
