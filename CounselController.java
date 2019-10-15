package com.myungjin.mj010.app.activity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myungjin.mj010.app.sf.CounselService;
import com.myungjin.mj010.app.vo.ChatVO;
import com.myungjin.mj010.app.vo.CounselVO;
import com.myungjin.mj010.app.vo.NoteVO;
import com.myungjin.mj010.app.vo.SelfCheckAnsVO;
import com.myungjin.mj010.app.vo.SelfCheckQuVO;
import com.myungjin.mj010.app.vo.SelfCheckVO;
import com.myungjin.mj010.common.constants.CodeValueConstants;
import com.myungjin.mj010.member.vo.LoginVO;
import com.myungjin.mj010.member.vo.MemberVO;


/**
 * 상담 관련 Control class
 */

@Controller
@RequestMapping("/counsel/*")
public class CounselController implements CodeValueConstants
{
	@Autowired
	private CounselService counselService;
	private MemberVO memberVO;

	/*
	 * Note(메세지) 관련 메서드
	 */
	@RequestMapping(value = "/getSendNoteList", method = RequestMethod.POST)
	@ResponseBody
	public List<NoteVO> sendNoteListPOST(@ModelAttribute("dto") MemberVO vo,@RequestParam("flag") String flag ) throws Exception
	{
		String memId=vo.getMem_id();
		Map<String, String> map=new HashMap<String, String>();
		map.put("mem_id", memId);
		map.put("flag", flag);
		List<NoteVO> titleList = counselService.getSendNoteList(map);
		return titleList;
	}

	@RequestMapping(value = "/mngNote", method = RequestMethod.GET)
	public void mngNote(HttpSession session){
		Object obj = session.getAttribute(LOGIN);
		memberVO = (MemberVO) obj;
	}

