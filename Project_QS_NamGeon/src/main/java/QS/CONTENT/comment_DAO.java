package QS.CONTENT;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import QS.MEMBER.Member_Info_DTO;

public class comment_DAO {

private static comment_DAO instance;
	
	public static comment_DAO getInstance() {
		if(instance==null) {
			instance = new comment_DAO();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs =null;
	
	public comment_DAO() {

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
	
	public ArrayList<comment_DTO> getCommentByKey(int content) {
		ArrayList<comment_DTO> lists = new ArrayList<>();
		
		String sql = "SELECT COMMENT_KEY,CONTENT_KEY,T10.MEMBER_KEY,COMMENT_TEXT,COMMENT_DAY,USER_NAME "
				+ "FROM (SELECT COMMENT_KEY,CONTENT_KEY,MEMBER_KEY,COMMENT_TEXT,COMMENT_DAY "
				+ "      FROM CONTENT_COMMENT "
				+ "      WHERE CONTENT_KEY = ?) T10 "
				+ "     ,(SELECT MEMBER_KEY,BAN,USER_NAME "
				+ "      FROM MEMBER_INFO "
				+ "      WHERE BAN = 'N') T20 "
				+ "WHERE  T10.MEMBER_KEY = T20.MEMBER_KEY ";
		
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, content);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				lists.add(getCommentBean(rs));
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
	
	public void insertComment(comment_DTO c_dto) {
		String sql = "INSERT INTO CONTENT_COMMENT(COMMENT_KEY,CONTENT_KEY,MEMBER_KEY,COMMENT_TEXT) "
				+ "VALUES (COMMENT_SEQ.NEXTVAL,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, c_dto.getContent_key());
			ps.setInt(2, c_dto.getMember_key());
			ps.setString(3, c_dto.getComment_text());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if (ps!=null) {
					ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		
	}
	
	public int deleteComment(int comment_key) {
		int cnt=-1;
			
		String sql = "delete CONTENT_COMMENT where comment_key = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, comment_key);
			
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if (ps!=null) {
					ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		
		return cnt;
	}
	
	public comment_DTO getCommentBean(ResultSet rs)throws SQLException {
		comment_DTO c_dto = new comment_DTO();
		
		c_dto.setComment_key(rs.getInt("comment_key"));
		c_dto.setContent_key(rs.getInt("content_key"));
		c_dto.setMember_key(rs.getInt("member_key"));
		c_dto.setComment_text(rs.getString("comment_text"));
		c_dto.setUser_name(rs.getString("user_name"));
		c_dto.setComment_day(rs.getTimestamp("comment_day"));
		
		return c_dto;
	}
	
}
