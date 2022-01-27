package pickmeal.dream.pj.chat.service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.java.Log;
import pickmeal.dream.pj.chat.domain.Chat;
import pickmeal.dream.pj.chat.repository.ChatDao;
import pickmeal.dream.pj.member.domain.Member;
import pickmeal.dream.pj.member.service.MemberService;
import pickmeal.dream.pj.message.domain.Alarm;
import pickmeal.dream.pj.message.service.AlarmService;

@Service("chatService")
@Log
public class ChatServiceImpl implements ChatService {

	@Autowired
	ChatDao cd;
	
	@Autowired
	MemberService ms;
	
	@Autowired
	AlarmService as;
	
	@Override
	public void addChat(Chat chat) {
		// 현재 읽지 않는 경우라면 무조건 alarm 추가
		if (chat.getReadType() =='N') {
			Alarm alarm = new Alarm();
			log.info("member nick : " + chat.getMember().getNickName());
			log.info("commenter nick : " + chat.getCommenter().getNickName());
			log.info("writer nick : " + chat.getWriter().getNickName());
			if (chat.getWriter().getId() == chat.getMember().getId()) {
				// 채팅의 경우 내가 보냈는데 상대방이 못 보는 것이기 때문에 상대방 기준으로 셋팅해준다.
				alarm.setMember(chat.getCommenter());
				alarm.setFriend(chat.getWriter());
				alarm.setContent(chat.getWriter().getNickName());
			} else {
				alarm.setMember(chat.getWriter()); // 상대 : 게시글 작성자
				alarm.setFriend(chat.getCommenter()); // 나 : 댓글 작성자
				alarm.setContent(chat.getCommenter().getNickName()); // 나의 닉네임을 넣어준다.
			}
			alarm.setAlarmType('C'); // 채팅이기 대문에 C
			as.addAlarm(alarm);
			
		}
		if (!cd.isChatByWriterIdAndCommenterId(chat)) { // 처음 넣는 거라면 추가
			// 상대방이 읽지 않았다면
			// 나는 R로 넣고 상대방은 N으로 넣어야한다.
			if (chat.getReadType() == 'N') {
				chat.setReadType('R');
				cd.addChat(chat);
				chat.setReadType('N');
				
				// 상대방이 읽지 않는다면 알람 레코드에 넣어줘야한다.
				
				// 현재 사용자가 게시글 작성자인 경우
				if (chat.getWriter().getId() == chat.getMember().getId()) {
					chat.setMember(chat.getCommenter());
				} else { // 현재 사용자가 댓글 작성자인 경우
					chat.setMember(chat.getWriter());
				}
			}
			cd.addChat(chat);
		} else { // 그게 아니라면 시간을 계속 업데이트해야한다.
			updateChat(chat);
		}
	}

	@Override
	public void updateChat(Chat chat) {
		// 업데이트의 경우도 타입을 지속적으로 봐야한다.
		if (chat.getReadType() == 'N') {
			chat = findChatByWriterIdAndCommenterId(chat);
			chat.setReadType('R');
			cd.updateChat(chat);
			// 현재 사용자가 게시글 작성자인 경우
			if (chat.getWriter().getId() == chat.getMember().getId()) {
				chat.setMember(chat.getCommenter());
			} else { // 현재 사용자가 댓글 작성자인 경우
				chat.setMember(chat.getWriter());
			}
		}
		chat = findChatByWriterIdAndCommenterId(chat);
		chat.setReadType('N');
		cd.updateChat(chat);
	}

	@Override
	public void updateChatType(Chat chat) {
		cd.updateChatType(chat);
		// 해당 메소드는 원래 안읽은 채팅을 읽어서 type 을 변경해주는 것이기 때문에 alarm record 내 해당하는 값이 있다면 삭제해줘야한다.
		// 읽어서 삭제하는 경우에는 member 가 내가되어야하고 friend 가 상대방이 된다.
		Alarm alarm = new Alarm();
		alarm.setAlarmType('C');
		// 현재 사용자가 게시글 작성자인 경우
		if (chat.getWriter().getId() == chat.getMember().getId()) {
			alarm.setMember(chat.getWriter());
			alarm.setFriend(chat.getCommenter());
		} else { // 현재 사용자가 댓글 작성자인 경우
			alarm.setMember(chat.getCommenter());
			alarm.setFriend(chat.getWriter());
		}
		as.deleteAlarm(alarm);		
	}

