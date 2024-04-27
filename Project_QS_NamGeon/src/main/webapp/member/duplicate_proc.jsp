<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	    <%
	    request.setCharacterEncoding("UTF-8");
    	String email = request.getParameter("user_email");
    	Member_Info_DAO mdao = Member_Info_DAO.getInstance();
	    
    	boolean flag = mdao.duplicateCheckEmail(email);
    	
    	String str ="";
    	if(flag){
    		str = "exist";
    	}else{
    		str = "not exist";
    	}
    	out.print(str);
    %>