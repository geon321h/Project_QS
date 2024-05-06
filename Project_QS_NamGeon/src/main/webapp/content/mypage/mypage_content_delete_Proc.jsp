<%@page import="QS.CONTENT.Content_List_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
    	
        request.setCharacterEncoding("UTF-8");
		Content_List_DAO cl_dao = Content_List_DAO.getInstance();
    	String content_key = request.getParameter("content_key");

		int cnt = cl_dao.deleteContent(Integer.parseInt(content_key));
		
		if(cnt> 0){
			out.print("컨텐츠가 삭제되었습니다.");
		}
		
	%>