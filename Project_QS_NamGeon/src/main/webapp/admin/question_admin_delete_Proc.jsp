<%@page import="QS.CONTENT.QUESTIONS.questions_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
   	
    request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	String queType = request.getParameter("queType");
   	
 	%>
 	
 	<jsp:useBean id="qu_dto" class="QS.CONTENT.QUESTIONS.questions_DTO">
   			<jsp:setProperty name="qu_dto" property="*"/>
  	</jsp:useBean>
  	
  	<%
	
  	questions_DAO qu_dao = questions_DAO.getInstance();
  	int cnt = qu_dao.deleteQuestion(qu_dto);
  	
  	if(cnt>0){
  		%>
  		<script type="text/javascript">
			location.href ="question_admin.jsp?type=list&pageNum=<%=pageNum%>&queType=<%=queType%>";
		</script>
	<%
  	}else{
  		%>
  		<script type="text/javascript">
  			alert('삭제실패');
  			location.href ="question_admin.jsp?type=list&pageNum=<%=pageNum%>&queType=<%=queType%>";
		</script>
  		<%
  	}
  	
  	
  	%>