	/**
	 * <pre>
	 * 1. 개요: 쪽지보내기
	 * 2. 처리내용: 관리자에게 쪽지를 보내는 메소드이다.
	 *
	 * </pre>
	 * @Method Name: sendNotePOST
	 * @param vo
	 * @param session
	 */
	@RequestMapping(value = "/mngNote", method = RequestMethod.POST)
	public void sendNotePOST(NoteVO vo, HttpSession session) {
		memberVO = (MemberVO) session.getAttribute(LOGIN);
		vo.setSend_mem_id(memberVO.getMem_id());
		try {
			counselService.insertNote(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * <pre>
	 * 1. 개요: Note
	 * 2. 처리내용: 쪽지 읽음처리
	 */
	@RequestMapping(value = "/noteContents", method = RequestMethod.GET)
	public void noteContentsGET(@RequestParam("note_seq") int note_seq, @RequestParam("mem_id") String mem_id,
			@RequestParam("mem_name") String mem_name, @RequestParam("co_type") String co_type) throws Exception
	{
		System.out.println(mem_id+","+memberVO.getMem_id());
		if (mem_id.equals(memberVO.getMem_id()))
			return;
		else
			counselService.modifyNoteConfirm(note_seq);
	}

	@RequestMapping(value = "/getNoteContents",  method = RequestMethod.POST)
	@ResponseBody
	public NoteVO getNoteContents(@RequestParam("note_seq") int note_seq) throws Exception
	{
		return counselService.getNoteContent(note_seq);
	}


/*	@RequestMapping(value = "/sendNote", method = RequestMethod.GET)
	public void sendNote(){}

	@RequestMapping(value = "/sendNote", method = RequestMethod.POST)
	@ResponseBody
	public void sendNotePOST(@RequestParam("note_title") String note_title, @RequestParam("send_mem_id") String send_mem_id,
			@RequestParam("reci_mem_id") String reci_mem_id, @RequestParam("note_contents") String note_contents, @RequestParam("co_type") String co_type) {
		NoteVO vo = new NoteVO();
		vo.setNote_title(note_title);
		vo.setNote_contents(note_contents);
		vo.setSend_mem_id(send_mem_id);
		vo.setReci_mem_id(reci_mem_id);
		vo.setCo_type(co_type);
		try {
			counselService.insertNote(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/

	/*
	 * 자가진단 관련 메소드
	*/
	@RequestMapping(value = "/selfCheck", method = RequestMethod.GET)
	public void selfCheckGET()
	{

	}

	/*
	 * 자가진단 관련 메소드
	*/
	@RequestMapping(value = "/selfCheckResult", method = RequestMethod.GET)
	public void selfCheckResultGET()
	{

	}

/*
	@RequestMapping(value = "/selfCheckDetail", method = RequestMethod.GET)
	public void selfCheckDetailGET()
	{
	}*/

	@RequestMapping(value = "/selfCheckDetail", method = RequestMethod.GET)
	public void selfCheckDetailGET(String tdId)
	{
		//System.out.println("tdId : "+ tdId);
		//return "redirect:/counsel/selfCheckDetail";
	}

	/**
	 * 자가진단 내용 불러오기
	 * @param checkId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSelfCheckDetail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selfCheckDetailPOST(@RequestParam("checkId") String checkId) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();
		SelfCheckVO selfCheckVo = counselService.getSelfCheck(checkId);
		List<SelfCheckAnsVO> selfCheckAnsVoList = counselService.getSelfCheckAnsList(checkId);
		List<SelfCheckQuVO> selfCheckQuVoList = counselService.getSelfCheckQuList(checkId);
		map.put("selfCheck", selfCheckVo);
		map.put("selfCheckAns", selfCheckAnsVoList);
		map.put("selfCheckQu", selfCheckQuVoList);
		map.put("selfCheckCnt", selfCheckQuVoList.size());
		map.put(DATA_YN, FLAG_Y);

		return map;
	}

	/**
	 * 자가진단 결과평가 불러오기
	 * @param checkId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSelfCheckAppr", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selfCheckApprPOST(@RequestParam("checkId") String checkId) throws Exception
	{
		Map<String, Object> map = new HashMap<String, Object>();
		SelfCheckVO selfCheckVo = counselService.getSelfCheckAppr(checkId);

		map.put("selfCheck", selfCheckVo);
		map.put(DATA_YN, FLAG_Y);
		return map;
		}
	/*
	 * 상담관리 관련 메소드
	 */
	@RequestMapping(value = "/mngCounsel", method = RequestMethod.GET)
	public void mngCounsel(){}

	@RequestMapping(value = "/regCounsel", method = RequestMethod.GET)
	public void regCounsel(){}

	@RequestMapping(value = "/getCounselList", method = RequestMethod.POST)
	@ResponseBody
	public List<CounselVO> counselListPOST(@RequestParam("auth") String auth, @RequestParam("mem_id") String mem_id) throws Exception
	{
		Map<String, String> map = new HashMap<String, String>();
		map.put("auth",auth);
		map.put("mem_id",mem_id);
		List<CounselVO> titleList = counselService.getCounselList(map);
		System.out.println(titleList.get(1).getCons_seq());
		return titleList;
	}
	/**
	 * <pre>
	 * 1. 개요: 상담을 등록한다
	 * 2. 처리내용: 상담을 등록하는 메소드이다.
	 *
	 * </pre>
	 * @Method Name: insertCounsel
	 * @param vo
	 * @param session
	 */
	@RequestMapping(value = "/mngCounsel", method = RequestMethod.POST)
	public void updateCounsel(CounselVO counselVo, HttpSession session)
	{
		memberVO = (MemberVO) session.getAttribute(LOGIN);
		counselVo.setCreated_id(memberVO.getMem_id());
		System.out.println(counselVo.getCons_comp_yn());
		try {
			counselService.insertCounsel(counselVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * <pre>
	 * 1. 개요: 상담등록예정을 등록하는 메서드이다.
	 * 2. 처리내용:
	 *
	 * </pre>
	 * @Method Name: regCounelPlan
	 */
	@RequestMapping(value = "/regCounelPlan", method = RequestMethod.POST)
	@ResponseBody
	public void regCounelPlan(@RequestParam("mem_id") String mem_id) throws Exception {
		/*if(counselService.hasCounsel(mem_id)==0) {
		counselService.insertCounselPlan(mem_id);
		return "success";
		}else
		return "already register.";*/
		System.out.println("regCounelPlan");
		counselService.insertCounselPlan(mem_id);
	}

	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public void chat(){}



	/**
	 * <pre>
	 * 1. 개요: 채팅방생성
	 * 2. 처리내용: 상담시작을 클릭하면 채팅방이 생성된다.
	 *
	 * </pre>
	 * @Method Name: regChatRoom
	 * @param created_id
	 * @param chat_topic
	 * @param chat_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/regChatRoom", method = RequestMethod.POST)
	@ResponseBody
	public String regChatRoom(@RequestParam("created_id") String created_id,
							@RequestParam("chat_topic") String chat_topic,
							@RequestParam("chat_seq") int chat_seq,
							@RequestParam("cons_seq") int cons_seq) throws Exception
	{
		ChatVO chRoom = new ChatVO();
		CounselVO counselVo = new CounselVO();
		counselVo.setCons_seq(cons_seq);
		counselVo.setChat_seq(chat_seq);
		chRoom.setCons_seq(cons_seq);
		chRoom.setChat_topic(chat_topic);
		chRoom.setCreated_id(created_id);
		if(chat_seq==0)
		{
			counselService.insertChatRoom(chRoom);
		}
		else
		{
			counselService.updateChatSeq(counselVo);
		}
		chat_seq = counselService.getChatSeq(cons_seq);
		return  String.valueOf(chat_seq);
	}
}