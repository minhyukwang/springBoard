package com.javalec.springEx.dao;

import java.util.ArrayList;

import com.javalec.springEx.dto.BoardBean;

public interface BoardDAO {
	ArrayList<BoardBean> list();
	void write(String bName, String bTitle, String Content);
}
