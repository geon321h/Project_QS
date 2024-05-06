package QS.CONTENT;

import java.sql.Timestamp;

public class Play_Record_DTO {

	//Like_Content 와 공유 //
	private int member_key;
	private int content_key ;
	
	//play_record 전용//
	private int score;
	private Timestamp play_day;
	private int rank;
	private String user_name;
	
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
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
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public Timestamp getPlay_day() {
		return play_day;
	}
	public void setPlay_day(Timestamp play_day) {
		this.play_day = play_day;
	}
	
	
	
}
