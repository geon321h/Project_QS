<%@page import="QS.MEMBER.Member_Info_DTO"%>
<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	request.setCharacterEncoding("UTF-8");
    	Member_Info_DAO mdao = Member_Info_DAO.getInstance();
    	Member_Info_DTO mdto = null;
    
    	String url = request.getParameter("url");
//      	System.out.println("url: "+url);
    	String access_token = request.getParameter("access_token");
// 	    System.out.println("access_token: "+access_token);
    	String msg = null;
    	
    	if(access_token != null){
	    	String id = request.getParameter("id");
	    	String user_name = request.getParameter("nickname");
	    	String gender = request.getParameter("gender");
	    	String mobile = request.getParameter("mobile");
	    	String login_type = request.getParameter("type");
	    	if(user_name.equals("undefined")){
	    		user_name = request.getParameter("name");
	    	}
	    	
// 	    	System.out.println("id: "+id);
// 	    	System.out.println("nickname: "+nickname);
// 	    	System.out.println("gender: "+gender);
// 	    	System.out.println("mobile: "+mobile);

	    	mdto = mdao.snsIdCheck(id);
	    	if(mdto == null){ // sns아이디 등록안됨
	    		mdto = new Member_Info_DTO();
	    		mdto.setEmail(id);
	    		mdto.setUser_name(user_name);
	    		mdto.setGender(gender);
	    		mdto.setLogin_type(login_type);
		    	if(!mobile.equals("undefined")){
		    		mdto.setPhone_number(mobile);
		    	}
	    		int cnt = mdao.insertMember(mdto);
	    		if(cnt <0){
	    			url = "login.jsp?url="+url;
	    		}else{
	    			mdto = mdao.snsIdCheck(id);
	    		}
	    	}
	    	
    	}else{
	    	String user_email = request.getParameter("user_email");
	    	String user_password = request.getParameter("user_password");
// 	    	System.out.println("user_email: "+user_email);
// 	    	System.out.println("user_password: "+user_password);

			mdto = mdao.login(user_email, user_password);

    	}
    	if(mdto == null){
    		url = null;
	    	out.print("아이디 혹은 비밀번호가 틀립니다.");
    	}else{
	    	if(mdto.getBan().equals("Y")){
	    		url = "login.jsp?url="+url;
	    		msg = "활동정지된 아이디입니다.";
	    	}else if(mdto.getBan().equals("N")){
	        	session.setAttribute("member_key", mdto.getMember_key());
	        	session.setAttribute("email", mdto.getEmail());
	        	session.setAttribute("user_name", mdto.getUser_name());
	        	// System.out.println("로그인");
				
				if (mdto.getEmail().equals("admin")) {
					url = request.getContextPath()+"/admin/main.jsp";
				}
	    	}
    	}
    	
    %>
    
     <Script>
     <%
     	if(msg != null){
     		%>
			    alert("<%=msg%>");
     		<%
     	}
	  	if(url != null){
	 		%>
	 			location.href="<%=url%>";
	 		<%
	 	}
     %>
	</Script>
    
    
    
    