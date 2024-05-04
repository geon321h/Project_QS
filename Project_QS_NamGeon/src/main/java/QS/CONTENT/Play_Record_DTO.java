package QS.CONTENT;

public class Play_Record_DTO {

	//Like_Content 와 공유 //
	private int member_key;
	private int content_key ;
	
	//play_record 전용//
	private int score;
	private String play_day;
	
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
	public String getPlay_day() {
		return play_day;
	}
	public void setPlay_day(String play_day) {
		this.play_day = play_day;
	}
	
	
	
}
