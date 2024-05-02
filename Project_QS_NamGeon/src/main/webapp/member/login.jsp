<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	request.setCharacterEncoding("UTF-8");
    	session.invalidate();
    	String url = request.getParameter("url");
    	if(url == null){
    		url = request.getContextPath()+"/main.jsp";
    	}
//     	System.out.println("url: "+url);
    %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuestionS</title>
    
    <!-- css 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
    crossorigin="anonymous"/>

    <!-- css 페이지 -->
    <link href="../css/member.css" rel="stylesheet" />

    <!-- 아이콘 부트스트랩 -->
    <link rel="stylesheet" 
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

    <!-- javascript 부트스트랩 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
    crossorigin="anonymous"></script>

    <!-- javascript sns -->
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

    <!-- javascript 멤버 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/script/member.js"></script>

</head>
<body>
    <div class="signin container text-center">
        <div class="signin_area">
            <a href="../main.html" id="logo">LOGO</a>
            <form name="login_form" action="login_Proc.jsp?url=<%=url%>" method="post" class="m-auto">
                <div class="login_wrap m-auto">
                    <div class="col_split">
                        <input type="text" name="user_email" placeholder="이메일">
                    </div>
                    <div class="col_split">
                        <input type="password" name="user_password" placeholder="비밀번호">
                    </div>
                </div>
                <div class="error_msg_wrap text-start">
                    
                </div>
                <div class="btm_login_wrap">
                    <input type="submit" value="로그인" onclick="return login_check()">
                </div>
            </form>
            <div class="login_bottomlink my-3 text-center">
                <a href="register.jsp?url=<%=url%>" class="px-2">회원가입</a> 
                <a href="password_find.jsp?url=<%=url%>" class="px-2">비밀번호를 잊으셨나요?</a>
            </div>
            <div class="login_sns m-auto py-3">
                <div id="naver_id_login" style="display: none;"></div>
                <a href="javascript:navarLogin()" class="btn btn-xl mx-0 mx-lg-2 ">
                    <img src="../assets/icon/naver_icon.png" alt="">
                    네이버로 로그인
                </a> 
                <a href="javascript:kakaoLogin()" class="btn btn-xl mx-0 mx-lg-2 ">
                    <img src="../assets/icon/kakao_icon.png" alt="">
                    카카오로 로그인
                </a> 
            </div>
        </div>
    </div>
    <jsp:include page="../include/member_footer.html"/>

    <script type="text/javascript">

        // 네이버 //

        // 네이버 로그인 초기화
        // var testPopUp;
        // function openPopUp() {
        //     testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
        // }
        // function closePopUp(){
        //     testPopUp.close();
        // }

        // function naverLogout() {
        //     console.log(2);
        //     openPopUp();
        //     setTimeout(function() {
        //         closePopUp();
        //         }, 100);
            
        // }
        // naverLogout();

        var naver_id_login = new naver_id_login("xv3XT9V8S0QZOPJ_FpTI", "http://localhost:8081/Project_QS_NamGeon/member/naver_callback.html");
        var state = naver_id_login.getUniqState();
        naver_id_login.setButton("white", 2,40);
        naver_id_login.setDomain("http://localhost:8081/Project_QS_NamGeon/member/login.jsp");
        naver_id_login.setState(state);
        naver_id_login.setPopup();
        naver_id_login.init_naver_id_login();

        function navarLogin(){
            // console.log('네이버 로그인');
            
            var btnNaverLogin = document.getElementById("naver_id_login").firstChild;
		    btnNaverLogin.click();
        }

        var user_array = [];
        function sendData(access_token,id,nickname,gender,mobile,name){
            user_array.push({access_token:access_token, id:id,nickname:nickname,gender:gender,mobile:mobile,name:name});
            // console.log(access_token);
            // console.log(id);
            // console.log(nickname);
            // console.log(gender);
            // console.log(mobile);
            // console.log(name);
            // for(i=0;i<user_array.length;i++){
            //     console.log(user_array[i].access_token);
            //     console.log(i);
            // }
            location.href = "login_Proc.jsp?access_token="+user_array[0].access_token
                                            +"&id="+user_array[0].id
                                            +"&nickname="+user_array[0].nickname
                                            +"&gender="+user_array[0].gender
                                            +"&mobile="+user_array[0].mobile
                                            +"&name="+user_array[0].name
                                            +"&url=<%=url%>"
                                            +"&type=naver";
        }

        // 카카오 //
        
        Kakao.init('28a9819acaa8a77445b389b1f9d308a6'); //발급받은 키 중 javascript키를 사용해준다.
        console.log(Kakao.isInitialized()); // sdk초기화여부판단
        //카카오로그인
        function kakaoLogin() {
            Kakao.Auth.login({
                success: function (authObj) {
                    console.log(authObj); // access토큰 값
                    Kakao.Auth.setAccessToken(authObj.access_token); // access토큰값 저장

                    getInfo(authObj.access_token);
                },
                fail: function (err) {
                    console.log(err);
                }
            });
            function getInfo(access_token) {
                Kakao.API.request({
                url: '/v2/user/me',
                success: function (response) {
                    let id = response.kakao_account.email;
                    let nickname = response.kakao_account.profile.nickname;
                    // console.log(response)
                    console.log(access_token)
                    // console.log(response.kakao_account.email)
                    // console.log(response.kakao_account.profile.nickname)

                    location.href = "login_Proc.jsp?access_token="+access_token
                                            +"&id="+id
                                            +"&nickname="+nickname
                                            +"&gender="+"남"
                                            +"&mobile=undefined"
                                            +"&url=<%=url%>"
                                            +"&type=kakao";
                    
                },
                fail: function (error) {
                    console.log(error)
                },
                })
            }
            
        }

    </script>

</body>
</html>