package com.javalec.springEx.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.javalec.springEx.dao.BoardDAO;
import com.javalec.springEx.dao.BoardDAOImpl;
import com.javalec.springEx.dto.BoardBean;

public class BoardServiceFacadeImpl implements BoardServiceFacade {

	
	static BoardDAO bDao;
	static BoardDAO getInstance(){
		if (bDao==null)
			bDao = new BoardDAOImpl();	
		return bDao;
	}
	public BoardServiceFacadeImpl(){}
	
	public void viewList(Model model){
		getInstance();
		ArrayList<BoardBean> bBeans = bDao.list();
		
		model.addAttribute("list",bBeans);
	}
	
	public void writeBoard(Model model){
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		String bName=request.getParameter("bName");
		String bTitle=request.getParameter("bTitle");
		String bContent=request.getParameter("bContent");
		getInstance();
		bDao.write(bName, bTitle, bContent);
	}
	
}
