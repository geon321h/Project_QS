package QS.MEMBER;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Member_Info_DAO {

	private static Member_Info_DAO instance;
	
	public static Member_Info_DAO getInstance() {
		if(instance==null) {
			instance = new Member_Info_DAO();
		}
		return instance;
	}
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs =null;
	
	public Member_Info_DAO() {
		
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
	
	public Member_Info_DTO snsIdCheck(String snsId) {
		String sql = "select * from member_info where email = ? and LOGIN_TYPE is not null";
		Member_Info_DTO mdto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, snsId);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				mdto = getMemberBean(rs);
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
		
		return mdto;
	}
	
	public int insertMember(Member_Info_DTO mdto) {
		int cnt=-1;
			
		String sql = "INSERT INTO MEMBER_INFO(MEMBER_KEY,EMAIL,PASSWORD,USER_NAME,PHONE_NUMBER,GENDER,LOGIN_TYPE) "
				+ "VALUES(MEMBER_SEQ.NEXTVAL,?,?||MEMBER_SEQ.CURRVAL,?,?,?,?)";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mdto.getEmail());
			ps.setString(2, mdto.getLogin_type());
			ps.setString(3, mdto.getUser_name());
			ps.setString(4, mdto.getPhone_number());
			ps.setString(5, mdto.getGender());
			ps.setString(6, mdto.getLogin_type());
			
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
	
	public Member_Info_DTO login(String user_email,String user_password) {
		Member_Info_DTO mdto = null;
		String sql = "select * from MEMBER_INFO where email =? and password=?";
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, user_email);
			ps.setString(2, user_password);
			rs = ps.executeQuery();
			if(rs.next()) {
				mdto = getMemberBean(rs);
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
		
		return mdto;
	}
	
	public String findPw(String user_email, String user_name) {
		String passwd = null;
		String sql = "select password from MEMBER_INFO where email =? and upper(user_name)=upper(?)";
		
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, user_email);
			ps.setString(2, user_name);
			rs = ps.executeQuery();
			if(rs.next()) {
				passwd = rs.getString("password");
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
		
		return passwd;
	}
	
	public Member_Info_DTO getMemberBean(ResultSet rs) throws SQLException {
		Member_Info_DTO mdto = new Member_Info_DTO();
		
		mdto.setMember_key(rs.getInt("member_key"));
		mdto.setEmail(rs.getString("email"));
		mdto.setPassword(rs.getString("password"));
		mdto.setUser_name(rs.getString("user_name"));
		mdto.setPhone_number(rs.getString("phone_number"));
		mdto.setGender(rs.getString("gender"));
		mdto.setLogin_type(rs.getString("login_type"));
		mdto.setBan(rs.getString("ban"));
		
		return mdto;
	}
	
	public boolean duplicateCheckEmail(String email) {
		boolean flag = false;
		String sql = "select * from member_info where email = ? and LOGIN_TYPE is null";
		try {
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
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
	
}
