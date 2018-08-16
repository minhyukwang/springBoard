package com.javalec.springEx.service;

import org.springframework.ui.Model;

public interface BoardServiceFacade {

	void viewList(Model model);
	void writeBoard(Model model);
}
