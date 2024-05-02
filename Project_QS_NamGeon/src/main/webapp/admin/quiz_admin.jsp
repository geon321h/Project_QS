<%@page import="QS.CONTENT.Content_List_DTO"%>
<%@page import="QS.CONTENT.Content_List_DAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="header.jsp"/>
    <div class="container" id="content">
        <div class="m-auto content" id="content_member">
            <div id="ban_btn" class="text-end mb-3">
                <a href="javascript:" class="btn btn-outline-danger" onclick="delete_quiz()">삭제하기</a>
            </div>
            <table border="1" id="quiz_table">
                <tr>
                    <th><input type="checkbox" name="checkAll" onclick="choiceAll(this)"></th>
                    <th>번호</th>
                    <th>퀴즈 제목</th>
                    <th>퀴즈 설명</th>
                    <th>유저(유저번호)</th>
                    <th>썸네일</th>
                    <th>퀴즈 갯수</th>
                    <th>공개 여부</th>
                    <th>생성일</th>
                </tr>	
                <%
                	Content_List_DAO cl_dao = Content_List_DAO.getInstance();
                	ArrayList<Content_List_DTO> lists = cl_dao.getAllContent();
                	
                	String saveFolder = "/assets/img";
                    String requestFolder = request.getContextPath()+"/"+saveFolder;
                	
                	if(lists.size()>0){
                		for(Content_List_DTO cl_dto : lists){
	                   		%>
	               			<tr <%if(cl_dto.getBan().equals("Y")){%>class="ban_td"<%} %>>
	               				<td><input type="checkbox" name="rowcheck" value="<%=cl_dto.getContent_key()%>"></td>
	                            <td ><%=cl_dto.getContent_key()%></td>
	                            <td ><%=cl_dto.getTitle()%></td>
	                            <td class="explanation_td"><%=cl_dto.getExplanation()%></td>
	                            <td ><%=cl_dto.getUser_name()%>(<%=cl_dto.getCreate_user()%>)</td>
	                            <td >
	                            	<img src="<%=requestFolder+"/"+cl_dto.getThumbnail()%>" alt="">
	                            </td>
	                            <td ><%=cl_dto.getContent_count()%>개</td>
	                            <%
	                            if(cl_dto.getContent_public().equals("Y")){
	                            	%>
	                            	<td >공개</td>
	                            	<%
	                            }else{
	                            	%>
		                            <td >비공개</td>
	                            	<%
	                            }
	                            %>
	                            <td ><%=cl_dto.getCreate_day()%></td>
							<%    
                		}
                	}else{
               		%>
               			<tr>
                            <td colspan="9" id="msg_td">등록된 컨텐츠가 없습니다.</td>
                        </tr>
					<%                		
                	}
                %>
            </table>            
        </div>
    </div>
    <jsp:include page="../include/footer.jsp"/>