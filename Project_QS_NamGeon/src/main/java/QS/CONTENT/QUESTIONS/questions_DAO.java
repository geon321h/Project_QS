package QS.CONTENT.QUESTIONS;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import QS.CONTENT.Play_Record_DTO;
import QS.MEMBER.Member_Info_DTO;

public class questions_DAO {

private static questions_DAO instance;
	
	public static questions_DAO getInstance() {
		if(instance==null) {
			instance = new questions_DAO();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs =null;
	
	public questions_DAO() {
		
		Context initContext;
		try {
			initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB"); 
			conn = ds.getConnection();
		} catch (NamingException | SQLException e1) {
			e1.printStackTrace();
		}
		
	}
	
	public ArrayList<questions_DTO> getAllMyQue(int member_key) {
		String sql = "SELECT ROWNUM RANK,QUESTION_KEY,MEMBER_KEY,QUE_TITLE,QUE_CONTENT,QUE_TYPE,REPLY_KEY,QUE_DAY  "
				+ " FROM (SELECT * "
				+ "      FROM QUESTIONS  "
				+ "      WHERE MEMBER_KEY = ? "
				+ "      ORDER BY QUE_DAY DESC)";
		ArrayList<questions_DTO> lists = new ArrayList<>();
		questions_DTO qu_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_key);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				qu_dto = getQuestionsBean(rs);
				lists.add(qu_dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if (ps!=null) {
					ps.close();
				}
				if (rs!=null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		
		return lists;
	}
	
	public questions_DTO getQuestionsBean(ResultSet rs)throws SQLException {
		questions_DTO qu_dto = new questions_DTO();
		
		qu_dto.setQuestion_key(rs.getInt("question_key"));
		qu_dto.setMember_key(rs.getInt("member_key"));
		qu_dto.setQue_title(rs.getString("que_title"));
		qu_dto.setQue_content(rs.getString("que_content"));
		qu_dto.setQue_type(rs.getString("que_type"));
		qu_dto.setReply_key(rs.getInt("reply_key"));
		qu_dto.setQue_day(rs.getTimestamp("que_day"));
		qu_dto.setRank(rs.getInt("rank"));
		
		return qu_dto;
	}
	
}
