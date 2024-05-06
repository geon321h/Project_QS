<%@page import="QS.CONTENT.comment_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

     <%
		request.setCharacterEncoding("UTF-8");
     
     	String content_key = request.getParameter("content_key");
     	String comment_key = request.getParameter("comment_key");
     	String num = request.getParameter("num");
     	comment_DAO c_dao = comment_DAO.getInstance();
     	c_dao.deleteComment(Integer.parseInt(comment_key));
	%>
	
	<body>
		<form id="form_q" action="quiz_play.jsp" method="post" >
			<input type="hidden" name="content_key" value="<%=content_key%>">
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