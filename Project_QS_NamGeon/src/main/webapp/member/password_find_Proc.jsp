<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

        <%
    	
        request.setCharacterEncoding("UTF-8");
        Member_Info_DAO mdao = Member_Info_DAO.getInstance();
        
    	String user_email = request.getParameter("user_email");
    	String user_name = request.getParameter("user_name");
//     	System.out.println(user_email);
//     	System.out.println(user_name);
        String password = mdao.findPw(user_email,user_name);
        
        if(password == null){
        	out.print("X");
        }else{
        	out.print(password);
        }
    	
    	%>
