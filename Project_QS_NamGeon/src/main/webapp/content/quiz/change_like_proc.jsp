<%@page import="QS.CONTENT.Play_Record_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	
	request.setCharacterEncoding("UTF-8");
	Play_Record_DAO pr_dao = Play_Record_DAO.getInstance();
	int content_key = Integer.parseInt(request.getParameter("content_key"));
	int member_key = Integer.parseInt(request.getParameter("member_key"));
	String change_type = request.getParameter("change_type");
	
	pr_dao.changeLike_Content(content_key,member_key,change_type);
	
	%>