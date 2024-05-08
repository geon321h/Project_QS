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
	
	public ArrayList<questions_DTO> getAllMyQue(int member_key,int startRow, int endRow) {
		String sql = "SELECT * FROM(SELECT ROWNUM RANK,QUESTION_KEY,MEMBER_KEY,QUE_TITLE,QUE_CONTENT,QUE_TYPE,REPLY_KEY,QUE_DAY  "
				+ " FROM (SELECT * "
				+ "      FROM QUESTIONS  "
				+ "      WHERE MEMBER_KEY = ? "
				+ "		AND QUE_TYPE != '답변'"
				+ "      ORDER BY QUE_DAY DESC)"
				+ ")WHERE RANK BETWEEN ? and ? ORDER BY RANK";
		ArrayList<questions_DTO> lists = new ArrayList<>();
		questions_DTO qu_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_key);
			ps.setInt(2, startRow);
			ps.setInt(3, endRow);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				qu_dto = getQuestionsBean(rs);
				qu_dto.setRank(rs.getInt("rank"));
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
	
	public ArrayList<questions_DTO> getAllQue(int startRow, int endRow) {
		String sql = "SELECT * FROM(SELECT ROWNUM RANK,QUESTION_KEY,MEMBER_KEY,QUE_TITLE,QUE_CONTENT,QUE_TYPE,REPLY_KEY,QUE_DAY  "
				+ " FROM (SELECT * "
				+ "      FROM QUESTIONS  "
				+ "      WHERE QUE_TYPE != '답변'"
				+ "      ORDER BY QUE_DAY DESC)"
				+ ")WHERE RANK BETWEEN ? and ? ORDER BY RANK";
		ArrayList<questions_DTO> lists = new ArrayList<>();
		questions_DTO qu_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, endRow);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				qu_dto = getQuestionsBean(rs);
				qu_dto.setRank(rs.getInt("rank"));
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
	
	public int getAllMyQueCount(int member_key) {
		int cnt = 0;
		String sql = "SELECT COUNT(*) cnt "
				+ "      FROM QUESTIONS  "
				+ "      WHERE MEMBER_KEY = ? "
				+ "		AND QUE_TYPE != '답변'";
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_key);
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
	
	public int getAllQueCount() {
		int cnt = 0;
		String sql = "SELECT COUNT(*) cnt "
				+ "      FROM QUESTIONS  "
				+ "      WHERE QUE_TYPE != '답변'";
		try {
			
			ps = conn.prepareStatement(sql);
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
	
	public int getAllMyQueTypeCount(int member_key,String type) {
		int cnt = 0;
		String sql = "SELECT COUNT(*) cnt "
				+ "      FROM QUESTIONS  "
				+ "      WHERE MEMBER_KEY = ? "
				+ "		AND QUE_TYPE = ?";
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_key);
			ps.setString(2, type);
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
	
	public int getAllQueTypeCount(String type) {
		int cnt = 0;
		String sql = "SELECT COUNT(*) cnt "
				+ "      FROM QUESTIONS  "
				+ "      WHERE QUE_TYPE = ?";
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, type);
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
	
	public ArrayList<questions_DTO> getAllMyQueByType(int member_key,String type,int startRow, int endRow) {
		String sql = "SELECT * FROM(SELECT ROWNUM RANK,QUESTION_KEY,MEMBER_KEY,QUE_TITLE,QUE_CONTENT,QUE_TYPE,REPLY_KEY,QUE_DAY  "
				+ " FROM (SELECT * "
				+ "      FROM QUESTIONS  "
				+ "      WHERE MEMBER_KEY = ? "
				+ "		AND QUE_TYPE = ? "
				+ "      ORDER BY QUE_DAY DESC)"
				+ ")WHERE RANK BETWEEN ? and ? ORDER BY RANK";
		ArrayList<questions_DTO> lists = new ArrayList<>();
		questions_DTO qu_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_key);
			ps.setString(2, type);
			ps.setInt(3, startRow);
			ps.setInt(4, endRow);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				qu_dto = getQuestionsBean(rs);
				qu_dto.setRank(rs.getInt("rank"));
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
	
	public ArrayList<questions_DTO> getAllQueByType(String type,int startRow, int endRow) {
		String sql = "SELECT * FROM(SELECT ROWNUM RANK,QUESTION_KEY,MEMBER_KEY,QUE_TITLE,QUE_CONTENT,QUE_TYPE,REPLY_KEY,QUE_DAY  "
				+ " FROM (SELECT * "
				+ "      FROM QUESTIONS  "
				+ "      WHERE QUE_TYPE = ? "
				+ "      ORDER BY QUE_DAY DESC)"
				+ ")WHERE RANK BETWEEN ? and ? ORDER BY RANK";
		ArrayList<questions_DTO> lists = new ArrayList<>();
		questions_DTO qu_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, type);
			ps.setInt(2, startRow);
			ps.setInt(3, endRow);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				qu_dto = getQuestionsBean(rs);
				qu_dto.setRank(rs.getInt("rank"));
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
	
	public ArrayList<questions_DTO> getAllMyQueByAccount(int member_key) {
		String sql = "SELECT ROWNUM RANK,QUESTION_KEY,MEMBER_KEY,QUE_TITLE,QUE_CONTENT,QUE_TYPE,REPLY_KEY,QUE_DAY  "
				+ " FROM (SELECT * "
				+ "      FROM QUESTIONS  "
				+ "      WHERE MEMBER_KEY = ? "
				+ "		AND QUE_TYPE = '계정문의' "
				+ "      ORDER BY QUE_DAY DESC)";
		ArrayList<questions_DTO> lists = new ArrayList<>();
		questions_DTO qu_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_key);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				qu_dto = getQuestionsBean(rs);
				qu_dto.setRank(rs.getInt("rank"));
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
	
	public ArrayList<questions_DTO> getAllMyQueByReport(int member_key) {
		String sql = "SELECT ROWNUM RANK,QUESTION_KEY,MEMBER_KEY,QUE_TITLE,QUE_CONTENT,QUE_TYPE,REPLY_KEY,QUE_DAY  "
				+ " FROM (SELECT * "
				+ "      FROM QUESTIONS  "
				+ "      WHERE MEMBER_KEY = ? "
				+ "		AND QUE_TYPE = '버그/오류 제보' "
				+ "      ORDER BY QUE_DAY DESC)";
		ArrayList<questions_DTO> lists = new ArrayList<>();
		questions_DTO qu_dto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_key);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				qu_dto = getQuestionsBean(rs);
				qu_dto.setRank(rs.getInt("rank"));
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
	
	
	public questions_DTO getQueByKey(String member,String question) {
		String sql = "SELECT * FROM QUESTIONS WHERE MEMBER_KEY=? AND QUESTION_KEY=?";
		questions_DTO qu_dto = null;
		int member_key = Integer.parseInt(member);
		int question_key = Integer.parseInt(question);
		
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_key);
			ps.setInt(2, question_key);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				qu_dto = getQuestionsBean(rs);
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
		
		return qu_dto;
	}
	
	public questions_DTO getQueReplyByKey(String member,String question) {
		String sql = "SELECT * FROM QUESTIONS WHERE MEMBER_KEY=? AND REPLY_KEY=?";
		questions_DTO qu_dto = null;
		int member_key = Integer.parseInt(member);
		int question_key = Integer.parseInt(question);
		
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_key);
			ps.setInt(2, question_key);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				qu_dto = getQuestionsBean(rs);
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
		
		return qu_dto;
	}
	
	public int insertQuestion(questions_DTO qu_dto) {
		int cnt = -1;
		String sql = "INSERT INTO QUESTIONS (QUESTION_KEY,MEMBER_KEY,QUE_TITLE,QUE_CONTENT,QUE_TYPE) "
				+ "VALUES((SELECT NVL(MAX(QUESTION_KEY),0)+1 FROM QUESTIONS WHERE MEMBER_KEY=?), "
				+ "      ?,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qu_dto.getMember_key());
			ps.setInt(2, qu_dto.getMember_key());
			ps.setString(3, qu_dto.getQue_title());
			ps.setString(4, qu_dto.getQue_content());
			ps.setString(5, qu_dto.getQue_type());
			
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
	
	public int insertReplyQuestion(questions_DTO qu_dto) {
		int cnt = -1;
		String sql = "INSERT INTO QUESTIONS (QUESTION_KEY,MEMBER_KEY,QUE_TITLE,QUE_CONTENT,QUE_TYPE,REPLY_KEY) "
				+ "VALUES((SELECT NVL(MAX(QUESTION_KEY),0)+1 FROM QUESTIONS WHERE MEMBER_KEY=?), "
				+ "      ?,?,?,'답변',?)";
		String sql_update = "UPDATE QUESTIONS SET REPLY_KEY = ? WHERE MEMBER_KEY = ? AND QUESTION_KEY =?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qu_dto.getMember_key());
			ps.setInt(2, qu_dto.getMember_key());
			ps.setString(3, qu_dto.getQue_title());
			ps.setString(4, qu_dto.getQue_content());
			ps.setInt(5, qu_dto.getReply_key());
			
			cnt = ps.executeUpdate();
			String member = String.valueOf(qu_dto.getMember_key());
			String reply = String.valueOf(qu_dto.getReply_key());
			questions_DTO reply_dto = getQueReplyByKey(member,reply);
			
			ps = conn.prepareStatement(sql_update);
			ps.setInt(1, reply_dto.getQuestion_key());
			ps.setInt(2, qu_dto.getMember_key());
			ps.setInt(3, qu_dto.getReply_key());
			cnt += ps.executeUpdate();
			
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
	
	public int updateQuestion(questions_DTO qu_dto) {
		int cnt = -1;
		String sql = "UPDATE QUESTIONS SET QUE_TITLE = ?, QUE_CONTENT =? ,QUE_TYPE=? "
				+ "	WHERE MEMBER_KEY = ? AND QUESTION_KEY =?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, qu_dto.getQue_title());
			ps.setString(2, qu_dto.getQue_content());
			ps.setString(3, qu_dto.getQue_type());
			ps.setInt(4, qu_dto.getMember_key());
			ps.setInt(5, qu_dto.getQuestion_key());
			
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
	
	public int updateReplyQuestion(questions_DTO qu_dto) {
		int cnt = -1;
		String sql = "UPDATE QUESTIONS SET QUE_CONTENT =? ,QUE_DAY=sysdate "
				+ "	WHERE MEMBER_KEY = ? AND REPLY_KEY =?";
		
		try {
			ps = conn.prepareStatement(sql);
			System.out.println(qu_dto.getQue_content());
			ps.setString(1, qu_dto.getQue_content());
			ps.setInt(2, qu_dto.getMember_key());
			ps.setInt(3, qu_dto.getReply_key());
			
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
	
	
	public int deleteQuestion(questions_DTO qu_dto) {
		int cnt = -1;
		int cnt_re = -1;
		String sql = "delete QUESTIONS where QUESTION_KEY =? and MEMBER_KEY =?";
		String sql_reply = "delete QUESTIONS where REPLY_KEY =?  and MEMBER_KEY =?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qu_dto.getQuestion_key());
			ps.setInt(2, qu_dto.getMember_key());
			
			cnt = ps.executeUpdate();
			
			ps = conn.prepareStatement(sql_reply);
			ps.setInt(1, qu_dto.getQuestion_key());
			ps.setInt(2, qu_dto.getMember_key());
			
			cnt_re = ps.executeUpdate();
			//System.out.println(cnt_re);
			
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
	
	public questions_DTO getQuestionsBean(ResultSet rs)throws SQLException {
		questions_DTO qu_dto = new questions_DTO();
		
		qu_dto.setQuestion_key(rs.getInt("question_key"));
		qu_dto.setMember_key(rs.getInt("member_key"));
		qu_dto.setQue_title(rs.getString("que_title"));
		qu_dto.setQue_content(rs.getString("que_content"));
		qu_dto.setQue_type(rs.getString("que_type"));
		qu_dto.setReply_key(rs.getInt("reply_key"));
		qu_dto.setQue_day(rs.getTimestamp("que_day"));		
		
		return qu_dto;
	}
	
}
