package pickmeal.dream.pj.member.service;

import java.util.List;

import pickmeal.dream.pj.member.domain.Member;

public interface MemberService {
	/**
	 * create
	 * @param member
	 */
	public Member addMember(Member member);
	
	/**
	 * member 의 가입 email 를 사용해 찾기
	 * @param memberId
	 */
	public Member findMemberByMemberEmail(String email);
	
	/**
	 * member 를 id 로 찾기
	 * @param id
	 * @return
	 */
	public Member findMemberById(long id);
	
	/**
	 * 모든 멤버 가져오기
	 * @return
	 */
	public List<Member> findAllMembers();
	
	/**
	 * 이미 존재하는 id 인지 확인
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
	public Member updateMember(Member member);
	
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
	 * 사용자 로그인
	 * @param member
	 * @return
	 */
	public Member signInMember(Member member);
	
	/**
	 * 비밀번호 변경
	 * @param member
	 */
	public void updatePasswd(Member member);
}
