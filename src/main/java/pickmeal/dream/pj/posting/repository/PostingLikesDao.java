package pickmeal.dream.pj.posting.repository;

import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.posting.domain.Posting;
/**
 * 
 * @author 윤효심
 *
 */
public interface PostingLikesDao {

	public int getPostingLikes(Posting posting);
	
	public void addPostingLikes(Posting posting, Member member);
	
	public void deletePostingLikes(Posting posting, Member member);
	
	public boolean isPostingLikes(Posting posting, Member member);
}
