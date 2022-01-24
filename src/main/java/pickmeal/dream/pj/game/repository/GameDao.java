package pickmeal.dream.pj.game.repository;

import pickmeal.dream.pj.game.domain.LastGame;

public interface GameDao{
	
	// 로그인하고 게임할 때 첫 게임인지 아닌지 확인하기 위해서 DB에 방문해야함.
	
	public void insertLastGameRecord(long memberId, long resId);
	
	public int checkLastGameRecord(long memberId);

	/**
	 * 해당 사용자의 마지막 게임 찾기
	 * 식당을 찾기 위해 사용된다
	 * @param memberId
	 * @return
	 * @author qhfud
	 */
	public LastGame findLastGameByMemberId(long memberId);
}
