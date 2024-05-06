<%@page import="QS.MEMBER.Member_Info_DTO"%>
<%@page import="QS.MEMBER.Member_Info_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<jsp:include page="../../include/header.jsp"/>
	<link href="<%=request.getContextPath()%>/css/mypage.css" rel="stylesheet" />
	<script src="<%=request.getContextPath()%>/script/mypage.js"></script>
	<%
		String member_key = (String)session.getAttribute("member_key");
		Member_Info_DAO m_dao = Member_Info_DAO.getInstance();
		Member_Info_DTO m_dto = m_dao.getMemberByKey(member_key);
	
	%>
	<div class="container-fluid row" id="container">
		<jsp:include page="mypage_aside.jsp"/>
        <div id="content" class="col-12 col-lg-10">
			<div class="container">
				<form action="" method="post">
					<hr>
					<div class="profile_wrap m-auto pb-2 row">
						<input type="hidden" name="member_key" value="<%=Integer.parseInt(member_key)%>">
						<div class="col_split col-12 text-start">
							<p>이메일</p>
							<input type="text" name="email" placeholder="이메일" disabled value="<%=m_dto.getEmail()%>">
						</div>
						<div class="col_split col-12 mt-3 text-start">
							<p>이름</p>
							<input type="text" name="user_name" placeholder="이름" maxlength="6"  value="<%=m_dto.getUser_name()%>">
						</div>
						<div class="error_msg_wrap text-start" id="name_msg"></div>
						<div class="col_split col-12 mt-3 text-start">
							<p>휴대폰 번호</p>
							<input type="text" id="phone_number" name="phone_number"  placeholder="휴대폰 번호(010-1234-5678)" maxlength="13" value="<%=m_dto.getPhone_number()%>">
							<p>성별</p>
							<div class="gender_box p-0 ">
								<%
								if(m_dto.getGender()!=null){
									%>
									<label class="<%if(m_dto.getGender().equals("남")){%>select_gender<%}%>">남</label>
									<label class="<%if(m_dto.getGender().equals("여")){%>select_gender<%}%>">여</label>
									<%
								}else{
									%>
									<label>남</label>
									<label>여</label>
									<%
								}
								%>
							</div>
						</div>
						<div class="error_msg_wrap text-start" id="phone_gender_msg"></div>
						<div class="col_split col-12 mt-3 text-start">
							<p>비밀번호</p>
							<input type="password" name="password" placeholder="비밀번호(영문+숫자+특수문자 8자리 이상 ~ 16자리 이하)" disabled value="<%=m_dto.getPassword()%>">
							<input type="button" class="btn_password" value="비밀번호 변경" onclick="password_update()"><br>
							<input type="password" name="password_re" placeholder="비밀번호 재입력">
						</div>
						<div class="error_msg_wrap text-start" id="passwd_msg"></div>						
					</div>
					<div class="error_msg_wrap text-start"></div>
					<div class="btn_profile_wrap mt-4 mb-3 text-end">
						<input type="submit" class="btn_update" value="변경하기" onclick="return update_check()">
						<input type="button" class="btn_delete" value="계정삭제" onclick="delete_user()">
					</div>
					<hr>
				</form>
			</div>
		</div>
    </div>
	
	<jsp:include page="../../include/footer.jsp"/>	