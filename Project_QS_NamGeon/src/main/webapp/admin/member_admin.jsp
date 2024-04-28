<%@page import="java.util.ArrayList"%>
<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@page import="QS.MEMBER.Member_Info_DTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<jsp:include page="header.jsp"/>
    <div class="container" id="content">
        <div class="m-auto content" id="content_member">
            <div id="ban_btn" class="text-end mb-3">
                <a href="javascript:ban_member()" class="btn btn-outline-dark me-2">정지하기</a>
                <a href="javascript:ban_off_member()" class="btn btn-outline-danger ">정지해제</a>
            </div>
            <table border="1">
                <tr>
                    <th><input type="checkbox" name="checkAll" onclick="choiceAll(this)"></th>
                    <th>회원번호</th>
                    <th>이메일</th>
                    <th>비밀번호</th>
                    <th>이름</th>
                    <th>휴대전화번호</th>
                    <th>성별</th>
                    <th>sns 타입</th>
                    <th>정지여부</th>
                </tr>	
                <%
                	Member_Info_DAO mdao = Member_Info_DAO.getInstance();
                	ArrayList<Member_Info_DTO> lists = mdao.getAllMember();
                	
                	if(lists.size()>0){
                		for(Member_Info_DTO mdto : lists){
	                   		%>
	               			<tr <%if(mdto.getBan().equals("Y")){%>class="ban_td"<%} %>>
	               				<%
	               				if(mdto.getEmail().equals("admin")){
	               					%>
			               				<td><input type="checkbox" name="" value="<%=mdto.getMember_key()%>" disabled></td>
	               					<%
	               				}else{
	               					%>
			               				<td><input type="checkbox" name="rowcheck" <%if(mdto.getBan().equals("Y")){%>class="ban_check"<%} %> value="<%=mdto.getMember_key()%>"></td>
	               					<%
	               				}
	               				%>
	                            <td ><%=mdto.getMember_key()%></td>
	                            <td ><%=mdto.getEmail()%></td>
	                            <td ><%=mdto.getPassword()%></td>
	                            <td ><%=mdto.getUser_name()%></td>
	                            <%
	                            if(mdto.getPhone_number()==null){
	                            	%>
	                            	<td >없음</td>
	                            	<%
	                            }else{
	                            	%>
		                            <td ><%=mdto.getPhone_number()%></td>
	                            	<%
	                            }
	                            %>
	                            <%
	                            if(mdto.getGender()==null){
	                            	%>
	                            	<td >미정</td>
	                            	<%
	                            }else{
	                            	%>
		                            <td ><%=mdto.getGender()%></td>
	                            	<%
	                            }
	                            %>
	                            <%
	                            if(mdto.getLogin_type()==null){
	                            	%>
	                            	<td >없음</td>
	                            	<%
	                            }else{
	                            	%>
		                            <td ><%=mdto.getLogin_type()%></td>
	                            	<%
	                            }
	                            %>
	                            <td ><%=mdto.getBan()%></td>
	                        </tr>
							<%    
                		}
                	}else{
               		%>
               			<tr>
                            <td colspan="8" id="msg_td">등록된 회원이 없습니다.</td>
                        </tr>
					<%                		
                	}
                %>
            </table>            
        </div>
    </div>
    <jsp:include page="../include/footer.jsp"/>
