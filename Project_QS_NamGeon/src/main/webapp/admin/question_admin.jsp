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
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String member_key = (String)session.getAttribute("member_key");
	    if(member_key==null){
	    	member_key = "1";        	
	    }
		Member_Info_DTO m_dto = m_dao.getMemberByKey(member_key);
		String queType = request.getParameter("queType");
		String type = request.getParameter("type");
	    if(type==null){
	    	type = "list";        	
	    }
	    if(queType==null){
	    	queType = "전체";        	
	    }
	    String[] q_option = {"전체","이용문의","계정문의","버그/오류 제보"};
	    
	    int pageSize = 10;
		String pageNum = request.getParameter("pageNum");

		if(pageNum == null){
			pageNum= "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1)*pageSize +1;
		int endRow = currentPage*pageSize;
		int count = 0;
		int number = 0;



	%>
			<div class="container text-center">
				<%
                if(type.equals("list")){
                	%>
					<select class="que_option" onchange="settingChange()">
						<%
						for(String option : q_option){
							%>
							<option value="<%=option %>" <%if(queType.equals(option)){%> selected <%}%>><%=option%></option>
							<%
						}
						%>
					</select>
					<table class="questions_table">
						<tr>
							<th style="width: 6%;">번호</th>
							<th style="width: 12%;">문의 유형</th>
							<th style="width: 32%;">문의 제목</th>
							<th style="width: 14%;">작성자</th>
							<th style="width: 20%;">문의 날짜</th>
							<th style="width: 10%;">답변여부</th>
							<th style="width: 6%;"></th>
						</tr>
						<%
						questions_DAO qu_dao = questions_DAO.getInstance();		
						ArrayList<questions_DTO> que_lists =null;
					    count =  0;
						if(queType.equals("전체")){
							count = qu_dao.getAllQueCount();
							que_lists = qu_dao.getAllQue(startRow,endRow);
						}else{
							count = qu_dao.getAllQueTypeCount(queType);
							que_lists = qu_dao.getAllQueByType(queType,startRow,endRow);
						}
						number =count - (currentPage-1)*pageSize;
						if(count>0){
 							for(questions_DTO qu_dto : que_lists){
							Member_Info_DTO m_dto_user = m_dao.getMemberByKey(String.valueOf(qu_dto.getMember_key()));
								%>
								<tr onclick="view_question(<%=qu_dto.getMember_key()%>,<%=qu_dto.getQuestion_key()%>,'<%=pageNum%>','<%=queType%>')">
									<td><%=qu_dto.getRank() %></td>
									<td><%=qu_dto.getQue_type()%></td>
									<td  class="text-start"><%=qu_dto.getQue_title()%></td>
									<td><%=m_dto_user.getUser_name() %>(<%=qu_dto.getMember_key()%>)</td>
									<td><%=sdf.format(qu_dto.getQue_day())%></td>
									<td>
									<%
									if(qu_dto.getReply_key()>0){
										%>
										답변완료
										<%
									}else if(qu_dto.getReply_key()==0){
										%>
										미진행									
										<%
									}
									%>
									</td>
									<td>
										<i class="bi bi-trash3-fill" onclick="delete_question(<%=qu_dto.getMember_key()%>,<%=qu_dto.getQuestion_key()%>,'<%=qu_dto.getQue_title()%>','<%=pageNum%>','<%=queType%>')"></i>
									</td>
								</tr>
								<%
 							}
						}else{
							%>
							<tr>
                            	<td colspan="7" id="msg_td">문의 내역이 없습니다.</td>
                        	</tr>
							<%
						}
						
						%>
					</table>              	
					<div class="page_area">
					<%
						// 페이지 설정
		            	if(count>0){
		            		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		            		int pageBlock = 10; // 보이는 페이지 총 갯수 설정
		            		
		            		int startPage = ((currentPage-1) / pageBlock*pageBlock) + 1;
		            		int endPage = startPage + pageBlock -1;
		            		
		            		if(endPage>pageCount){
		            			endPage = pageCount;	
		            		}
		            		if(startPage>pageBlock){
		            			%>
		            				<a href="question_admin.jsp?type=list&queType=<%=queType%>&pageNum=<%=startPage-pageBlock%>">[이전]</a>
		            			<%
		            		}
		            		
			            	for(int i=startPage;i<=endPage;i++){
		            			%>
		        					<a href="question_admin.jsp?type=list&queType=<%=queType%>&pageNum=<%=i%>" <%if(currentPage == i){%> style="color: #212529" <%} %>><%=i%></a>
		        				<%	
			            	}
		            		if(endPage<pageCount){
		            			%>
			        				<a href="question_admin.jsp?type=list&queType=<%=queType%>&pageNum=<%=startPage+pageBlock%>">[다음]</a>
			        			<%
		            		}
			            		
		            	}
					 %>	
					 </div>
                	<%
                }
                %>
			</div>
        </div>
    </div>
    <jsp:include page="../include/footer.jsp"/>