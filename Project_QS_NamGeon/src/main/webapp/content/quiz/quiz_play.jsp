<%@page import="QS.CONTENT.comment_DAO"%>
<%@page import="QS.CONTENT.comment_DTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="QS.CONTENT.Quiz_List_DTO"%>
<%@page import="QS.CONTENT.Quiz_List_DAO"%>
<%@page import="QS.CONTENT.Play_Record_DTO"%>
<%@page import="QS.CONTENT.Content_List_DTO"%>
<%@page import="QS.CONTENT.Content_List_DAO"%>
<%@page import="QS.CONTENT.Play_Record_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	<jsp:include page="../../include/header.jsp"/>
	<link href="<%=request.getContextPath()%>/css/quiz.css" rel="stylesheet" />
	 <script src="<%=request.getContextPath()%>/script/quiz.js"></script>	 
	 <jsp:useBean id="pr_dto" class="QS.CONTENT.Play_Record_DTO" scope="session"/>
	 <%
        String saveFolder = "/assets/img";
        String requestFolder = request.getContextPath()+"/"+saveFolder;
        Content_List_DAO cl_dao = Content_List_DAO.getInstance();
        Quiz_List_DAO ql_dao = Quiz_List_DAO.getInstance();
        String member_key = (String)session.getAttribute("member_key");
        
        String content_key = request.getParameter("content_key");
        String num = request.getParameter("num");
        String answer = request.getParameter("answer");
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        int quizNum = 0;
		/*if(content_key==null){
        	content_key = "41";        	
        } */
        if(num!=null){
        	quizNum = Integer.parseInt(num);
        }
        Content_List_DTO cl_dto = cl_dao.getContentByKey(content_key);
        ArrayList<Quiz_List_DTO> lists_quiz = ql_dao.getQuizByKey(content_key);
        Quiz_List_DTO ql_dto = null;
        for(Quiz_List_DTO dto : lists_quiz){
        	if(dto.getQuiz_key() == quizNum){
        		ql_dto = dto;
        	}
        }
        
    %>
    <canvas id="canvas"></canvas>
    <div class="container" id="container">
        <div id="content">
        	<%
        	if(quizNum<=0){
        		pr_dto.setScore(0);
        		pr_dto.setContent_key(0);
        		pr_dto.setMember_key(0);
        		%>
        		<div class="quiz_start_area text-center">
                    <div class="title_box">
                        <h2><%=cl_dto.getTitle()%></h2>
                    </div>
                    <div class="image_box">
                        <img src="<%=requestFolder+"/"+cl_dto.getThumbnail()%>" alt="">
                    </div>
                    <form action="quiz_play.jsp" method="post">
                    	<input type="hidden" name="content_key" value="<%=content_key%>">
                        <input type="hidden" name="num" value="1">
	                    <input  type="submit" class="submit_btn" onmouseover="vibration(this)" onmouseleave="vibration_off(this)" value="시작하기">
                    </form>
                </div>
        		<%
        	}else if(cl_dto.getContent_count() >= quizNum){
        		if(answer != null){
        			Boolean answer_flag = ql_dto.getAnswer().equals(answer);
        			%>        			
            		<div class="quiz_area text-center">
                        <div class="question_box">
                            <h2><%=ql_dto.getQuestion()%></h2>
                        </div>
                        <%
                        if(answer_flag){
                        	int score = pr_dto.getScore();
                        	score += 1;
                        	pr_dto.setScore(score);
                        	%>
							<script src="<%=request.getContextPath()%>/script/quiz_event.js"></script>
	                        <div class="true_quiz">
								<img class="true_img_lg" src="<%=request.getContextPath()%>/assets/icon/fireworks.png">
								<span>정답</span>
								<img class="true_img_sm" src="<%=request.getContextPath()%>/assets/icon/fireworks.png">
							</div>
                        	<%
                        }else{
                        	%>
							<script src="<%=request.getContextPath()%>/script/quiz_event2.js"></script>
	                        <div class="flase_quiz">
								<img class="flase_img" src="<%=request.getContextPath()%>/assets/icon/rain.png">
								<span>오답..</span>
							</div>
                        	<%
                        }
                        %>                        
                        <form action="quiz_play.jsp" method="post" class="text-center">
                        	<p class="answer_text"><%=ql_dto.getAnswer()%></p>
                            <input type="hidden" name="content_key" value="<%=content_key%>">
                            <input type="hidden" name="num" value="<%=ql_dto.getQuiz_key()+1%>">
                            <input type="submit" class="answer_btn" value="다음">
                        </form>
                    </div>
            		<%
        		}else{
	        		%>
	        		<div class="quiz_area text-center">
	                    <div class="question_box">
	                        <h2><%=ql_dto.getQuestion()%></h2>
	                    </div>
	                    <%
	                    if(ql_dto.getQuiz_type()==3){
	                    	String[] example_arr = ql_dto.getExample().split(" ");
	                    	%>
		                    <div class="option_box text-start">
		                        <p><i class="bi bi-1-circle pe-4"></i><span><%=example_arr[0]%></span></p>
		                        <p><i class="bi bi-2-circle pe-4"></i><span><%=example_arr[1]%></span></p>
		                        <p><i class="bi bi-3-circle pe-4"></i><span><%=example_arr[2]%></span></p>
		                        <p><i class="bi bi-4-circle pe-4"></i><span><%=example_arr[3]%></span></p>
		                    </div>                        
	                    	<%
	                    }else if(ql_dto.getQuiz_type()==2){
	                    	%>
		                    <div class="image_box">
		                        <img src="<%=requestFolder+"/"+ql_dto.getImage()%>">
		                    </div>
	                    	<%
	                    }else{
	                    	%>
	                        <div class="blank_box"></div>
	                        <%
	                    }
	                    %>
	                    <form action="quiz_play.jsp" method="post">
	                        <input type="hidden" name="content_key" value="<%=content_key%>">
	                        <input type="hidden" name="num" value="<%=ql_dto.getQuiz_key()%>">
	                        <%
	                        if(ql_dto.getQuiz_type()==3){
	                            %>
	                            <input type="text" name="answer" class="answer_input" placeholder="번호를 적어주세요.(1,2,3,4)">
	                            <%
	                        }else{
	                            %>
	                            <input type="text" name="answer" class="answer_input" placeholder="정답을 입력해주세요.">
	                            <%
	                        }
	                        %>
	                        <input type="submit" class="answer_btn" value="제출">
	                    </form>
	                </div>
	        		<%
        		}
        	}else{
        		Play_Record_DAO pr_dao = Play_Record_DAO.getInstance();
     			//System.out.println("컨텐츠:"+pr_dto.getContent_key());	
        		if(member_key != null && pr_dto.getContent_key() == 0){
        			//System.out.println("기록 등록");
        			pr_dto.setMember_key(Integer.parseInt(member_key));
        			pr_dto.setContent_key(Integer.parseInt(content_key));
	        		pr_dao.insertRecord(pr_dto);
        		}
	        		ArrayList<Play_Record_DTO> list_record = pr_dao.getRecordByKey(Integer.parseInt(content_key));
//         			System.out.println("유저:"+pr_dto.getMember_key());	
//         			System.out.println("컨텐츠:"+pr_dto.getContent_key());	
//         			System.out.println("맞춘 개수:"+pr_dto.getScore());	

				%>
				<div class="result_area">
					<div class="text-center mb-3">
						<h2>맞힌 갯수: <%=pr_dto.getScore()%></h2>
						<table class="rank_table">
							<tr>
								<td>랭킹</td>
								<td>유저명</td>
								<td>맞힌 갯수</td>
								<td>참여일</td>
							</tr>
							<%
							if(list_record.size()>0){
								for(Play_Record_DTO record : list_record ){
								%>
								<tr class="info_record">
										<%
										if(record.getRank()==1){
											%>
											<td class="first_record">
											<img src="<%=request.getContextPath()%>/assets/icon/crown.png" alt="">
											<%=record.getRank()%>
											</td>	
											<%
										}else{
											%>
											<td>
												<%=record.getRank()%>
											</td>
											<%
										}
										%>
									<td><%=record.getUser_name()%></td>
									<td><%=record.getScore()%></td>
									<td><%=sdf.format(record.getPlay_day())%></td>
								</tr>
								<%
								}
							}else{
								%>
								<tr>
									<td colspan="4" class="not_record">참여한 기록이 없습니다.</td>
								</tr>
								<%
							}
							%>
						</table>
					</div>
					<div class="">
						<%
						comment_DAO c_dao = comment_DAO.getInstance();
						ArrayList<comment_DTO> list_comment = c_dao.getCommentByKey(Integer.parseInt(content_key));
						%>
						<h2 class="comment_count">댓글(<%=list_comment.size()%>)</h2>
						<table class="comment_table">
							<tr>
								<td colspan="3">
								<form  action="quiz_comment_add.jsp" method="post" >
									<input type="hidden" name="content_key" value="<%=content_key%>">
									<input type="hidden" name="member_key" value="<%=member_key%>">
	                            	<input type="hidden" name="num" value="<%=quizNum%>">                            
									<input class="comment_input" type="text" name="comment_text" value="" placeholder="댓글을 입력해주세요." maxlength="20">
									<%
									if(member_key==null){
										%>
										<input class="comment_btn" type="button" value="작성하기" onclick="login_check()">
										<%
									}else{
										%>
										<input class="comment_btn" type="submit" value="작성하기">
										<%
									}
									%>
								</form>
								</td>
							</tr>
							<%
							if(list_comment.size()>0){
								for(comment_DTO comment : list_comment ){
								%>
								<tr class="comment_list">
									<td width="600px">
										<%=comment.getUser_name()%>
										<span class="ct_day"><%=sdf.format(comment.getComment_day())%></span>
										<br><span class="ct_text"><%=comment.getComment_text()%></span>
									</td>
									<td width="50px"></td>
									<td width="50px">
									<%
									if(member_key!=null){
										if(comment.getMember_key() ==Integer.parseInt(member_key) || comment.getMember_key() == 1 ){
											%>
											<i class="bi bi-trash3-fill" onclick="deleteComment(<%=content_key%>,<%=quizNum%>,<%=comment.getComment_key()%>)"></i>
											<%
										}
									}
									%>
									</td>
								</tr>
								<%
								}
							}else{
								%>
								<tr>
									<td colspan="3" class="not_comment">댓글이 없습니다.</td>
								</tr>
								<%
							}
							%>
						</table>
					</div>
				</div>
				<%
        	}
        	%>
        </div>
    </div>
	
	 
	
	<jsp:include page="../../include/footer.jsp"/>	