	@Override
	public void deleteChat() {
		cd.deleteChat();
	}

	@Override
	public Chat findChatByWriterIdAndCommenterId(Chat chat) {
		if (cd.isChatByWriterIdAndCommenterId(chat)) {
			chat = cd.findChatByWriterIdAndCommenterId(chat);
			chat.setWriter(makeChatter(chat.getWriter().getId()));
			chat.setCommenter(makeChatter(chat.getCommenter().getId()));
			chat.setMember(makeChatter(chat.getMember().getId()));
		}
		return chat;
	}

	@Override
	public List<Chat> findAllChatsByMemberId(long memberId) {
		List<Chat> chats = null;
		
		// 채팅이 있다면 실행한다.
		if (cd.isChatByMemberId(memberId)) {
			chats = cd.findAllChatsByMemberId(memberId);
			// 각 wrtier 와 commenter 를 셋팅한다.
			for (Chat c : chats) {
				c.setWriter(makeChatter(c.getWriter().getId()));
				c.setCommenter(makeChatter(c.getCommenter().getId()));
				c.setMember(makeChatter(c.getMember().getId()));
			}
		}
		
		return chats;
	}

	@Override
	public List<Chat> findLimitedChatsByMemberId(long memberId, long startId, int limit) {
		List<Chat> chats = null;
		
		if (cd.isChatByMemberId(memberId)) {
			chats = cd.findLimitedChatsByMemberId(memberId, startId, limit);
			// 각 wrtier 와 commenter 를 셋팅한다.
			for (Chat c : chats) {
				c.setWriter(makeChatter(c.getWriter().getId()));
				c.setCommenter(makeChatter(c.getCommenter().getId()));
				c.setMember(makeChatter(c.getMember().getId()));
			}
		}
		
		return chats;
	}
	
	@Override
	public Member makeChatter(long memberId) {
		Member chatter = ms.findMemberById(memberId);
		Member enterChatter = new Member();
		
		enterChatter.setId(chatter.getId());
		enterChatter.setEmail(chatter.getEmail());
		enterChatter.setNickName(chatter.getNickName());
		enterChatter.setMannerTemperature(chatter.getMannerTemperature());
		enterChatter.setProfileImgPath(chatter.getProfileImgPath());
		enterChatter.setMemberType(chatter.getMemberType());
		
		return enterChatter;
	}

	/**
	 * mac, unix, linux 경로 수정 필요
	 */
	@Override
	public void uploadChatContent(List<String> fileText, Chat chat) {
		String rootPath = null;
		
		// 운영체제 별 폴더 경로 설정
		String os = System.getProperty("os.name").toLowerCase();

		if (os.contains("win")) {
			rootPath = "C:/";
		} else if (os.contains("mac")) { // 이 아래 부분 수정 좀 해주세욤
			rootPath = "/Users/";
		} else if (os.contains("uix")) {
			rootPath = "~/";
		} else if (os.contains("linux")) {
			rootPath = "~/";
		}
		String directoryPath = rootPath + "external_resources/one_on_one_chatting";
		
		// 해당 디렉토리가 없을 경우 생성
		File directory = new File(directoryPath);
		if (!directory.exists()) {
			try {
				directory.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		String filePath = directoryPath + "/" + chat.getWriter().getNickName()
				+ "_" + chat.getCommenter().getNickName() + ".txt";
		try {
			BufferedWriter bw = new BufferedWriter(new FileWriter(new File(filePath)));
			for (String s : fileText) {
				bw.write(s);
				bw.flush();
				bw.newLine();
			}
			bw.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<String> downloadChatContent(Chat chat) {
		String filePath = "C:/external_resources/one_on_one_chatting/" + chat.getWriter().getNickName()
				+ "_" + chat.getCommenter().getNickName() + ".txt";
		List<String> fileText = new ArrayList<>(); // 파일 내용 전체가 들어갈 부분
		try {
			File file = new File(filePath);
			Scanner sc = new Scanner(file);
			while(sc.hasNextLine()) {
				fileText.add(sc.nextLine());
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fileText;
	}

}
