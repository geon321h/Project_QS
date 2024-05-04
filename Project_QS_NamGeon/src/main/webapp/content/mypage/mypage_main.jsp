<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<link href="<%=request.getContextPath()%>/css/mypage.css" rel="stylesheet" />
	<jsp:include page="../../include/header.jsp"/>
	<%
		String member_key = (String)session.getAttribute("member_key");
	
	%>
	<div class="container" id="container">
        <div id="content">
        
		</div>
    </div>
	
	<jsp:include page="../../include/footer.jsp"/>