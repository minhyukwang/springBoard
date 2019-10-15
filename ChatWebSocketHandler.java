package com.myungjin.mj010.app.activity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.myungjin.mj010.app.dao.ChatDao;
import com.myungjin.mj010.app.vo.MsgVO;

public class ChatWebSocketHandler extends TextWebSocketHandler {

	@Inject
	private ChatDao dao;
	private static Logger logger = LoggerFactory.getLogger(ChatWebSocketHandler.class);
	private List<WebSocketSession> connectedUsers;
	public ChatWebSocketHandler() {
		connectedUsers = new ArrayList<WebSocketSession>();
	}

	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		log(session.getId() + " 연결 됨!!");
		users.put(session.getId(), session);
		connectedUsers.add(session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log(session.getId() + " 연결 종료됨");
		connectedUsers.remove(session);
		users.remove(session.getId());

	}

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		MsgVO msgVo = MsgVO.convertMessage(message.getPayload());
		for (WebSocketSession websocketSession : connectedUsers) {
			// 받는사람
			Gson gson = new Gson();
			String msgJson = gson.toJson(msgVo);
			websocketSession.sendMessage(new TextMessage(msgJson));
			dao.insertMsg(msgVo);
		}

		/*
		if (!messageVO.getUSER_user_id().equals(messageVO.getTUTOR_USER_user_id())) {
			System.out.println("a");
			if (dao.isRoom(roomVO) == null) {
				System.out.println("b");
				dao.createRoom(roomVO);
				System.out.println("d");
				croom = dao.isRoom(roomVO);
			} else {
				System.out.println("C");
				croom = dao.isRoom(roomVO);
			}
		} else {
			croom = dao.isRoom(roomVO);
		}
		ChatVO roomVO = new ChatVO();

		roomVO.setCLASS_class_id(messageVO.getCLASS_class_id()); // 클래스
		roomVO.setTUTOR_USER_user_id(messageVO.getTUTOR_USER_user_id()); // 튜터
		roomVO.setUSER_user_id(messageVO.getUSER_user_id()); // 유저
		ChatVO croom = null;


		messageVO.setCHATROOM_chatroom_id(croom.getChatroom_id());
		if (croom.getUSER_user_id().equals(messageVO.getMessage_sender())) {

			messageVO.setMessage_receiver(roomVO.getTUTOR_USER_user_id());
		} else {
			messageVO.setMessage_receiver(roomVO.getUSER_user_id());
		}

		*/
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());

	}
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}
}