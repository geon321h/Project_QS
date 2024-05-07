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
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String member_key = (String)session.getAttribute("member_key");
	    if(member_key==null){
	    	member_key = "1";        	
	    }
		Member_Info_DTO m_dto = m_dao.getMemberByKey(member_key);
		String type = request.getParameter("type");
	    if(type==null){
	    	type = "list";        	
	    }

	%>
	<div class="container-fluid row" id="container">
		<jsp:include page="mypage_aside.jsp"/>
        <div id="content" class="col-12 col-lg-10">
			<div class="container">
				<%
                if(type.equals("list")){
                	%>
					<h4 class="questions_title">문의 내역</h4>  
					<select class="que_option">
						<option value="전체">전체</option>
						<option value="이용문의">이용문의</option>
						<option value="계정문의">계정문의</option>
						<option value="버그/오류 제보">버그/오류 제보</option>
					</select>
					<table class="questions_table">
						<tr>
							<th style="width: 8%;">번호</th>
							<th style="width: 16%;">문의 유형</th>
							<th style="width: 38%;">문의 제목</th>
							<th style="width: 20%;">문의 날짜</th>
							<th style="width: 10%;">상태</th>
							<th style="width: 8%;"></th>
						</tr>
						<%
						questions_DAO qu_dao = questions_DAO.getInstance();
						String queType = request.getParameter("queType");
							ArrayList<questions_DTO> que_lists =null;
						if(queType == null){
							que_lists = qu_dao.getAllMyQue(Integer.parseInt(member_key));
						}else if(queType.equals("use")){
							
						}else if(queType.equals("account")){
							
						}else if(queType.equals("report")){
							
						}
						
						if(que_lists.size()>0){
 							for(questions_DTO qu_dto : que_lists){
								%>
								<tr>
									<td><%=qu_dto.getRank() %></td>
									<td><%=qu_dto.getQue_type()%></td>
									<td><%=qu_dto.getQue_title()%></td>
									<td><%=sdf.format(qu_dto.getQue_day())%></td>
									<td>
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
									<td>
										<i class="bi bi-trash3-fill"></i>
									</td>
								</tr>
								<%
 							}
						}else{
							%>
							<tr>
                            	<td colspan="6" id="msg_td">문의 내역이 없습니다.</td>
                        	</tr>
							<%
						}
						
						%>
					</table>              	
					<button class="que_add_btn" onclick="location.href='mypage_questions.jsp?type=add'">문의 하기</button>
                	<%
                }else if(type.equals("add")){
                	%>
					<h4 class="questions_title">문의 하기</h4>                	
                	<%
                }
                %>
			</div>
		</div>
    </div>
	
	<jsp:include page="../../include/footer.jsp"/>	