<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	request.setCharacterEncoding("UTF-8");
    	
    	String user_name = (String)session.getAttribute("user_name");
    	System.out.println("user_name: "+user_name);
    	
    	
    %>
    
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3 " id="mainNav">
    <div class="container px-0 ">
        <a class="navbar-brand" href="main.html">LOGO</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse " id="navbarResponsive">
            <ul class="navbar-nav ms-5 my-2 my-lg-0 ">
                <li class="nav-item"><a class="nav-link" href="#">퀴즈</a></li>
                <li class="nav-item"><a class="nav-link" href="#">설문조사</a></li>
                <li class="nav-item"><a class="nav-link" href="#">내 페이지</a></li>
            </ul>
            <ul class="nav nav-pills ms-auto">
                <li class="nav-item me-2"><a href="#" class="nav-link active" id="create_nav" aria-current="page">만들기</a></li>
                <%
                	if(user_name != null){
                		%>
			                <li class="nav-item"><a href="<%=request.getContextPath()%>/member/logout.jsp?url=<%=request.getRequestURI()%>" class="nav-link">로그아웃</a></li>
                		<%
                	}else{
                		%>
			                <li class="nav-item"><a href="<%=request.getContextPath()%>/member/login.jsp?url=<%=request.getRequestURI()%>" class="nav-link">로그인</a></li>
                		<%
                	}
                %>
              </ul>
        </div>
    </div>
</nav>

    