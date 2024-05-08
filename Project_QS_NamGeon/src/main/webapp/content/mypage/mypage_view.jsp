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
		
		String[] q_option = {"이용문의","계정문의","버그/오류 제보"};
		
		String pageNum = request.getParameter("pageNum");
		String queType = request.getParameter("queType");
	%>
	<div class="container-fluid row" id="container">
		<jsp:include page="mypage_aside.jsp"/>
        <div id="content" class="col-12 col-lg-10">
			<div class="container">
				<h4 class="questions_title">문의 상세보기</h4>
				<hr>
				<form action="mypage_que_update_Proc.jsp?pageNum=<%=pageNum %>&queType=<%=queType %>" method="post" class="questions_form">
				<input type="hidden" name="member_key" value="<%=member%>">
				<input type="hidden" name="question_key" value="<%=question%>">
				<table class="questions_add_table">
					<tr>
						<th style="width: 20%;">작성자명</th>
						<td style="width: 30%;"><%=m_dto.getUser_name()%></td>
						<th style="width: 20%;">문의 유형</th>
						<td style="width: 30%;">
							<select class="que_option" name="que_type">
								<%
								for(String option : q_option){
									%>
									<option value="<%=option %>" <%if(qu_dto.getQue_type().equals(option)){%> selected <%} %>><%=option %></option>
									<%
								}
								%>
							</select>
						</td>
					</tr>
					<tr class="que_info">
							<th style="width: 20%;">상태</th>
							<td style="width: 30%;">
								<%
									if(qu_dto.getReply_key()>0){
										%>
										답변완료
										<%
									}else if(qu_dto.getReply_key()==0){
										%>
										접수중										
										<%
									}
									%>
							</td>
							<th style="width: 20%;">작성일</th>
							<td style="width: 30%;">
								<%=sdf.format(qu_dto.getQue_day())%>
							</td>
						</tr>
					<tr>
						<th>문의명</th>
						<td colspan="3" class="input_td">
							<input type="text" name="que_title" maxlength="20" placeholder="문의명을 입력해주세요." value="<%=qu_dto.getQue_title() %>">
						</td>
					</tr>
					<tr>
						<th>문의내용</th>
						<td colspan="3" class="input_td">
							<textarea name="que_content" maxlength="150" placeholder="문의내용을 입력해주세요."><%=qu_dto.getQue_content() %></textarea>
						</td>
					</tr>
				</table> 
				<div class="btn_area">
					<input type="button" value="삭제하기" class="que_add_btn que_reset_btn" onclick="delete_question(<%=member%>,<%=question%>,'<%=qu_dto.getQue_title()%>,'<%=pageNum%>','<%=queType%>'')">
					<input type="button" class="que_add_btn que_reset_btn" onclick="location.href='mypage_questions.jsp?type=list&pageNum=<%=pageNum %>&queType=<%=queType %>'" value="목록보기">
					<%
					if(qu_dto.getReply_key()>0){
						%>
						<input type="button" value="답변보기" class="que_add_btn" onclick="location.href='mypage_reply.jsp?member_key=<%=member%>&question_key=<%=question%>&pageNum=<%=pageNum%>&queType=<%=queType%>'">
						<%
					}else if(qu_dto.getReply_key()==0){
						%>
						<input type="submit" value="수정하기" class="que_add_btn" onclick="return que_check()">										
						<%
					}
					%>
				</div>
				</form>               	
			</div>
		</div>
    </div>
	
	<jsp:include page="../../include/footer.jsp"/>	