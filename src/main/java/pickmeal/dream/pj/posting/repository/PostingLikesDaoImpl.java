package pickmeal.dream.pj.posting.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.posting.domain.Posting;

@Repository("PostingLikesDao")
public class PostingLikesDaoImpl implements PostingLikesDao {

	@Autowired
	JdbcTemplate jt;
	
	@Override
	public int getPostingLikes(Posting posting) {
		try {
			if (posting.getCategory() == 'R') {
				String sql = "SELECT COUNT(id) as LikesCnt FROM RecommendRestaurantPostingLikes"
							+" WHERE postingId=?";
				return jt.queryForObject(sql, Integer.class,posting.getId());
			} else {
				String sql = "SELECT COUNT(id) as LikesCnt FROM TogetherEatingPostingLikes"
						+" WHERE postingId=?";
				return jt.queryForObject(sql, Integer.class,posting.getId());
			}
		}catch(Exception e) {
			return 0;
		}

	}

	@Override
	public void addPostingLikes(Posting posting, Member member) {
		if(posting.getCategory() == 'R'){
			String sql = "INSERT INTO RecommendRestaurantPostingLikes(postingId, memberId)"
					+" VALUES(?,?)";
			jt.update(sql,posting.getId(),member.getId());
		}else {
			String sql = "INSERT INTO TogetherEatingPostingLikes(postingId, memberId)"
					+" VALUES(?,?)";
			jt.update(sql,posting.getId(),member.getId());
		}
		
	}

	@Override
	public void deletePostingLikes(Posting posting, Member member) {
		if(posting.getCategory() == 'R'){
			String sql = "DELETE FROM RecommendRestaurantPostingLikes WHERE postingId=? AND memberId=?";
			jt.update(sql,posting.getId(),member.getId());
		}else {
			String sql = "DELETE FROM TogetherEatingPostingLikes WHERE postingId=? AND memberId=?";
			jt.update(sql,posting.getId(),member.getId());
		}
		
	}
	
	@Override
	public boolean isPostingLikes(Posting posting, Member member) {

		try {
			if(posting.getCategory() == 'R'){
				String sql = "SELECT EXISTS(SELECT id FROM RecommendRestaurantPostingLikes WHERE postingId=? AND memberId=?) as likeState";
				return jt.queryForObject(sql,Boolean.class,posting.getId(),member.getId());
			}else {
				String sql = "SELECT EXISTS(SELECT id FROM TogetherEatingPostingLikes WHERE postingId=? AND memberId=?) as likeState";
				return jt.queryForObject(sql,Boolean.class,posting.getId(),member.getId());
			}
		}catch(Exception e) {
			//에러나면 기본값 좋아요상태아님
			return false;
		}
	}

}
