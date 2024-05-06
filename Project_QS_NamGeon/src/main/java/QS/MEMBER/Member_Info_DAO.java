package QS.MEMBER;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
	
	public ArrayList<Member_Info_DTO> getAllMember() {
		String sql = "select * from member_info order by member_key asc";
		ArrayList<Member_Info_DTO> lists = new ArrayList<>();
		Member_Info_DTO mdto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				mdto = getMemberBean(rs);
				lists.add(mdto);
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
	
	public Member_Info_DTO getMemberByKey(String key) {
		String sql = "select * from member_info where member_key = ?";
		Member_Info_DTO mdto = null;
		try {
			
			ps = conn.prepareStatement(sql);
			int member_key = Integer.parseInt(key);
			ps.setInt(1, member_key);
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
				+ "VALUES(MEMBER_SEQ.NEXTVAL,?,?,?,?,?,?)";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mdto.getEmail());
			if(mdto.getPassword() == null) {
				ps.setString(2, mdto.getLogin_type());
			}else {
				ps.setString(2, mdto.getPassword());
			}
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

	public int updateMember(Member_Info_DTO mdto) {
		int cnt=-1;
			
		String sql = "update MEMBER_INFO set user_name=? ,phone_number=? ,password=? "
				+ " where member_key = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mdto.getUser_name());
			ps.setString(2, mdto.getPhone_number());
			ps.setString(3, mdto.getPassword());
			ps.setInt(4, mdto.getMember_key());
			
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
	
	public int deleteMember(Member_Info_DTO mdto) {
		int cnt=-1;
			
		String sql = "delete MEMBER_INFO where member_key = ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mdto.getMember_key());
			
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
	
	public int banMember(String[] rowcheckArr, String ban) {
		int cnt = -1;
		String sql = "update member_info set ban = ? where member_key=? ";
		for(int i=1;i<rowcheckArr.length;i++) {
			sql += " or member_key=?";
		}
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, ban);
			for(int i=0;i<rowcheckArr.length;i++) {
				int row = Integer.parseInt(rowcheckArr[i]);
				ps.setInt(i+2, row);
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
	
	
}
