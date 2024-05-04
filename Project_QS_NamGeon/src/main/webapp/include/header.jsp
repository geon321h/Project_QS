<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	request.setCharacterEncoding("UTF-8");
    	
    	String email = (String)session.getAttribute("email");
    	String member_key = (String)session.getAttribute("member_key");
    	//System.out.println("member_key: "+member_key);
    	
    	
    %>
    <!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0" >
    <title>QuestionS</title>
	
	<!--css 부트스트랩-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
    rel="stylesheet" 
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!--javascript 부트스트랩-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
    crossorigin="anonymous"></script>

    <!--아이콘 부트스트랩-->
    <link rel="stylesheet" 
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
     
    <!-- css 페이지 -->
    <script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <link href="<%=request.getContextPath()%>/css/header_footer_style.css" rel="stylesheet" />
    <%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/bootstrap-5.3.3-dist/css/bootstrap.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-5.3.3-dist//js/bootstrap.js"></script>
 --%>
    <!-- 추가 개인 javascript -->
    <script type="text/javascript">
        /*  팝업이전에 로그인여부 확인  */
        function login_check() {
            if("<%=email%>"=="null"){
                alert("로그인이 필요한 컨텐츠입니다.");
                location.href = "<%=request.getContextPath()%>/member/login.jsp?url=<%=request.getRequestURI()%>";
            }else{
                popOpen();
            }
        }

        /* 팝업을 통한 페이지 이동 */
        function create_page_move(page){
            location.href = "<%=request.getContextPath()%>/content/"+page+"/"+page+"_create.jsp";
        }
        
        function limit_msg() {
			alert("추후 추가될 컨텐츠 입니다. 조금만 기다려주세요!");
		}
        
    </script>

</head>
<body>
    
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
    <div class="container px-0">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/main.jsp">LOGO</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse " id="navbarResponsive">
            <ul class="navbar-nav ms-5 my-2 my-lg-0 ">
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/content/quiz/quiz_main.jsp">퀴즈</a></li>
                <!-- <li class="nav-item"><a class="nav-link" href="#">설문조사</a></li> -->
                <%
                if(email != null){
                	%>
	                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/content/mypage/mypage_main.jsp">내 페이지</a></li>
                	<%
                }else {
                	%>
	                <li class="nav-item"><a class="nav-link" href="javascript:login_check();">내 페이지</a></li>
                	<%
                }
                %>
                <%
                if(email != null){
	                if(email.equals("admin")){
	                	%>
		                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/main.jsp">관리자 홈</a></li>
	                	<%
	                }
                }
                %>
            </ul>
            <ul class="nav nav-pills ms-auto">
                <li class="nav-item me-2 .create_nav"><a href="javascript:login_check();" class="nav-link active" id="create_nav" onmouseover="vibration(this)" onmouseleave="vibration_off(this)" aria-current="page">만들기</a></li>
                <%
                	if(email != null){
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

<div class="modal_bg" onClick="javascript:popClose();"></div>
<div class="modal_wrap p-3">
    <div>
        <i class="modal_close bi bi-x" onClick="javascript:popClose();" ></i>
    </div>
    <div class="content_type_area pt-2 pb-4 px-3 text-center">
        <button class="btn mx-2" id="quiz_create_btn" onclick="create_page_move('quiz')">
            <p class="pt-3"><img src="<%=request.getContextPath()%>/assets/icon/quiz_icon.png"></img></p>
            <p class="pt-2">퀴즈</pc>
        </button>
        <button class="btn mx-2" id="survey_create_btn" onclick="limit_msg()">
            <p class="pt-3"><i class="bi bi-file-text"></i></p>
            <p class="pt-2">설문조사</p>
        </button>
    </div>
</div>

    