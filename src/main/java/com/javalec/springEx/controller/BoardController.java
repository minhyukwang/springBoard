package com.javalec.springEx.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javalec.springEx.service.BoardServiceFacade;
import com.javalec.springEx.service.BoardServiceFacadeImpl;

@Controller
public class BoardController {
	BoardServiceFacade bsf;
	
	@RequestMapping("/list")
	public String list(Model model){
		System.out.println("list()");
		
		bsf = new BoardServiceFacadeImpl();
		bsf.viewList(model);
		return "list"; 
			
	}
	
	@RequestMapping("/write_view")
	public String writeView(HttpServletRequest request, Model model){
		System.out.println("/write_view()");
		
		return "write_view";
	}
	
	@RequestMapping("/write")
	public String write(HttpServletRequest request, Model model){
		System.out.println("/write()");
		
		model.addAttribute("request",request);
		bsf = new BoardServiceFacadeImpl();
		bsf.writeBoard(model);
		
		return "redirect:list";
	}
	
	
}
