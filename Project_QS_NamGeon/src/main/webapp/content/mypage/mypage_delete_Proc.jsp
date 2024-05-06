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
   			int cnt = mdao.deleteMember(mdto);
   			
   			if(cnt> 0){
   				out.print("계정이 삭제되었습니다.");
   			}
   			
   		%>