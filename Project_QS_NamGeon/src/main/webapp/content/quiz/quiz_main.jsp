<%@page import="QS.CONTENT.Play_Record_DAO"%>
<%@page import="QS.CONTENT.Content_List_DTO"%>
<%@page import="QS.CONTENT.Content_List_DAO"%>
<%@page import="QS.CONTENT.Quiz_List_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<link href="<%=request.getContextPath()%>/css/quiz.css" rel="stylesheet" />
	<jsp:include page="../../include/header.jsp"/>

    <%
        String saveFolder = "/assets/img";
        String requestFolder = request.getContextPath()+"/"+saveFolder;
        Content_List_DAO cl_dao = Content_List_DAO.getInstance();
        Play_Record_DAO pr_dao = Play_Record_DAO.getInstance();
        String member_key = (String)session.getAttribute("member_key");
        
        String sort = request.getParameter("sort");
        String search_input = request.getParameter("search_input");
        
        if(sort == null){
        	sort = "recent";
        }
        if(search_input == null){
        	search_input = "";
        }
        
        String[] align_arr = {"recent","like","play"};
        String[] align_text_arr = {"최신순","인기순","참여순"};
    %>

    <script src="<%=request.getContextPath()%>/script/quiz.js"></script>
    
    <div class="container" id="container">
        <div id="content">
            <form action="quiz_main.jsp" method="post" id="setting_form">
                <header class="row">
                    <div class="col-3"></div>
                    <div class="col-5 text-end" id="search_area">
                        <input type="text" name="search_input" placeholder="검색어를 입력해주세요." value="<%=search_input%>">
                        <label>
                            <i class="bi bi-search btn align-self-center" onclick="settingChange()"></i>
                        </label>
                    </div>
                    <div class="col-1" id="align_area">
                        <select class="btn bg-white" name="sort" onchange="settingChange()">
                            <%
                            for(int i=0;i<align_arr.length;i++){
                                %>
                                <option value="<%=align_arr[i]%>" <%if(align_arr[i].equals(sort)){%>selected <%}%>>
                                    <%=align_text_arr[i]%>
                                </option>
                                <%
                            }
                            %>
                        </select>
                    </div>
                    <div class="col-3"></div>
                </header>
            </form>
            <div class="row g-5 content_box">
                <%
                ArrayList<Content_List_DTO> lists = null;
                if(sort.equals("recent")){
	            	lists = cl_dao.getAllContentRecent(search_input);
                }else if(sort.equals("like")){
                	lists = cl_dao.getAllContentLike(search_input);
                }else if(sort.equals("play")){
                	lists = cl_dao.getAllContentPlay(search_input);
                }

                    for(Content_List_DTO cl_dto : lists){	
                    	int like_count = pr_dao.contentLikeCount(cl_dto.getContent_key());
                    	int record_count = pr_dao.contentRecordCount(cl_dto.getContent_key());
                        %>
                            <div class="col-xl-3 col-lg-4 col-sm-6 col-12">
                                <div class="content_info_box" onclick="content_play(<%=cl_dto.getContent_key()%>)">
                                    <div class="content_image_box">
                                        <img src="<%=requestFolder+"/"+cl_dto.getThumbnail()%>">
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
                                            <i class="bi bi-suit-heart like_add_btn" onclick="login_check()"></i>
                                            <span class="like_count"><%=like_count%></span>
                                        	<%
                                        }else{
	                                        if(pr_dao.contentLikeCheck(Integer.parseInt(member_key),cl_dto.getContent_key())){
	                                        	%>
	                                            <i class="bi bi-suit-heart-fill like_add_btn" onclick="like_btn(this,<%=cl_dto.getContent_key()%>,<%=member_key%>)"></i>
	                                            <span class="like_count"><%=like_count%></span>
	                                        	<%
	                                        }else{
	                                        	%>
	                                            <i class="bi bi-suit-heart like_add_btn" onclick="like_btn(this,<%=cl_dto.getContent_key()%>,<%=member_key%>)"></i>
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
    <jsp:include page="../../include/footer.jsp"/>
