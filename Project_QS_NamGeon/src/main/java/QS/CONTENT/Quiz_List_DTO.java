package QS.CONTENT;

public class Quiz_List_DTO {

	private int quiz_key  ;
	private int content_key ;
	private String question;
	private String image;
	private String example;
	private String answer ;
	private int quiz_type;
	
	public int getQuiz_type() {
		return quiz_type;
	}
	public void setQuiz_type(int quiz_type) {
		this.quiz_type = quiz_type;
	}
	
	public int getQuiz_key() {
		return quiz_key;
	}
	public void setQuiz_key(int quiz_key) {
		this.quiz_key = quiz_key;
	}
	public int getContent_key() {
		return content_key;
	}
	public void setContent_key(int content_key) {
		this.content_key = content_key;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getExample() {
		return example;
	}
	public void setExample(String example) {
		this.example = example;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
}
