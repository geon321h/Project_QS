<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		request.setCharacterEncoding("UTF-8");	
	%>
	<jsp:useBean id="content_quiz" class="QS.CONTENT.Content_Quiz_bean" scope="session"/>
	<%
		
		String number = request.getParameter("number");
	    
	    content_quiz.deleteQuiz_List(Integer.parseInt(number));
	    response.sendRedirect("quiz_create.jsp?save=save");
	
	%>