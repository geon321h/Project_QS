<%@page import="QS.CONTENT.Content_List_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	    <%
	    request.setCharacterEncoding("UTF-8");
    	String[] rowcheckArr = request.getParameterValues("rowcheck");
    	Content_List_DAO cl_dao = Content_List_DAO.getInstance();
	    
    	int cnt = cl_dao.delete_content_quiz(rowcheckArr);
    	
    	out.print(cnt);
    	%>