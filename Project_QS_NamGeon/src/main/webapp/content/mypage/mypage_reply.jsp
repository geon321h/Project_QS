<%@page import="java.text.SimpleDateFormat"%>
<%@page import="QS.CONTENT.QUESTIONS.questions_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="QS.CONTENT.QUESTIONS.questions_DAO"%>
<%@page import="QS.MEMBER.Member_Info_DTO"%>
<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<jsp:include page="../../include/header.jsp"/>
	<link href="<%=request.getContextPath()%>/css/mypage.css" rel="stylesheet" />
	<script src="<%=request.getContextPath()%>/script/mypage.js"></script>
	<%
		Member_Info_DAO m_dao = Member_Info_DAO.getInstance();
		questions_DAO qu_dao = questions_DAO.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String member = request.getParameter("member_key");
		String question = request.getParameter("question_key");
		Member_Info_DTO m_dto = m_dao.getMemberByKey(member);
		questions_DTO qu_dto = qu_dao.getQueByKey(member, question);
		questions_DTO qu_dto_reply = qu_dao.getQueReplyByKey(member, question);
		
		String[] q_option = {"이용문의","계정문의","버그/오류 제보"};
		
		String pageNum = request.getParameter("pageNum");
		String queType = request.getParameter("queType");
		
	%>
	<div class="container-fluid row" id="container">
		<jsp:include page="mypage_aside.jsp"/>
        <div id="content" class="col-12 col-lg-10">
			<div class="container">
				<h4 class="questions_title">문의 답변보기</h4>
				<hr>
				<form  class="questions_form">
				<table class="questions_add_table">
					<tr>
						<th style="width: 20%;">답변 작성일</th>
						<td style="width: 30%;"><%=sdf.format(qu_dto_reply.getQue_day())%></td>
						<th style="width: 20%;">문의 유형</th>
						<td style="width: 30%;">
								<%=qu_dto.getQue_type() %>
						</td>
					</tr>					
					<tr>
						<th>문의명</th>
						<td colspan="3" class="input_td text-start ps-3">
							<%=qu_dto.getQue_title() %>
						</td>
					</tr>
					<tr>
						<th>답변내용</th>
						<td colspan="3" class="input_td text-start ps-3 pt-3" style="height: 250px;vertical-align:top;">
							<%=qu_dto_reply.getQue_content() %>
						</td>
					</tr>
				</table> 
				<div class="btn_area">
					<input type="button" class="que_add_btn" onclick="location.href='mypage_questions.jsp?type=list&pageNum=<%=pageNum%>&queType=<%=queType%>'" value="목록보기">
				</div>
				</form>               	
			</div>
		</div>
    </div>
	
	<jsp:include page="../../include/footer.jsp"/>	