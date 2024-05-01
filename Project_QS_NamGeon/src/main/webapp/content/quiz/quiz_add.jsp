<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%
		request.setCharacterEncoding("UTF-8");	
	%>
	<jsp:useBean id="content_quiz" class="QS.CONTENT.Content_Quiz_bean" scope="session"/>
	<%
		String configFolder = "";
		String saveFolder = "/assets/img";
	    int maxSize = 1024*1024*5;
	    String encoding = "UTF-8";
	    
	    configFolder = config.getServletContext().getRealPath(saveFolder);
	    System.out.println("configFolder:"+configFolder);
	    
	    MultipartRequest multi = 
	    		new MultipartRequest(request,configFolder,maxSize,encoding,new DefaultFileRenamePolicy());
	    String[] exampleArr =  multi.getParameterValues("example");
	    String example = "";
	    for(String str : exampleArr){
		    example += str+" ";
	    }
	    System.out.println("question:"+multi.getParameter("question"));
	    System.out.println("example:"+example);	
	    System.out.println("image:"+multi.getOriginalFileName("image"));
	    System.out.println("answer:"+multi.getParameter("answer"));
	    
	    content_quiz.saveQuizData(multi);
	    response.sendRedirect("quiz_create.jsp?save=save");
	
	%>