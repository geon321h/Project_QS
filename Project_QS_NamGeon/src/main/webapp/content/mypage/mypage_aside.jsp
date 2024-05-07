<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
    String sort = request.getParameter("sort");
    String type = request.getParameter("type");
    if(sort==null){
		sort = "";        	
    }
    if(type==null){
    	type = "";        	
    }
    %>
    
<aside id="mypage_nav" class="col-12 col-lg-2">
    <div class="mypage_nav_area">
        <h1 class="mt-4 py-2">
            <i class="bi bi-person-fill pe-3"></i><a class="menu" href="mypage_profile.jsp">내 정보</a>
        </h1>
        <hr>
        <h1 class="mt-4 pt-2">
            <i class="bi bi-patch-question-fill pe-3"></i><a href="mypage_quiz.jsp?sort=my">퀴즈</a>
        </h1>
        <ul class="pb-2">
            <li><a href="mypage_quiz.jsp?sort=my" <%if(sort.equals("my")){%> style="color:#222" <%}%>>내 퀴즈</a></li>
            <li><a href="mypage_quiz.jsp?sort=like" <%if(sort.equals("like")){%> style="color:#222" <%}%>>좋아요한 퀴즈</a></li>
            <li><a href="mypage_quiz.jsp?sort=play" <%if(sort.equals("play")){%> style="color:#222" <%}%>>참여한 퀴즈</a></li>
        </ul>
        <hr >
        <h1 class="mt-4 pt-2">
            <i class="bi bi-send-fill pe-3"></i><a href="mypage_questions.jsp?type=add">문의하기</a>
        </h1>
        <ul class="pb-2">
            <li><a href="mypage_questions.jsp?type=list" <%if(type.equals("list")){%> style="color:#222" <%}%>>문의 내역</a></li>
            <li><a href="mypage_questions.jsp?type=add" <%if(type.equals("add")){%> style="color:#222" <%}%>>문의 하기</a></li>
        </ul>
    </div>
</aside>