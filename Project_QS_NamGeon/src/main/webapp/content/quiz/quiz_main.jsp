<%@page import="QS.CONTENT.Content_List_DTO"%>
<%@page import="QS.CONTENT.Content_List_DAO"%>
<%@page import="QS.CONTENT.Quiz_List_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<link href="<%=request.getContextPath()%>/css/quiz.css" rel="stylesheet" />
	<jsp:include page="../../include/header.jsp"/>
    <div class="container" id="container">
        <div id="content">
            <header class="row">
                <div class="col-3"></div>
                <div class="col-5 text-end" id="search_area">
                    <input type="text" class="" placeholder="검색어를 입력해주세요.">
                    <label>
                        <i class="bi bi-search btn align-self-center"></i>
                    </label>
                </div>
                <div class="col-1" id="align_area">
                    <select class="btn bg-white" name="sort" id="">
                        <option value="최신순">최신순</option>
                        <option value="인기순">인기순</option>
                        <option value="즐겨찾기">즐겨찾기</option>
                    </select>
                </div>
                <div class="col-3"></div>
            </header>
            <div class="row g-5 content_box">
                <%
                String saveFolder = "/assets/img";
                String requestFolder = request.getContextPath()+"/"+saveFolder;
            	Content_List_DAO cl_dao = Content_List_DAO.getInstance();
            	ArrayList<Content_List_DTO> lists = cl_dao.getAllContentByNotBan();
                    for(Content_List_DTO cl_dto : lists){
                        %>
                            <div class="col-xl-3 col-lg-4 col-sm-6 col-12">
                                <div class="content_info_box" onclick="">
                                    <div class="content_image_box ">
                                        <img src="<%=requestFolder+"/"+cl_dto.getThumbnail()%>" alt="">
                                    </div>
                                    <div class="content_text_box">
                                        <h3><%=cl_dto.getTitle()%></h3>
                                        <div class="content_explanation_box">
                                            <p><%=cl_dto.getExplanation()%></p>                                
                                        </div>
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
	