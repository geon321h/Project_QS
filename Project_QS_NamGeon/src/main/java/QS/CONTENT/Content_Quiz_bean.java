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
		cl_dto.setThumbnail(multi.getOriginalFileName("thumbnail"));
		if(multi.getParameter("content_public")==null){
			cl_dto.setContent_public("N");
		}else {
			cl_dto.setContent_public("Y");
		}
		cl_dto.setContent_type("QUIZ");
		
	}
	
	public void resetSaveData() {
		cl_dto = new Content_List_DTO();
		quiz_list.clear();
	}
	
	public Content_List_DTO getCL_DTO() {
		return cl_dto;
	}
	
	public ArrayList<Quiz_List_DTO> getQuiz_List() {
		return quiz_list;
	}
	
}
