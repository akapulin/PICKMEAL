package pickmeal.dream.pj.member.repository;

import java.util.List;

import pickmeal.dream.pj.member.domain.Member;

public interface MemberDao {
	/**
	 * create
	 * @param member
	 */
	public void addMember(Member member);
	
	/**
	 * id 로 member 찾기
	 * @param id
	 * @return
	 */
	public Member findMemberById(long id);
	
	/**
	 * member 의 가입 email 를 사용해 찾기
	 * @param email
	 */
	public Member findMemberByMemberEmail(String email);
	
	/**
	 * 모든 멤버 가져오기
	 * @return
	 */
	public List<Member> findAllMembers();
	
	/**
	 * 이미 존재하는 이메일 인지 확인
	 * @param email
	 * @return
	 */
	public boolean isMemberByEmail(String email);
	
	/**
	 * 이미 존재하는 닉네임인지 확인
	 * @param nickName
	 * @return
	 */
	public boolean isMemberByNickName(String nickName);
	
	/**
	 * 멤버 정보 수정
	 * @param member
	 * @return
	 */
	public void updateMember(Member member);
	
	/**
	 * 멤버 삭제
	 * @param member
	 * @return
	 */
	public void deleteMember(Member member);
	
	/**
	 * 마지막으로 추가된 member 가져오기
	 * @return
	 */
	public Member findLastAddMember();
	
	/**
	 * 비밀번호 변경하기
	 * @param member
	 */
	public void updatePasswd(Member member);
	
	
}
