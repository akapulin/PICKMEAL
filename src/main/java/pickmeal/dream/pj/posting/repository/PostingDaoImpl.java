package pickmeal.dream.pj.posting.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.domain.TogetherEatingPosting;
import pickmeal.dream.pj.posting.util.Criteria;

@Repository("postingDao")
public class PostingDaoImpl implements PostingDao {

	@Autowired
	JdbcTemplate jt;

	@Override
	public void addPosting(Posting posting) {
		if (posting.getCategory() == 'N') {
			String sql ="INSERT INTO NoticePosting(memberId, title, content, views) "
			+" VALUES(?,?,?,?)";
			jt.update(sql, posting.getMember().getId(), posting.getTitle(), posting.getContent(), posting.getViews());
			
		} else if (posting.getCategory() == 'R') {
			String sql ="INSERT INTO RecommendRestaurantPosting(memberId, address, title, content, likes, views) "
					+" VALUES(?,?,?,?,?,?)";
			jt.update(sql, posting.getMember().getId(), posting.getAddress(), posting.getTitle(), posting.getContent(), posting.getLikes(), posting.getViews());
					
		} else {
			TogetherEatingPosting tep = (TogetherEatingPosting)posting;
			String sql ="INSERT INTO TogetherEatingPosting(memberId, address, title, content, likes, views, mealTime, recruitment, mealChk ) "
					+" VALUES(?,?,?,?,?,?,?,?,?)";
			jt.update(sql, tep.getMember().getId(), tep.getAddress(), tep.getTitle(), tep.getContent(), tep.getLikes(), tep.getViews(), tep.getMealTime(), tep.isRecruitment(), tep.isMealChk());
			
		}

	}

	
	
	@Override
	public int updatePosting(Posting posting) {
		if (posting.getCategory() == 'N') {
			String sql ="UPDATE NoticePosting SET title=?, content=?, views=?"
					+" WHERE id=?";
			return jt.update(sql, posting.getTitle(), posting.getContent(), posting.getViews(), posting.getId());
		} else if (posting.getCategory() == 'R') {
			String sql ="UPDATE RecommendRestaurantPosting SET address=?, title=?, content=?, likes=?, views=?"
					+" WHERE id=?";
			return jt.update(sql, posting.getAddress(), posting.getTitle(), posting.getContent(), posting.getLikes(), posting.getViews(), posting.getId());
		} else {
			TogetherEatingPosting tep = (TogetherEatingPosting) posting;
			String sql ="UPDATE TogetherEatingPosting SET address=?, title=?, content=?, likes=?, views=?, mealTime=?, recruitment=?, mealChk=?"
					+" WHERE id=?";
			return jt.update(sql, tep.getAddress(), tep.getTitle(), tep.getContent(), tep.getLikes(), tep.getViews(), tep.getMealTime(), tep.isRecruitment(), tep.isMealChk(), tep.getId());
		}

	}

