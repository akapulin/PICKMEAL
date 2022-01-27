package pickmeal.dream.pj.posting.service;

import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.posting.domain.Posting;
/**
 * 
 * @author 윤효심
 *
 */
public interface PostingLikesService {
	
	/*1개의 게시물에 총 좋아요수 모아오기*/
	public int getPostingLikes(Posting posting);
	
	/*1개의 게시물에 좋아요 하기 */
	public boolean addPostingLikes(Posting posting, Member member);
	
	/*1개의 게시물 좋아요 취소하기 */
	public boolean deletePostingLikes(Posting posting, Member member);
	
	/*1개의 게시물의 좋아요 상태인지 알려주기*/
	public boolean isPostingLikes(Posting posting, Member member);
}
