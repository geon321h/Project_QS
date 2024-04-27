<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		register_Proc.jsp
        <%
    	
        request.setCharacterEncoding("UTF-8");
    	Member_Info_DAO mdao = Member_Info_DAO.getInstance();
    	String url = request.getParameter("url");
    	
   		%>
   		
   		<jsp:useBean id="mdto" class="QS.MEMBER.Member_Info_DTO">
   			<jsp:setProperty name="mdto" property="*"/>
   		</jsp:useBean>
   		
   		<%
   		
//    			System.out.println(mdto.getEmail());
//    			System.out.println(mdto.getUser_name());
//    			System.out.println(mdto.getPhone_number());
//    			System.out.println(mdto.getGender());
//    			System.out.println(mdto.getPassword());
   		
   			int cnt = mdao.insertMember(mdto);
   			
   			String msg =null;
   			
   			if(cnt != -1){
   				msg = "회원가입에 성공하셨습니다!";
   				url = "login.jsp?url="+url;
   			}else{
   				msg = "추가 실패";
   				url = "register.jsp?url="+url;
   			}
   			
   		%>
   		
 	<Script>
	    alert("<%=msg%>");
	    location.href="<%=url%>";
	</Script>