	@Override
	public int deletePosting(Posting posting) {
		if (posting.getCategory() == 'N') {
			String sql = "DELETE FROM NoticePosting WHERE id=?";
			return jt.update(sql, posting.getId());
		} else if (posting.getCategory() == 'R') {
			String sql = "DELETE FROM RecommendRestaurantPosting WHERE id=?";
			return jt.update(sql, posting.getId());
		} else {
			TogetherEatingPosting tep = (TogetherEatingPosting) posting;
			String sql = "DELETE FROM TogetherEatingPosting WHERE id=?";
			return jt.update(sql, posting.getId());
		}

	}
	
	
	@Override
	public int getPostingCountByCategory(Criteria criteria) {
		if (criteria.getType() == 'N') {
			String sql = "SELECT COUNT(np.id) as NoticeCnt" 
						+ getFromSQL(criteria)
						+ getSearchSQL(criteria);
			return jt.queryForObject(sql, Integer.class);
		} else if (criteria.getType() == 'R') {
			String sql = "SELECT COUNT(rrp.id) as RecommendRestaurantCnt" 
						+ getFromSQL(criteria)
						+ getSearchSQL(criteria);
			return jt.queryForObject(sql, Integer.class);
		} else {
			String sql = "SELECT COUNT(tep.id) as TogetherEatingCnt "
						+ getFromSQL(criteria)
						+ getSearchSQL(criteria);
			return jt.queryForObject(sql, Integer.class);
		}
		
	}
	

	
	/**
	 * 
	 * 	각 게시판의 게시물을 id별로 내림차순으로 정렬 후, 
	 * 	LIMIT를 사용해 pageStart 부터 pageReadCnt만큼 불러온다
	 *  (ex. pageStart = 시작 행(0부터시작), pageReadCnt = 불러올 갯수 ) 
	 * 
	 */
	@Override
	public List<Posting> findPostingsPerPageByCategory(Criteria criteria, int pageStart, int pageReadCnt) {
		if (criteria.getType() == 'N') {
			String sql ="SELECT np.id, np.memberId, np.title, np.content, np.views, np.regDate "
					+ getFromSQL(criteria)
					+ getSearchSQL(criteria)
					+ getOrderSQL(criteria)
					+" LIMIT ?,?";
			return jt.query(sql, new NoticePostingRowMapper(),pageStart,pageReadCnt);
			
		} else if (criteria.getType() == 'R') {
			String sql ="SELECT rrp.id, rrp.memberId, rrp.address, rrp.title, rrp.content, rrp.likes, rrp.views, rrp.regDate "
					+ getFromSQL(criteria)
					+ getSearchSQL(criteria)
					+ getOrderSQL(criteria)
					+" LIMIT ?,?";
			return jt.query(sql, new RecommendRestaurantPostingRowMapper(),pageStart,pageReadCnt);
		} else {
			String sql ="SELECT tep.id, tep.memberId, tep.address, tep.title, tep.content, tep.likes, tep.views, tep.mealTime, tep.recruitment, tep.mealChk, tep.regDate "
					+ getFromSQL(criteria)
					+ getSearchSQL(criteria)
					+ getOrderSQL(criteria)
					+" LIMIT ?,?";
			return jt.query(sql, new TogetherEatingPostingRowMapper(),pageStart,pageReadCnt);
		}

	}
	
	private String getFromSQL(Criteria criteria) {
		String sql="";
		if(criteria.getType() == 'N') {
			sql =" FROM NoticePosting np";
			if(criteria.getSearch().length()!=0 && criteria.getSearchType().equals("writer")) {
				sql += " INNER JOIN Member member ON np.memberId = member.id";
			}
		}
		else if(criteria.getType() == 'R') {
			sql =" FROM RecommendRestaurantPosting rrp";
			if(criteria.getSearch().length()!=0 && criteria.getSearchType().equals("writer")) {
				sql += " INNER JOIN Member member ON rrp.memberId = member.id";
			}
		}
		else {
			sql =" FROM TogetherEatingPosting tep";
			if(criteria.getSearch().length()!=0 && criteria.getSearchType().equals("writer")) {
				sql += " INNER JOIN Member member ON tep.memberId = member.id";
			}
		}

		return sql;
	}
	
	/**
	 * 검색어 찾기
	 * @param searchType
	 * @param search
	 * @return
	 */
	private String getSearchSQL(Criteria criteria) {
		String sql="";
		StringBuffer searchBuf = new StringBuffer();
		if(criteria.getSearchType().equals("writer")) {
			searchBuf.append(" WHERE member.nickName='"+criteria.getSearch()+"'");
		}
		else if(criteria.getSearchType().equals("title")){
			searchBuf.append(" WHERE title LIKE '%"+criteria.getSearch()+"%'");
		}

		sql = searchBuf.toString();
		return sql;
	}
	
	/**
	 * 
	 * 정렬 SQL문 찾기 
	 * @param sortType
	 * @param sort
	 * @return
	 */
	private String getOrderSQL(Criteria criteria) {
		String sql ="";
		StringBuffer orderBuf = new StringBuffer();
		//최신순
		if(criteria.getSortType().equals("regDate")) {
			orderBuf.append(" ORDER BY id");
		}
		//조회순
		else if(criteria.getSortType().equals("views")) {
			orderBuf.append(" ORDER BY views");
		}
		//좋아요순
		else if(criteria.getSortType().equals("likes")) {
			orderBuf.append(" ORDER BY likes");
		}
		//모집중
		else if(criteria.getSortType().equals("recruitment")) {
			orderBuf.append(" ORDER BY recruitment");
		}
		
		if(criteria.getSort().equals("desc")) {
			orderBuf.append(" DESC");
		}
		else if(criteria.getSort().equals("asc")){
			orderBuf.append(" ASC");
		}
		sql = orderBuf.toString();
		return sql;
	}
	
