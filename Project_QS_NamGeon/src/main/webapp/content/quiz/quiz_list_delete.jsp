<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		request.setCharacterEncoding("UTF-8");	
	%>
	<jsp:useBean id="content_quiz" class="QS.CONTENT.Content_Quiz_bean" scope="session"/>
	<%
		
		String number = request.getParameter("number");
		String content_key = request.getParameter("content_key");
	    
	    if(content_key!=null){
		    content_quiz.deleteQuiz_List(Integer.parseInt(number));
		    response.sendRedirect("quiz_update.jsp?content_key="+multi.getParameter("content_key"));
	    }else{
		    content_quiz.deleteQuiz_List(Integer.parseInt(number));
		    response.sendRedirect("quiz_create.jsp?save=save");
	    }
		
	%>