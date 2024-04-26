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

<!-- javascript sns -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- javascript 멤버 -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/script/member.js"></script>

</head>
<body>
	<div class="passwd_find container text-center">
		<div class="passwd_find_area">
			<div class="text-end pt-3">
				<a href="javascript: history.back();"><i class="bi bi-arrow-return-left me-5"></i></a>
			</div>
			<h2 class="pb-3 pt-4">비밀번호 찾기</h2>
			<p class="passwd_find_text mb-5">
				QS에 가입했던 이름과 이메일을 입력해주세요.<br>
				해당하는 비밀번호를 알려드립니다.
			</p>
			<div class="passwd_find_wrap m-auto pb-2">
				<div class="col_split">
					<input type="text" name="user_name" placeholder="이름">
				</div>
				<div class="col_split">
					<input type="text" name="user_email" placeholder="이메일">
				</div>
			</div>
			<div class="error_msg_wrap text-start"></div>
			<div class="btn_passwd_find_wrap mt-4 mb-5">
				<input type="button" class="btn_find" value="비밀번호 찾기" onclick="passwd_find()">
				<input type="button" class="btn_back" style="display: none;" value="돌아가기" onclick="location.href='login.jsp?url=<%=url%>'">
			</div>
		</div>
	</div>
	<jsp:include page="../include/member_footer.html" />
</body>
</html>
