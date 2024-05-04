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

public class Content_List_DAO {

	private static Content_List_DAO instance;
	
	public static Content_List_DAO getInstance() {
		if(instance==null) {
			instance = new Content_List_DAO();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs =null;
	
	public Content_List_DAO() {

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

	
	public int insertContent(Content_List_DTO cl_dto) {
		int content_key = -1;
		
		String sql_insert = "INSERT INTO CONTENT_LIST(CONTENT_KEY,TITLE,EXPLANATION,CREATE_USER,THUMBNAIL,CONTENT_COUNT,CONTENT_PUBLIC,CONTENT_TYPE) "
				+ "VALUES(CONTENT_SEQ.NEXTVAL,?,?,?,?,?,?,'QUIZ')";
		
		String sql_select = "SELECT MAX(CONTENT_KEY) LAST_KEY FROM CONTENT_LIST";
		
		try {
			ps = conn.prepareStatement(sql_insert);
			ps.setString(1, cl_dto.getTitle());
			ps.setString(2, cl_dto.getExplanation());
			ps.setInt(3, cl_dto.getCreate_user());
			ps.setString(4, cl_dto.getThumbnail());
			ps.setInt(5, cl_dto.getContent_count());
			ps.setString(6, cl_dto.getContent_public());
			
			ps.executeUpdate();
			
			ps = conn.prepareStatement(sql_select);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				content_key = rs.getInt("LAST_KEY");
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
		
		return content_key;
	}
	
	public ArrayList<Content_List_DTO> getAllContent() {
		String sql = "SELECT CONTENT_KEY,TITLE,EXPLANATION,T10.CREATE_USER,THUMBNAIL,CONTENT_COUNT,CONTENT_PUBLIC,CREATE_DAY,T20.BAN,T20.USER_NAME "
				+ "FROM (SELECT CONTENT_KEY,TITLE,EXPLANATION,CREATE_USER,THUMBNAIL,CONTENT_COUNT,CONTENT_PUBLIC,CREATE_DAY "
				+ "      FROM CONTENT_LIST)T10 "
				+ "    ,(SELECT MEMBER_KEY,BAN,USER_NAME "
				+ "      FROM MEMBER_INFO) T20 "
				+ "WHERE T10.CREATE_USER = T20.MEMBER_KEY "
				+ "ORDER BY CONTENT_KEY";
		ArrayList<Content_List_DTO> lists = new ArrayList<>();
		Content_List_DTO cl_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cl_dto = getContentBean(rs);
				lists.add(cl_dto);
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
	
	public ArrayList<Content_List_DTO> getAllContentRecent(String search) {
		String sql = "SELECT CONTENT_KEY,TITLE,EXPLANATION,T10.CREATE_USER,THUMBNAIL,CONTENT_COUNT,CONTENT_PUBLIC,CREATE_DAY,T20.BAN,T20.USER_NAME "
				+ "FROM (SELECT CONTENT_KEY,TITLE,EXPLANATION,CREATE_USER,THUMBNAIL,CONTENT_COUNT,CONTENT_PUBLIC,CREATE_DAY "
				+ "      FROM CONTENT_LIST)T10 "
				+ "    ,(SELECT MEMBER_KEY,BAN,USER_NAME "
				+ "      FROM MEMBER_INFO"
				+ "	   WHERE BAN = 'N') T20 "
				+ "WHERE T10.CREATE_USER = T20.MEMBER_KEY "
				+ "AND (USER_NAME LIKE ? OR TITLE LIKE ?) "
				+ "ORDER BY CREATE_DAY DESC";
		ArrayList<Content_List_DTO> lists = new ArrayList<>();
		Content_List_DTO cl_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
			ps.setString(2, "%"+search+"%");
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cl_dto = getContentBean(rs);
				lists.add(cl_dto);
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
	
	public ArrayList<Content_List_DTO> getAllContentLike(String search) {
		String sql = "SELECT CONTENT_KEY,TITLE,EXPLANATION,T10.CREATE_USER,THUMBNAIL,CONTENT_COUNT,CONTENT_PUBLIC,CREATE_DAY,T20.BAN,T20.USER_NAME, NVL(CNT, 0) CNT "
				+ "FROM (SELECT T11.CONTENT_KEY,TITLE,EXPLANATION,CREATE_USER,THUMBNAIL,CONTENT_COUNT,CONTENT_PUBLIC,CREATE_DAY,CNT "
				+ "      FROM (SELECT * "
				+ "            FROM CONTENT_LIST) T11 "
				+ "      LEFT OUTER JOIN "
				+ "           (SELECT CONTENT_KEY, COUNT(*)CNT "
				+ "            FROM LIKE_CONTENT "
				+ "            GROUP BY CONTENT_KEY) T12 "
				+ "      ON T11.CONTENT_KEY = T12.CONTENT_KEY)T10 "
				+ "    ,(SELECT MEMBER_KEY,BAN,USER_NAME "
				+ "      FROM MEMBER_INFO "
				+ "      WHERE BAN = 'N') T20 "
				+ "WHERE T10.CREATE_USER = T20.MEMBER_KEY "
				+ "AND (USER_NAME LIKE ? OR TITLE LIKE ?) "
				+ "ORDER BY CNT DESC, CONTENT_KEY DESC ";
		ArrayList<Content_List_DTO> lists = new ArrayList<>();
		Content_List_DTO cl_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
			ps.setString(2, "%"+search+"%");
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cl_dto = getContentBean(rs);
				lists.add(cl_dto);
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
	
	public ArrayList<Content_List_DTO> getAllContentPlay(String search) {
		String sql = "SELECT CONTENT_KEY,TITLE,EXPLANATION,T10.CREATE_USER,THUMBNAIL,CONTENT_COUNT,CONTENT_PUBLIC,CREATE_DAY,T20.BAN,T20.USER_NAME, NVL(CNT, 0) CNT "
				+ "FROM (SELECT T11.CONTENT_KEY,TITLE,EXPLANATION,CREATE_USER,THUMBNAIL,CONTENT_COUNT,CONTENT_PUBLIC,CREATE_DAY,CNT "
				+ "      FROM (SELECT * "
				+ "            FROM CONTENT_LIST) T11 "
				+ "      LEFT OUTER JOIN "
				+ "           (SELECT CONTENT_KEY, COUNT(*)CNT "
				+ "            FROM PLAY_RECORD "
				+ "            GROUP BY CONTENT_KEY) T12 "
				+ "      ON T11.CONTENT_KEY = T12.CONTENT_KEY)T10 "
				+ "    ,(SELECT MEMBER_KEY,BAN,USER_NAME "
				+ "      FROM MEMBER_INFO "
				+ "      WHERE BAN = 'N') T20 "
				+ "WHERE T10.CREATE_USER = T20.MEMBER_KEY "
				+ "AND (USER_NAME LIKE ? OR TITLE LIKE ?) "
				+ "ORDER BY CNT DESC, CONTENT_KEY DESC ";
		ArrayList<Content_List_DTO> lists = new ArrayList<>();
		Content_List_DTO cl_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
			ps.setString(2, "%"+search+"%");
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cl_dto = getContentBean(rs);
				lists.add(cl_dto);
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
	
	public int delete_content_quiz(String[] rowcheckArr) {
		int cnt = -1;
		String sql = "delete from content_list where content_key = ? ";
		
		for(int i=1;i<rowcheckArr.length;i++) {
			sql += " or content_key=?";
		}
		try {
			ps = conn.prepareStatement(sql);
			for(int i=0;i<rowcheckArr.length;i++) {
				int row = Integer.parseInt(rowcheckArr[i]);
				ps.setInt(i+1, row);
			}
			
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


	public Content_List_DTO getContentBean(ResultSet rs)throws SQLException {
		Content_List_DTO cl_dto = new Content_List_DTO();
		
		cl_dto.setContent_key(rs.getInt("content_key"));
		cl_dto.setTitle(rs.getString("title"));
		cl_dto.setExplanation(rs.getString("explanation"));
		cl_dto.setCreate_user(rs.getInt("create_user"));
		cl_dto.setThumbnail(rs.getString("thumbnail"));
		cl_dto.setContent_count(rs.getInt("content_count"));
		cl_dto.setContent_public(rs.getString("content_public"));
		cl_dto.setUser_name(rs.getString("user_name"));
		cl_dto.setCreate_day(String.valueOf(rs.getDate("create_day")));
		cl_dto.setBan(rs.getString("ban"));
		
		return cl_dto;
	}
	
	
	
	
	
}









