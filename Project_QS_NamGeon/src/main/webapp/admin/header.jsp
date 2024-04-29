<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	request.setCharacterEncoding("UTF-8");
    	
    	String email = (String)session.getAttribute("email");
    	//System.out.println("user_name: "+user_name);
    	if(email == null){
    		email = "admin";    		
    	}
    	
    %>
    
    <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuestionS:Quiz and Survey</title>
    
    <!-- css 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
    crossorigin="anonymous"/>

    <!-- css 페이지 -->
    <link href="<%=request.getContextPath()%>/css/header_footer_style.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet" />

    <!-- 아이콘 부트스트랩 -->
    <link rel="stylesheet" 
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

    <!-- javascript 부트스트랩 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
    crossorigin="anonymous"></script>

    <!-- javascript admin -->
    <script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="<%=request.getContextPath()%>/script/admin.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3 " id="mainNav_admin">
    <div class="container px-0 ">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/admin/main.jsp">LOGO</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse " id="navbarResponsive">
            <ul class="navbar-nav ms-5 my-2 my-lg-0">
                <li class="nav-item mx-3"><a class="nav-link" href="<%=request.getContextPath()%>/admin/member_admin.jsp">멤버관리</a></li>
                <li class="nav-item mx-3"><a class="nav-link" href="#">퀴즈관리</a></li>
                <li class="nav-item mx-3"><a class="nav-link" href="#">설문조사 관리</a></li>
                <li class="nav-item mx-3"><a class="nav-link" href="#">문의 관리</a></li>
                <li class="nav-item mx-3"><a class="nav-link" href="<%=request.getContextPath()%>/main.jsp">사용자 홈</a></li>
            </ul>
            <ul class="nav nav-pills ms-auto">
	                <li class="nav-item"><a href="<%=request.getContextPath()%>/member/logout.jsp" class="nav-link">로그아웃</a></li>
              </ul>
        </div>
    </div>
</nav>

    