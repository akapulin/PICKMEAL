package pickmeal.dream.pj.posting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.java.Log;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.member.service.MemberAchievementService;
import pickmeal.dream.pj.member.service.MemberService;
import pickmeal.dream.pj.posting.domain.Comment;
import pickmeal.dream.pj.posting.domain.Posting;
import pickmeal.dream.pj.posting.repository.CommentDao;
import static pickmeal.dream.pj.web.constant.Constants.*;
import static pickmeal.dream.pj.web.constant.SavingPointConstants.*;

@Service("commentService")
@Log
public class CommentServiceImpl implements CommentService {
   
   @Autowired
   private CommentDao cd;
   
   @Autowired
   private MemberService ms;
   
   @Autowired
   private MemberAchievementService mas;

   
   @Override
   @Transactional
   public Comment addComment(Comment comment) {
     
      
      
      // member 도 식력 포인트를 적립해야한다.
      // 테이블에 동시에 업데이트
      // 여기서 member 는 참조형 데이터 타입이기 때문에 session 내 "member" 의 주소값을 가지고 있다.
      // 위의 이유로 여기서만 셋팅을 해주면 session 내 "member" 에 업데이트 해주지 않아도 알아서 업데이트된다.
      Member member = comment.getMember();
      member = mas.addFoodPowerPointItem(member, WRITE_COMMENT);
      log.info("코멘트 서비스에서 이미지패스 확인중~~~~~~~ 디비에 넣기 바로직전"+comment.getMember().getProfileImgPath());
      // 추가 후!!!! 디비커넥션 오류로 인한 순서 바꾸기
      cd.addComment(comment);
      
      // 아이디랑 등록 날짜까지 한 것을 가져와야한다.
      log.info("와아아아아아아아ㅏ아아아아★★★★★★★★★★★★"+comment.toString());
      comment = cd.findLastAddComment(comment.getMember().getId(), comment.getPosting().getCategory());
      log.info("흐에일ㅔ에엥이이이이잉잉 코멘트 추가하고 서비에서 마지막코멘트 정보 받아옴~~");
      
      
      // 멤버 셋팅 (필요한 값만 셋팅한다)
      comment.setMember(doSettingMemberForComment(ms.findMemberById(comment.getMember().getId())));
      // 포스팅 셋팅을 할 필요는 없다. (타입을 셋팅해야합니당.) ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
      

      
      return comment;
   }

   @Override
   @Transactional
   public Comment updateComment(Comment comment) {
      Comment beforeComment = findCommentById(comment);
      // 수정할 댓글 내용이 이 전과 같으면 업데이트 불가
      if (beforeComment.getContent().equals(comment.getContent())) {
         return comment;
      }
      // 업데이트 후
      cd.updateComment(comment);
      // member를 셋팅해서 들고간다.
      Member member = ms.findMemberById(comment.getMember().getId());
      comment.setMember(doSettingMemberForComment(member));
      return comment;
   }

   @Override
   @Transactional
   public boolean deleteComment(Comment comment) {
      // 댓글을 삭제 후
      cd.deleteComment(comment);
      // 제대로 삭제되었는지 확인
      if (cd.isCommentById(comment)) { // 해당 댓글이 존재하면 거짓
         return false;
      }
      return true;
   }

   @Override
   public Comment findCommentById(Comment comment) {
      return cd.findCommentById(comment);
   }

   @Override
   @Transactional
   public List<Comment> findAllCommentByMemberId(long memberId, char category) {
      // 우선 모든 댓글을 불러온다.
      List<Comment> comments = cd.findAllCommentByMemberId(memberId, category);
      // 각 댓글에 대한 member 셋팅
      // memberId, foodpowerpoint에 따른 프로필이미지이다, mannertemperature, nickname 필요      
      // 각 댓글에 대한 posting 셋팅
      // postId 필요 - 얘는 이미 있다.
      Member member = ms.findMemberById(memberId);
      Member enterMember = doSettingMemberForComment(member);      
      // 모든 댓글에 멤버를 셋팅
      for (Comment c : comments) {
         c.setMember(enterMember);
      }
      return comments;
   }

   @Override
   @Transactional
   public List<Comment> findCommentsByPostId(long postId, char category, int pageNum) {
      int start = 0;
      if (pageNum > 1) { // 2페이지 이상일 경우 곱한 후 -1 부터 조회
         start = (int)COMMENT_LIST.getPoint() * (pageNum - 1);
      }
      int end = (int)COMMENT_LIST.getPoint(); // 15개씩 조회
      log.info("start : " + start);
      log.info("end : " + end);
      List<Comment> comments = cd.findCommentsByPostId(postId, category, start, end);
      for (Comment c : comments) {
//         log.info("find all comment by postid" + c.toString());
         c.setMember(doSettingMemberForComment(ms.findMemberById(c.getMember().getId())));
      }
      return comments;
   }

   @Override
   public int countCommentByPostId(long postId, char category) {
      if (!cd.isCommentByPostId(postId, category)) {
         return 0;
      }
      return cd.countCommentByPostId(postId, category);
   }
   
   /**
    * 댓글에 필요한 멤버를 셋팅하기 위한 메소드
    * 댓글에서만 사용된다
    * 완전한 멤버 객체를 인자로 넣어줘야한다.
    * @param member
    * @return
    */
   private Member doSettingMemberForComment(Member member) {
      member = mas.doSettingMemberInfo(member);
      Member enterMember = new Member();
      // 필요한 정보만 셋팅한다.
      enterMember.setId(member.getId()); // id 필수!
      //220126효심추가멤버타입
      enterMember.setMemberType(member.getMemberType());
      enterMember.setEmail(member.getEmail());
      enterMember.setFoodPowerPoint(member.getFoodPowerPoint()); // 식력 포인트를 받아서
      enterMember.makeProfileImgPath(); // 프로필 이미지를 셋팅해준다.
      enterMember.setMannerTemperature(member.getMannerTemperature()); // 신뢰 온도 셋팅
      enterMember.setNickName(member.getNickName()); // 닉네임 셋팅
      
      return enterMember;
   }
}