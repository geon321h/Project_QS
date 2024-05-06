<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
        <%
    	
        request.setCharacterEncoding("UTF-8");
    	Member_Info_DAO mdao = Member_Info_DAO.getInstance();
    	
   		%>
   		
   		<jsp:useBean id="mdto" class="QS.MEMBER.Member_Info_DTO">
   			<jsp:setProperty name="mdto" property="*"/>
   		</jsp:useBean>
   		
   		<%

   			System.out.println(mdto.getMember_key());
   			System.out.println(mdto.getUser_name());
   			System.out.println(mdto.getPhone_number());
   			System.out.println(mdto.getPassword());
   		
   			int cnt = mdao.updateMember(mdto);
   			
   			if(cnt> 0){
   				out.print("프로필이 변경되었습니다");
   			}
   			
   		%>