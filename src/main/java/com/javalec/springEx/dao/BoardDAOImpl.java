package com.javalec.springEx.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.javalec.springEx.dto.BoardBean;

public class BoardDAOImpl implements BoardDAO {

	DataSource dataSource;

	public BoardDAOImpl() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle11g");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	@Override
	public ArrayList<BoardBean> list() {
		ArrayList<BoardBean> bBeans = new ArrayList<BoardBean>();
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			conn = dataSource.getConnection();
			StringBuffer query = new StringBuffer();
			query.append("select bId, bName, bTitle, bContent, bDate ");
			query.append("bHit, bGroup, bStep, bIndent from board");
			psmt = conn.prepareStatement(query.toString());
			rs = psmt.executeQuery();

			while (rs.next()) {
				int bId = rs.getInt("bId");
				String bName = rs.getString("bName");
				String bTitle = rs.getString("bTitle");
				String bContent = rs.getString("bContent");
				Timestamp bDate = rs.getTimestamp("bDate");
				int bHit = rs.getInt("bHit");
				int bGroup = rs.getInt("bGroup");
				int bStep = rs.getInt("bStep");
				int bIndent = rs.getInt("bIndent");

				BoardBean bBean = new BoardBean(bId, bName, bTitle, bContent, bDate, bHit, bGroup, bStep, bIndent);
				bBeans.add(bBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bBeans;
	}

	@Override
	public void write(String bName, String bTitle, String Content) {
		// TODO Auto-generated method stub

	}

}
