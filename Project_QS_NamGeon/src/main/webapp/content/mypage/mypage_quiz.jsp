<%@page import="QS.CONTENT.Content_List_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="QS.CONTENT.Play_Record_DAO"%>
<%@page import="QS.CONTENT.Content_List_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<jsp:include page="../../include/header.jsp"/>
	<link href="<%=request.getContextPath()%>/css/mypage.css" rel="stylesheet" />
	<script src="<%=request.getContextPath()%>/script/mypage.js"></script>
	<%
		String saveFolder = "/assets/img";
	    String requestFolder = request.getContextPath()+"/"+saveFolder;
	    Content_List_DAO cl_dao = Content_List_DAO.getInstance();
	    Play_Record_DAO pr_dao = Play_Record_DAO.getInstance();
		String member_key = (String)session.getAttribute("member_key");
		ArrayList<Content_List_DTO> lists = null;
	    String sort = request.getParameter("sort");
	    if(sort==null){
			sort = "my";        	
	    }
	    if(member_key==null){
	    	member_key = "1";        	
	    }
	    
		
	%>
	<div class="container-fluid row" id="container">
		<jsp:include page="mypage_aside.jsp"/>
        <div id="content" class="col-12 col-lg-10">
			<div class="container">
                <%
                if(sort.equals("my")){
                	%>
					<h4>내 퀴즈</h4>                	
                	<%
                	lists = cl_dao.getAllContentRecent("");
                }else if(sort.equals("like")){
                	%>
					<h4>좋아요한 퀴즈</h4>                	
                	<%
                	lists = cl_dao.getAllContentMylike(Integer.parseInt(member_key));
                }else{
                	%>
					<h4>참여한 퀴즈</h4>                	
                	<%
                	lists = cl_dao.getAllContentMyPlay(Integer.parseInt(member_key));
                }
                %>
				<div class="row g-5 content_box">
                <%

                    for(Content_List_DTO cl_dto : lists){	
                    	int like_count = pr_dao.contentLikeCount(cl_dto.getContent_key());
                    	int record_count = pr_dao.contentRecordCount(cl_dto.getContent_key());
                        %>
                            <div class="col-xl-3 col-lg-4 col-sm-6 col-12">
                                <div class="content_info_box" onclick="content_play(<%=cl_dto.getContent_key()%>)">
                                    <div class="content_image_box">
                                        <img src="<%=requestFolder+"/"+cl_dto.getThumbnail()%>">
                                        <%
                                        if(sort.equals("my")){
                                        	%>
											<div class="my_option">
												<button class="update_content">
													<i class="bi bi-pencil-square"></i>
												</button>
												<br>
												<button class="delete_content" onclick="delete_content(<%=cl_dto.getContent_key()%>,'<%=cl_dto.getTitle()%>')">
													<i class="bi bi-x-square"></i>
												</button>
											</div>
											<%
                                        }
                                        %>
                                    </div>
                                    <div class="content_text_box">
                                        <h3><%=cl_dto.getTitle()%></h3>
                                        <div class="content_explanation_box">
                                            <p><%=cl_dto.getExplanation()%></p>                                
                                        </div>
                                        </div>
                                    <div class="content_option_box">
                                        <span class="user_creater">만든이: <%=cl_dto.getUser_name() %></span>                                        
                                        <span class="user_service">
                                        <%
                                        if(member_key==null){
                                        	%>
                                            <i class="bi bi-suit-heart" onclick="login_check()"></i>
                                            <span class="like_count"><%=like_count%></span>
                                        	<%
                                        }else{
	                                        if(pr_dao.contentLikeCheck(Integer.parseInt(member_key),cl_dto.getContent_key())){
	                                        	%>
	                                            <i class="bi bi-suit-heart-fill" onclick="like_btn(this,<%=cl_dto.getContent_key()%>,<%=member_key%>)"></i>
	                                            <span class="like_count"><%=like_count%></span>
	                                        	<%
	                                        }else{
	                                        	%>
	                                            <i class="bi bi-suit-heart" onclick="like_btn(this,<%=cl_dto.getContent_key()%>,<%=member_key%>)"></i>
	                                            <span class="like_count"><%=like_count%></span>
	                                        	<%
	                                        }
                                        }
                                        %>
                                            <i class="bi bi-people"></i>
                                            <span class="record_count"><%=record_count%></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        <%
                    }
                %>                
            </div>
			</div>
		</div>
    </div>
	
	<jsp:include page="../../include/footer.jsp"/>	