	@Override
	public Posting findPostingById(char category, long id) {
		if (category == 'N') {
			String sql ="SELECT id, memberId, title, content, views, regDate "
					+" FROM NoticePosting"
					+" WHERE id=? ";
			return jt.queryForObject(sql, new NoticePostingRowMapper(),id);
			
		} else if (category == 'R') {
			String sql ="SELECT id, memberId, address, title, content, likes, views, regDate "
					+" FROM RecommendRestaurantPosting"
					+" WHERE id=? ";
			return jt.queryForObject(sql, new RecommendRestaurantPostingRowMapper(),id);
		} else {
			String sql ="SELECT id, memberId, address, title, content, likes, views, mealTime, recruitment, mealChk, regDate "
					+" FROM TogetherEatingPosting"
					+" WHERE id=? ";
			return jt.queryForObject(sql, new TogetherEatingPostingRowMapper(),id);
		}
	}
	
	@Override
	public String findPostingTitleById(char category, long id) {
		if (category == 'N') {
			String sql ="SELECT title"
					+" FROM NoticePosting"
					+" WHERE id=? ";
			return jt.queryForObject(sql, String.class,id);
			
		} else if (category == 'R') {
			String sql ="SELECT title"
					+" FROM RecommendRestaurantPosting"
					+" WHERE id=? ";
			return jt.queryForObject(sql, String.class,id);
		} else {
			String sql ="SELECT title"
					+" FROM TogetherEatingPosting"
					+" WHERE id=? ";
			return jt.queryForObject(sql, String.class,id);
		}
	}

	@Override
	public int getPostingCountByCategoryAndMemberId(long memberId, char category) {
		if (category == 'N') {
			String sql = "SELECT COUNT(id) as NoticeCnt FROM NoticePosting WHERE memberId = ?";
			return jt.queryForObject(sql, Integer.class,memberId);
		} else if (category == 'R') {
			String sql = "SELECT COUNT(id) as RecommendRestaurantCnt FROM RecommendRestaurantPosting WHERE memberId = ?";
			return jt.queryForObject(sql, Integer.class,memberId);
		} else {
			String sql = "SELECT COUNT(id) as TogetherEatingCnt FROM TogetherEatingPosting WHERE memberId = ?";
			return jt.queryForObject(sql, Integer.class,memberId);
		}
		
	}

	@Override
	public List<Posting> findPostingsPerPageByMemberId(long memberId, char category, int pageStart, int pageReadCnt) {
		if (category == 'R') {
			String sql ="SELECT id, memberId, address, title, content, likes, views, regDate "
					+" FROM RecommendRestaurantPosting"
					+" WHERE memberId = ?"
					+" ORDER BY id DESC "
					+" LIMIT ?,?";
			return jt.query(sql, new RecommendRestaurantPostingRowMapper(),memberId,pageStart,pageReadCnt);
		} else if (category == 'E') {
			String sql ="SELECT id, memberId, address, title, content, likes, views, mealTime, recruitment, mealChk, regDate "
					+" FROM TogetherEatingPosting"
					+" WHERE memberId = ?"
					+" ORDER BY id DESC "
					+" LIMIT ?,? ";
			return jt.query(sql, new TogetherEatingPostingRowMapper(),memberId,pageStart,pageReadCnt);
		} else {
			String sql ="SELECT id, memberId, title, content, views, regDate "
					+" FROM NoticePosting"
					+" WHERE memberId = ?"
					+" ORDER BY id DESC "
					+" LIMIT ?,?";
			return jt.query(sql, new NoticePostingRowMapper(),memberId,pageStart,pageReadCnt);
			
		}
	}

