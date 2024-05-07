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

public class Quiz_List_DAO {

private static Quiz_List_DAO instance;
	
	public static Quiz_List_DAO getInstance() {
		if(instance==null) {
			instance = new Quiz_List_DAO();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs =null;
	
	public Quiz_List_DAO() {

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
	
	public int insertQuiz(ArrayList<Quiz_List_DTO> quiz_lists, int content_key) {
		int cnt = -1;
		int success = 0;
		String sql = "INSERT INTO QUIZ_LIST "
				+ "VALUES ((SELECT NVL(MAX(QUIZ_KEY),0)+1 FROM QUIZ_LIST  WHERE CONTENT_KEY=?) "
				+ "        ,?,?,?,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, content_key);
			ps.setInt(2, content_key);
			
			for(Quiz_List_DTO q_dto : quiz_lists) {
				ps.setString(3, q_dto.getQuestion());
				ps.setString(4, q_dto.getImage());
				ps.setString(5, q_dto.getExample());
				ps.setString(6, q_dto.getAnswer());
				ps.setInt(7, q_dto.getQuiz_type());
				success += ps.executeUpdate(); 
				cnt = success;
			}
			
			
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
	
	public int updateQuiz(ArrayList<Quiz_List_DTO> quiz_lists, int content_key) {
		int cnt = -1;
		String sql = "DELETE QUIZ_LIST WHERE CONTENT_KEY =?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, content_key);
			ps.executeUpdate();
			
			cnt = insertQuiz(quiz_lists,content_key);
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
	
	public ArrayList<Quiz_List_DTO> getQuizByKey(String content_key) {
		String sql = "SELECT * FROM QUIZ_LIST where CONTENT_KEY =?";
		ArrayList<Quiz_List_DTO> lists = new ArrayList<>();
		Quiz_List_DTO ql_dto = null;
		int key = Integer.parseInt(content_key);
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, key);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ql_dto = getQuizBean(rs);
				lists.add(ql_dto);
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
	
	public Quiz_List_DTO getQuizBean(ResultSet rs)throws SQLException {
		Quiz_List_DTO ql_dto = new Quiz_List_DTO();
		
		ql_dto.setQuiz_key(rs.getInt("quiz_key"));
		ql_dto.setContent_key(rs.getInt("content_key"));
		ql_dto.setQuestion(rs.getString("question"));
		ql_dto.setImage(rs.getString("image"));
		ql_dto.setExample(rs.getString("example"));
		ql_dto.setAnswer(rs.getString("answer"));
		ql_dto.setQuiz_type(rs.getInt("quiz_type"));
		
		return ql_dto;
	}
	
	
	
}











