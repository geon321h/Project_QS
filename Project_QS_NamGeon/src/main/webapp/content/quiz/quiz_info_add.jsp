<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%
		request.setCharacterEncoding("UTF-8");	
	%>
	<jsp:useBean id="content_quiz" class="QS.CONTENT.Content_Quiz_bean" scope="session"/>
	<%
		System.out.println("이동");
		String configFolder = "";
		String saveFolder = "/assets/img";
	    int maxSize = 1024*1024*5;
	    String encoding = "UTF-8";
	    
	    configFolder = config.getServletContext().getRealPath(saveFolder);
	    System.out.println("configFolder:"+configFolder);
	    
	    /* String requestFolder = request.getContextPath()+"/"+saveFolder;
	    String orgname = multi.getOriginalFileName("thumbnail");
	    String fullPath = requestFolder+"\\"+orgname;
	    System.out.println("requestFolder:"+requestFolder);
	    System.out.println("fullPath:"+fullPath); */
	    
	    MultipartRequest multi = 
	    		new MultipartRequest(request,configFolder,maxSize,encoding,new DefaultFileRenamePolicy());
	    
	    System.out.println("title:"+multi.getParameter("title"));
	    System.out.println("explanation:"+multi.getParameter("explanation"));
	    System.out.println("thumbnail:"+multi.getOriginalFileName("thumbnail"));
	    System.out.println("content_public:"+multi.getParameter("content_public"));
	    
	    //content_quiz.saveContentData(multi);
	    response.sendRedirect("quiz_create.jsp?save=save");
	
	%>
	