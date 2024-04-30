package QS.CONTENT;

public class Content_List_DTO {

	private int content_key ;
	private String title;
	private String explanation ;
	private int create_user ;
	private String thumbnail ;
	private int content_count  ;
	private String content_public ;
	private String content_type;
	private String create_day  ;

	
	public int getContent_key() {
		return content_key;
	}
	public void setContent_key(int content_key) {
		this.content_key = content_key;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public int getCreate_user() {
		return create_user;
	}
	public void setCreate_user(int create_user) {
		this.create_user = create_user;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public int getContent_count() {
		return content_count;
	}
	public void setContent_count(int content_count) {
		this.content_count = content_count;
	}
	public String getContent_public() {
		return content_public;
	}
	public void setContent_public(String content_public) {
		this.content_public = content_public;
	}
	public String getContent_type() {
		return content_type;
	}
	public void setContent_type(String content_type) {
		this.content_type = content_type;
	}
	public String getCreate_day() {
		return create_day;
	}
	public void setCreate_day(String create_day) {
		this.create_day = create_day;
	}
	
}
