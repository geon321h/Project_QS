<%@page import="QS.CONTENT.comment_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	<%
		request.setCharacterEncoding("UTF-8");	
	%>
	
	<jsp:useBean id="c_dto" class="QS.CONTENT.comment_DTO">
		<jsp:setProperty name="c_dto" property="*"/>
	</jsp:useBean>
	
	<%
		String num = request.getParameter("num");
		comment_DAO c_dao = comment_DAO.getInstance();

		//System.out.println("c_dto.getContent_key():"+c_dto.getContent_key());
		//System.out.println("c_dto.getContent_key():"+c_dto.getMember_key());
		c_dao.insertComment(c_dto);
	
	%>
	<body>
		<form id="form_q" action="quiz_play.jsp" method="post" >
			<input type="hidden" name="content_key" value="<%=c_dto.getContent_key()%>">
	        <input type="hidden" name="num" value="<%=num%>">                            
		</form>
	</body>
	<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#form_q").submit();
		})
	</script>