	/**
	 * 게시판 카테고리 별로 마지막으로 추가한 포스팅을 가져온다
	 * @return
	 */
	public Posting findLastPostingByCategory(char category) {
		if (category == 'N') {
			String sql ="SELECT id, memberId, title, content, views, regDate "
					+" FROM NoticePosting WHERE id=LAST_INSERT_ID()";
			return jt.queryForObject(sql, new NoticePostingRowMapper());
			
		} else if (category == 'R') {
			String sql ="SELECT id, memberId, address, title, content, likes, views, regDate "
					+" FROM RecommendRestaurantPosting WHERE id=LAST_INSERT_ID()";
			return jt.queryForObject(sql, new RecommendRestaurantPostingRowMapper());
		} else {
			String sql ="SELECT id, memberId, address, title, content, likes, views, mealTime, recruitment, mealChk, regDate "
					+" FROM TogetherEatingPosting WHERE id=LAST_INSERT_ID()";
			return jt.queryForObject(sql, new TogetherEatingPostingRowMapper());
		}
	}
	
	@Override
	public int updatePostingViews(char category, long postId) {
		if (category == 'N') {
			String sql ="UPDATE NoticePosting SET views = views+1"
					+" WHERE id=?";
			return jt.update(sql, postId);
			
		} else if (category == 'R') {
			String sql ="UPDATE RecommendRestaurantPosting SET views = views+1"
					+" WHERE id=?";
			return jt.update(sql, postId);		
		} else {
			String sql ="UPDATE TogetherEatingPosting SET views = views+1"
					+" WHERE id=?";
			return jt.update(sql, postId);		
		}
	}
	
	@Override
	public int updatePostingLikes(Posting posting, boolean likesState) {
		if (posting.getCategory() == 'N') {
			String sql ="UPDATE NoticePosting SET "+queryForLikesByState(likesState)+" WHERE id=?";
			return jt.update(sql, posting.getId());
		}
		else if (posting.getCategory() == 'R') {
			String sql ="UPDATE RecommendRestaurantPosting SET "+queryForLikesByState(likesState)+" WHERE id=?";
			return jt.update(sql, posting.getId());
		} else {
			String sql ="UPDATE TogetherEatingPosting SET "+queryForLikesByState(likesState)+" WHERE id=?";
			return jt.update(sql, posting.getId());
		}
	}
	
	@Override
	public void convertRecruitmentState(long postId) {
		String sql = "UPDATE TogetherEatingPosting SET recruitment = !recruitment"
				+" WHERE id=?";
		jt.update(sql, postId);
	}
	
	@Override
	public boolean getRecruitmentState(long postId) {
		String sql = "SELECT recruitment FROM TogetherEatingPosting"
				+" WHERE id=?";
		return jt.queryForObject(sql, Boolean.class, postId);
	}

	/*
	@Override
	public List<Posting> findPostingsPerPageByCategoryAndBySorting(Criteria criteria, int pageStart, int pageReadCnt, int switchNum) {
		if (criteria.getType() == 'N') {
			String sql ="SELECT id, memberId, title, content, views, regDate "
					+" FROM NoticePosting"
					+" ORDER BY "+ criteria.getSortType() + " " + criteria.getSort()
					+" LIMIT ?,?";
			return jt.query(sql, new NoticePostingRowMapper(), pageStart, pageReadCnt);
			
		} else if (criteria.getType() == 'R') {
				String sql ="SELECT id, memberId, address, title, content, likes, views, regDate "
						+" FROM RecommendRestaurantPosting"
						+" ORDER BY "+ criteria.getSortType() + " " + criteria.getSort()
						+" LIMIT ?,?";
				System.out.println("here is PostingDaoImpl : SortType is : " + criteria.getSortType() + " / Sort is : " + criteria.getSort());
				return jt.query(sql, new RecommendRestaurantPostingRowMapper(), pageStart, pageReadCnt);
		} else {
			String sql ="SELECT id, memberId, address, title, content, likes, views, mealTime, recruitment, mealChk, regDate "
					+" FROM TogetherEatingPosting"
					+" ORDER BY "+ criteria.getSortType() + " " + criteria.getSort()
					+" LIMIT ?,?";
			return jt.query(sql, new TogetherEatingPostingRowMapper(), pageStart, pageReadCnt);
		}
	}
	*/
	
	public String queryForLikesByState(boolean state) {
		if(state) {
			return "likes = likes +1";
		}else {
			return "likes = likes -1";
		}
	}
	
}
