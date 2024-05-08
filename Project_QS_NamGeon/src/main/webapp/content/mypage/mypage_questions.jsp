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
// 	    if(member_key==null){
// 	    	member_key = "1";        	
// 	    }
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
	<div class="container-fluid row" id="container">
		<jsp:include page="mypage_aside.jsp"/>
        <div id="content" class="col-12 col-lg-10">
			<div class="container">
				<%
                if(type.equals("list")){
                	%>
					<h4 class="questions_title">문의 내역</h4>  
					<hr>
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
							<th style="width: 8%;">번호</th>
							<th style="width: 16%;">문의 유형</th>
							<th style="width: 38%;">문의 제목</th>
							<th style="width: 20%;">문의 날짜</th>
							<th style="width: 10%;">상태</th>
							<th style="width: 8%;"></th>
						</tr>
						<%
						questions_DAO qu_dao = questions_DAO.getInstance();		
						ArrayList<questions_DTO> que_lists =null;
					    count =  0;
						if(queType.equals("전체")){
							count = qu_dao.getAllMyQueCount(Integer.parseInt(member_key));
							que_lists = qu_dao.getAllMyQue(Integer.parseInt(member_key),startRow,endRow);
						}else{
							count = qu_dao.getAllMyQueTypeCount(Integer.parseInt(member_key),queType);
							que_lists = qu_dao.getAllMyQueByType(Integer.parseInt(member_key),queType,startRow,endRow);
						}
						number =count - (currentPage-1)*pageSize;
						
						if(count>0){
 							for(questions_DTO qu_dto : que_lists){
								%>
								<tr onclick="view_question(<%=member_key%>,<%=qu_dto.getQuestion_key()%>,'<%=pageNum%>','<%=queType%>')">
									<td><%=qu_dto.getRank() %></td>
									<td><%=qu_dto.getQue_type()%></td>
									<td  class="text-start"><%=qu_dto.getQue_title()%></td>
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
										<i class="bi bi-trash3-fill" onclick="delete_question(<%=member_key%>,<%=qu_dto.getQuestion_key()%>,'<%=qu_dto.getQue_title()%>','<%=pageNum%>','<%=queType%>')"></i>
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
		            				<a href="mypage_questions.jsp?type=list&queType=<%=queType%>&pageNum=<%=startPage-pageBlock%>">[이전]</a>
		            			<%
		            		}
		            		
			            	for(int i=startPage;i<=endPage;i++){
		            			%>
		        					<a href="mypage_questions.jsp?type=list&queType=<%=queType%>&pageNum=<%=i%>" <%if(currentPage == i){%> style="color: #212529" <%} %>><%=i%></a>
		        				<%	
			            	}
		            		if(endPage<pageCount){
		            			%>
			        				<a href="mypage_questions.jsp?type=list&queType=<%=queType%>&pageNum=<%=startPage+pageBlock%>">[다음]</a>
			        			<%
		            		}
			            		
		            	}
					 %>	
					 </div>
                	<%
                }else if(type.equals("add")){
                	%>
					<h4 class="questions_title">문의 하기</h4>
					<hr>
					<form action="mypage_que_add_Proc.jsp" method="post" class="questions_form">
					<input type="hidden" name="member_key" value="<%=member_key%>">
					<table class="questions_add_table">
						<tr>
							<th style="width: 20%;">작성자명</th>
							<td style="width: 30%;"><%=m_dto.getUser_name()%></td>
							<th style="width: 20%;">문의 유형</th>
							<td style="width: 30%;">
								<select class="que_option" name="que_type">
									<option value="이용문의">이용문의</option>
									<option value="계정문의">계정문의</option>
									<option value="버그/오류 제보">버그/오류 제보</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>문의명</th>
							<td colspan="3" class="input_td">
								<input type="text" name="que_title" maxlength="20" placeholder="문의명을 입력해주세요." >
							</td>
						</tr>
						<tr>
							<th>문의내용</th>
							<td colspan="3" class="input_td">
								<textarea name="que_content" maxlength="150" placeholder="문의내용을 입력해주세요."></textarea>
							</td>
						</tr>
					</table> 
					<div class="btn_area">
						<input type="reset" value="초기화" class="que_add_btn que_reset_btn">
						<input type="submit" value="작성하기" class="que_add_btn" onclick="return que_check()">
					</div>
					</form>               	
                	<%
                }
                %>
			</div>
		</div>
    </div>
	
	<jsp:include page="../../include/footer.jsp"/>	