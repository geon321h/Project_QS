<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	logout.jsp<br>

	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

	<script>
		$(function(){
			Kakao.init('28a9819acaa8a77445b389b1f9d308a6');
			kakaoLogout();

		});
		//카카오로그아웃  
		function kakaoLogout(){
			Kakao.Auth.logout(function(){
				console.log(Kakao.Auth.getAccessToken());
			});
		};

	</script>

	<%
    
	session.invalidate();
	String url  = request.getContextPath()+"/main.jsp";
    response.sendRedirect(url);
    %>

	
