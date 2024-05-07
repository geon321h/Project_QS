package QS.CONTENT.QUESTIONS;

import java.sql.Timestamp;

public class questions_DTO {

	private int question_key ;
	private int member_key;
	private String que_title ;
	private String que_content ;
	private String que_type ;
	private int reply_key ;
	private Timestamp que_day ;
	private String user_name ;
	private int rank ;
	
	
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public int getQuestion_key() {
		return question_key;
	}
	public void setQuestion_key(int question_key) {
		this.question_key = question_key;
	}
	public int getMember_key() {
		return member_key;
	}
	public void setMember_key(int member_key) {
		this.member_key = member_key;
	}
	public String getQue_title() {
		return que_title;
	}
	public void setQue_title(String que_title) {
		this.que_title = que_title;
	}
	public String getQue_content() {
		return que_content;
	}
	public void setQue_content(String que_content) {
		this.que_content = que_content;
	}
	public String getQue_type() {
		return que_type;
	}
	public void setQue_type(String que_type) {
		this.que_type = que_type;
	}
	public int getReply_key() {
		return reply_key;
	}
	public void setReply_key(int reply_key) {
		this.reply_key = reply_key;
	}
	public Timestamp getQue_day() {
		return que_day;
	}
	public void setQue_day(Timestamp que_day) {
		this.que_day = que_day;
	}
	
	
}
