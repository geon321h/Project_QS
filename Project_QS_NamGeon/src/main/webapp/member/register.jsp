<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    	request.setCharacterEncoding("UTF-8");
    	String url = request.getParameter("url");
    	if(url == null){
    		url = request.getContextPath()+"/main.jsp";
    	}
 	%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>QuestionS:Quiz and Survey</title>

<!-- css 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />	

<!-- css 페이지 -->
<link href="../css/member.css" rel="stylesheet" />

<!-- 아이콘 부트스트랩 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

<!-- javascript 부트스트랩 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- javascript 멤버 -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/script/register.js"></script>

</head>
<body>
	<div class="register container text-center">
		<div class="register_area">
			<div class="text-end pt-3">
				<a href="javascript: history.back();"><i class="bi bi-arrow-return-left me-5"></i></a>
			</div>
			<h2 class="pb-3 pt-4">회원가입</h2>
			<p class="mb-5">
				이메일,성별은 변경할 수 없으니 신중히 확인해 주세요.
			</p>
			<form action="register_Proc.jsp?url=<%=url%>" method="post">
				<div class="register_wrap m-auto pb-2 row">
					<div class="col_split col-12">
						<input type="text" name="email" placeholder="이메일">
					</div>
					<div class="error_msg_wrap text-start" id="email_msg"></div>
					<div class="col_split col-12 mt-3">
						<input type="text" name="user_name" placeholder="이름" maxlength="6">
					</div>
					<div class="error_msg_wrap text-start" id="name_msg"></div>
					<div class="col_split col-12 mt-3 row">
						<div class="col-sm-8 p-0">
							<input type="text" id="phone_number" name="phone_number"  placeholder="휴대폰 번호(010-1234-5678)" maxlength="13">
						</div>
						<div class="col-sm-4">
							<div class="gender_box p-0 ">
								<input type="radio" class="btn-check" name="gender" id="first-outlined" autocomplete="off" value="남">
								<label class="btn btn-outline" for="first-outlined">남</label>
								<input type="radio" class="btn-check" name="gender" id="second-outlined" autocomplete="off" value="여">
								<label class="btn btn-outline" for="second-outlined">여</label>
							</div>
						</div>
					</div>
					<div class="error_msg_wrap text-start" id="phone_gender_msg"></div>
					<div class="col_split col-12 mt-3">
						<input type="password" name="password" placeholder="비밀번호(영문+숫자+특수문자 8자리 이상 ~ 16자리 이하)">
						<input type="password" name="password_re" placeholder="비밀번호 재입력">
					</div>
					<div class="error_msg_wrap text-start" id="passwd_msg"></div>
					
				</div>
				<div class="error_msg_wrap text-start"></div>
				<div class="btn_register_wrap mt-4 mb-3">
					<input type="submit" class="btn_register" value="회원가입" onclick="return register_check()">
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../include/member_footer.html" />
</body>
</html>