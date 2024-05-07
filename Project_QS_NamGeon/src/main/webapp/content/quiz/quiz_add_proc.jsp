<%@page import="QS.CONTENT.Quiz_List_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="QS.CONTENT.Content_List_DTO"%>
<%@page import="QS.CONTENT.Quiz_List_DAO"%>
<%@page import="QS.CONTENT.Content_List_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
		request.setCharacterEncoding("UTF-8");	
	%>
	<jsp:useBean id="content_quiz" class="QS.CONTENT.Content_Quiz_bean" scope="session"/>
	<%
	String content_key_my = request.getParameter("content_key");
	
	Content_List_DAO cl_dao = Content_List_DAO.getInstance();
	Quiz_List_DAO ql_dao = Quiz_List_DAO.getInstance();
	
	Content_List_DTO cl_dto = content_quiz.getCL_DTO();
	ArrayList<Quiz_List_DTO> quiz_lists = content_quiz.getQuiz_List();
	cl_dto.setContent_count(quiz_lists.size());
	
	if(content_key_my != null){
		int cnt_content = cl_dao.updateContent(cl_dto);
		
		if(cnt_content >0){
			int cnt = ql_dao.updateQuiz(quiz_lists,Integer.parseInt(content_key_my));
			
			if(cnt>0){
				content_quiz.resetSaveData();
				response.sendRedirect(request.getContextPath()+"/content/mypage/mypage_quiz.jsp?sort=my");
			}else{
				response.sendRedirect(request.getContextPath()+"/content/quiz/quiz_update.jsp?content_key="+content_key_my);
			}
			
		}else{
			System.out.println("컨텐츠 수정 실패");
		}
		
	}else{
		int content_key = cl_dao.insertContent(cl_dto);
		//System.out.println(content_key);
		
		if(content_key >0){
			//System.out.println("컨텐츠 등록 성공");
			int cnt = ql_dao.insertQuiz(quiz_lists,content_key);
			
			if(cnt>0){
				//System.out.println("cnt:"+ cnt);
				content_quiz.resetSaveData();
				response.sendRedirect(request.getContextPath()+"/main.jsp");
			}else{
				response.sendRedirect(request.getContextPath()+"/content/quiz/quiz_create.jsp?save=save");
			}
			
		}else{
			System.out.println("컨텐츠 등록 실패");
		}
	}
	
	%>