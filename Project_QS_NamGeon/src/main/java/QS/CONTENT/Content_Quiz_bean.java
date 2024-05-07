package QS.CONTENT;

import java.util.ArrayList;

import com.oreilly.servlet.MultipartRequest;

public class Content_Quiz_bean {

	private Content_List_DTO cl_dto;
	private ArrayList<Quiz_List_DTO> quiz_list;
	
	public Content_Quiz_bean() {

		cl_dto = new Content_List_DTO();
		quiz_list = new ArrayList<>();
	
	}
	
	public void saveContentData(MultipartRequest multi) {

		cl_dto.setCreate_user(Integer.parseInt(multi.getParameter("member_key")));
		cl_dto.setTitle(multi.getParameter("title"));
		cl_dto.setExplanation(multi.getParameter("explanation"));
		System.out.println(multi.getOriginalFileName("thumbnail"));
		if(multi.getOriginalFileName("thumbnail")!=null){
			cl_dto.setThumbnail(multi.getOriginalFileName("thumbnail"));
		}
		if(multi.getParameter("content_public")==null){
			cl_dto.setContent_public("N");
		}else {
			cl_dto.setContent_public("Y");
		}
		cl_dto.setContent_type("QUIZ");
		
	}
	
	public void saveQuizData(MultipartRequest multi) {
		Quiz_List_DTO q_dto = new Quiz_List_DTO();
		q_dto.setQuestion(multi.getParameter("question"));
		
	    String[] exampleArr =  multi.getParameterValues("example");
	    String example = "";
	    for(String str : exampleArr){
		    example += str+" ";
	    }
		if(!example.trim().equals("")){
			q_dto.setExample(example.trim());
		}else {
			//System.out.println("example비어있음");
		}
		
		if(multi.getOriginalFileName("image")!=null){
			q_dto.setImage(multi.getOriginalFileName("image"));
		}
		q_dto.setAnswer(multi.getParameter("answer"));
		q_dto.setQuiz_type(Integer.parseInt(multi.getParameter("type")));
		quiz_list.add(q_dto);
	}
	
	public void updateQuizData(MultipartRequest multi,int number) {
		Quiz_List_DTO q_dto = quiz_list.get(number);
		q_dto.setQuestion(multi.getParameter("question"));
		
		String[] exampleArr =  multi.getParameterValues("example");
		String example = "";
		for(String str : exampleArr){
			example += str+" ";
		}
		
		if(!example.trim().equals("")){
			q_dto.setExample(example.trim());
		}else if(multi.getOriginalFileName("image")!=null){
			q_dto.setImage(multi.getOriginalFileName("image"));
		}
		q_dto.setAnswer(multi.getParameter("answer"));
		q_dto.setQuiz_type(Integer.parseInt(multi.getParameter("type")));
		
		if(q_dto.getQuiz_type()==1) {
			q_dto.setImage(null);
			q_dto.setExample(null);
		}else if(q_dto.getQuiz_type()==2) {
			q_dto.setExample(null);
		}else if(q_dto.getQuiz_type()==3) {
			q_dto.setImage(null);
		}
		
		quiz_list.set(number,q_dto);
	}
	
	public void resetSaveData() {
		cl_dto = new Content_List_DTO();
		quiz_list.clear();
	}
	
	public void deleteQuiz_List(int number) {
		quiz_list.remove(number);
	}
	
	public Content_List_DTO getCL_DTO() {
		return cl_dto;
	}
	
	public ArrayList<Quiz_List_DTO> getQuiz_List() {
		return quiz_list;
	}
	
	public void settingContent(Content_List_DTO my_cl ,ArrayList<Quiz_List_DTO> my_lists) {
		cl_dto = my_cl;
		quiz_list = my_lists;
	}
	
}
