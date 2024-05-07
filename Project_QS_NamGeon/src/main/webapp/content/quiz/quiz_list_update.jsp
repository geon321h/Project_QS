<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	<%
		request.setCharacterEncoding("UTF-8");	
	%>
	<jsp:useBean id="content_quiz" class="QS.CONTENT.Content_Quiz_bean" scope="session"/>
	<%
		
		String number = request.getParameter("number");
	    
		String configFolder = "";
		String saveFolder = "/assets/img";
	    int maxSize = 1024*1024*5;
	    String encoding = "UTF-8";
	    
	    configFolder = config.getServletContext().getRealPath(saveFolder);
	    System.out.println("configFolder:"+configFolder);
	    
	    MultipartRequest multi = 
	    		new MultipartRequest(request,configFolder,maxSize,encoding,new DefaultFileRenamePolicy());
	
	    if(multi.getParameter("content_key")!=null){
	    	content_quiz.updateQuizData(multi,Integer.parseInt(number));
		    response.sendRedirect("quiz_update.jsp?content_key="+multi.getParameter("content_key"));
	    }else{
		    content_quiz.updateQuizData(multi,Integer.parseInt(number));
		    response.sendRedirect("quiz_create.jsp?save=save");
	    }
	    
	%>