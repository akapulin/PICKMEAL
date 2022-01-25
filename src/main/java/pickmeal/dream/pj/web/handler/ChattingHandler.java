package pickmeal.dream.pj.web.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

@Log
public class ChattingHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	/**
	 * - 채팅을 위해 해당 페이지에 들어오면(/chat) 클라이언트가 연결된 후 해당 클라이언트의 세션을 sessionList에 add한다.
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		log.info("#ChattingHandler, afterConnectionEstablished");
		sessionList.add(session);
		
//		session.getRemoteAddress() + 
		log.info(session.getId() + "님이 입장하셨습니다.");
		/*
		 * session.getRemoteAddress() 가 클라이언트 고유 주소를 준다고 가정
		 * blackAddress 테이블을 만들어서 신고가되거나 개발자가 직접 걸러낸 주소를 저장하고 불러온다 가정
		 * session.getRemoteAddress() 로 불러온 주소가 blackAddress 안에 있다면
		 * session.sendMessage(new TextMessage("blackAddress")) 로 메세지를 날린다
		 * 스크립트 onMessage 에서 blackAddress와 완전히일치하는 문장이 들어왔을 경우 바로 onclose를 실행시킬 수 있을까?
		 * 
		 * 시간없어서 못해봄 ㅋㅋ
		 */
	}
	
	/**
	 * - 웹 소켓 서버로 메세지를 전송했을 때 이 메서드가 호출된다. 현재 웹 소켓 서버에 접속한 Session모두에게 메세지를 전달해야 하므로 loop를 돌며 메세지를 전송한다.
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage messageline) throws Exception {
		
		log.info("#ChattingHandler, handleMessage");
		log.info(session.getId() + ": " + messageline);
		
		String line = messageline.getPayload();
		
		String name = line.substring(0, line.indexOf(":"));
		String message = line.substring(line.indexOf(":")+1);
		
		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(name + ":" + message));
		}
	}
	
	/**
	 * - 클라이언트와 연결이 끊어진 경우(채팅방을 나간 경우) remove로 해당 세션을 제거한다.
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		log.info("#ChattingHandler, afterConnectionClosed");

		sessionList.remove(session);
		
		log.info(session.getId() + "님이 퇴장하셨습니다.");
	}
}
