package QS.CONTENT;

import java.sql.Timestamp;

public class comment_DTO {

	private int comment_key;
	private int member_key;
	private int content_key ;
	private String comment_text ;
	private Timestamp comment_day;
	private String user_name ;
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getComment_key() {
		return comment_key;
	}
	public void setComment_key(int comment_key) {
		this.comment_key = comment_key;
	}
	public int getMember_key() {
		return member_key;
	}
	public void setMember_key(int member_key) {
		this.member_key = member_key;
	}
	public int getContent_key() {
		return content_key;
	}
	public void setContent_key(int content_key) {
		this.content_key = content_key;
	}
	public String getComment_text() {
		return comment_text;
	}
	public void setComment_text(String comment_text) {
		this.comment_text = comment_text;
	}
	public Timestamp getComment_day() {
		return comment_day;
	}
	public void setComment_day(Timestamp comment_day) {
		this.comment_day = comment_day;
	}
	
	
	
}
