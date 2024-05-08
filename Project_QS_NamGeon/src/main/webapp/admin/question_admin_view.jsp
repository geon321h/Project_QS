<%@page import="QS.CONTENT.QUESTIONS.questions_DTO"%>
<%@page import="QS.CONTENT.QUESTIONS.questions_DAO"%>
<%@page import="QS.MEMBER.Member_Info_DTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@page import="QS.CONTENT.Content_List_DTO"%>
<%@page import="QS.CONTENT.Content_List_DAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="header.jsp"/>
    <div class="container" id="content">
        <div class="m-auto content" >
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
		
		<script type="text/javascript">
		
			function reply_insert() {
				if($('textarea[name="que_content"]').val()==""){
			        $('textarea[name="que_content"]').focus();
			        alert('답변을 입력해주세요.');
			        return false;
			    }
			}
			function reply_update() {
				if($('textarea[name="que_content"]').val()==""){
			        $('textarea[name="que_content"]').focus();
			        alert('답변을 입력해주세요.');
			        return false;
			    }
			}
		
		</script>

			<table class="questions_add_table">
				<tr>
					<th style="width: 20%;">작성자명</th>
					<td style="width: 30%;"><%=m_dto.getUser_name()%>(<%=member%>)</td>
					<th style="width: 20%;">문의 유형</th>
					<td style="width: 30%;">
						<%=qu_dto.getQue_type() %>
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
					<td colspan="3" class="input_td text-start ps-3" >
						<%=qu_dto.getQue_title() %>
					</td>
				</tr>
				<tr>
					<th>문의내용</th>
					<td colspan="3" class="input_td text-start ps-3">
						<%=qu_dto.getQue_content() %>
					</td>
				</tr>
			</table> 
			<%
			if(qu_dto.getReply_key()>0){
				%>
				<form action="question_admin_update_Proc.jsp?pageNum=<%=pageNum %>&queType=<%=queType %>" method="post" class="questions_form">
				<%
			}else if(qu_dto.getReply_key()==0){
				%>
				<form action="question_admin_insert_Proc.jsp?pageNum=<%=pageNum %>&queType=<%=queType %>" method="post" class="questions_form">
				<%
			}
			%>			
				<input type="hidden" name="member_key" value="<%=member%>">
				<input type="hidden" name="reply_key" value="<%=question%>">
				<input type="hidden" name="que_title" value="<%=qu_dto.getQue_title()%>">
				<table class="reply_table">
					<tr>
						<th style="width: 20%;">답변</th>
						<td style="width: 80%;">
							<textarea name="que_content"  placeholder="답변 내용을 입력해주세요."><%
							if(qu_dto.getReply_key()>0){
								questions_DTO reply_dto = qu_dao.getQueReplyByKey(member,question);
								%><%=reply_dto.getQue_content()%><%
							}
							%></textarea>
						</td>
					</tr>
				</table>
				<div class="btn_area text-center">
					<input type="button" class="que_add_btn que_reset_btn" onclick="location.href='question_admin.jsp?type=list&pageNum=<%=pageNum %>&queType=<%=queType %>'" value="목록보기">
					<%
					if(qu_dto.getReply_key()>0){
						%>
						<input type="submit" value="답변수정" class="que_add_btn" onclick="return reply_update()">
						<%
					}else if(qu_dto.getReply_key()==0){
						%>
						<input type="submit" value="답변하기" class="que_add_btn" onclick="return reply_insert()">
						<%
					}
					%>
				</div>
			</form>               	
        </div>
    </div>
<jsp:include page="../include/footer.jsp"/>