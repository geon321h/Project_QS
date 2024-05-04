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

public class Play_Record_DAO {

private static Play_Record_DAO instance;
	
	public static Play_Record_DAO getInstance() {
		if(instance==null) {
			instance = new Play_Record_DAO();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs =null;
	
	public Play_Record_DAO() {

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
	
	public ArrayList<Play_Record_DTO> getRecordByKey(int member,int content) {
		ArrayList<Play_Record_DTO> lists = new ArrayList<>();
		
		String sql = "SELECT * "
				+ "FROM PLAY_RECORD "
				+ "WHERE MEMBER_KEY = ?  "
				+ "AND CONTENT_KEY = ? ";
		
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member);
			ps.setInt(2, content);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				lists.add(getRecordBean(rs));
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
	
	public int contentRecordCount(int content) {
		int cnt = -1;
		
		String sql = "SELECT COUNT(*) cnt "
				+ "      FROM PLAY_RECORD "
				+ "      WHERE CONTENT_KEY = ?";
		
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, content);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt("cnt");
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
		
		return cnt;
	}
	
	public boolean contentLikeCheck(int member,int content) {
		boolean flag = false;
		
		String sql = "SELECT * "
				+ "      FROM LIKE_CONTENT "
				+ "      WHERE MEMBER_KEY = ? "
				+ "      AND CONTENT_KEY = ?";
		
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member);
			ps.setInt(2, content);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				flag = true;
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
		
		return flag;
	}
	
	public int contentLikeCount(int content) {
		int cnt = -1;
		
		String sql = "SELECT COUNT(*) cnt "
				+ "      FROM LIKE_CONTENT "
				+ "      WHERE CONTENT_KEY = ?";
		
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, content);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt("cnt");
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
		
		return cnt;
	}
	
	public void changeLike_Content(int content,int member,String change_type) {
		String sql_insert = "INSERT INTO LIKE_CONTENT "
				+ "VALUES (?,?)";
		String sql_delete = "DELETE LIKE_CONTENT WHERE CONTENT_KEY = ? AND MEMBER_KEY = ?";
		
		try {
			if(change_type.equals("insert")){
				ps = conn.prepareStatement(sql_insert);
			}else if(change_type.equals("delete")){
				ps = conn.prepareStatement(sql_delete);
			}
			ps.setInt(1, content);
			ps.setInt(2, member);
			
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

	public Play_Record_DTO getRecordBean(ResultSet rs)throws SQLException {
		Play_Record_DTO pr_dto = new Play_Record_DTO();
		
		pr_dto.setContent_key(rs.getInt("content_key"));
		pr_dto.setMember_key(rs.getInt("member_key"));
		pr_dto.setScore(rs.getInt("score"));
		pr_dto.setPlay_day(String.valueOf(rs.getDate("play_day")));
		
		return pr_dto;
	}
	
	
}
