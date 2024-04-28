<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
	    request.setCharacterEncoding("UTF-8");
    	String[] rowcheckArr = request.getParameterValues("rowcheck");
    	String ban = request.getParameter("ban");
    	Member_Info_DAO mdao = Member_Info_DAO.getInstance();
	    
    	int cnt = mdao.banMember(rowcheckArr,ban);
    	
//     	for(String str : rowcheckArr){
// 	    	System.out.println(str);
//     	}
//     	System.out.println(type);

    	out.print(cnt);
    %>