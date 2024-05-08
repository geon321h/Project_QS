<%@page import="QS.CONTENT.QUESTIONS.questions_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
   	
    request.setCharacterEncoding("UTF-8");
   	
 	%>
 	
 	<jsp:useBean id="qu_dto" class="QS.CONTENT.QUESTIONS.questions_DTO">
   			<jsp:setProperty name="qu_dto" property="*"/>
  	</jsp:useBean>
  	
  	<%
  	
  	questions_DAO qu_dao = questions_DAO.getInstance();
  	int cnt = qu_dao.insertQuestion(qu_dto);
  	
  	if(cnt>0){
  		response.sendRedirect("mypage_questions.jsp?type=list");
  	}else{
  		%>
  		<script type="text/javascript">
  			alert('작성실패');
  			location.href = "mypage_questions.jsp?type=add";
		</script>
  		<%
  	}
  	
  	
  	%>
   		