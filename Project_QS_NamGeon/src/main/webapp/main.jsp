<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuestionS:Quiz and Survey</title>
    
    <!-- css 부트스트랩 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
    crossorigin="anonymous"/>

    <!-- css 페이지 -->
    <link href="css/header_footer_style.css" rel="stylesheet" />

    <!-- 아이콘 부트스트랩 -->
    <link rel="stylesheet" 
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">

    <!-- javascript 부트스트랩 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
    crossorigin="anonymous"></script>

</head>
	<%
		request.setCharacterEncoding("UTF-8");
		
	%>
<body>
	<jsp:include page="/include/header.jsp"/>
    <header class="masthead">
        <div class="container px-4 px-lg-5 h-100">
            <div class="row gx-4 gx-lg-5 h-100 align-items-center justify-content-center text-center position-relative">
                <div class="col-lg-8 align-self-end">
                    <h1 class="text-white font-weight-bold">나만의 퀴즈와 설문을 만들어 보세요!</h1>
                    <hr class="divider" />
                </div>
                <div class="col-lg-8 align-self-baseline">
                    <p class="mb-5 ">
                        다양한 형식의 퀴즈를 직접 제작하여 다른 사람들과 공유해보세요.<br>
                        또한 여러 사람들의 생각을 듣고 싶다면 맞춤 설문조사를 만들 수 있어요.<br>
                        지금 바로 여러분의 아이디어를 만들어 보세요!
                    </p>
                    <a class="btn btn-xl px-5 py-4" href="#">지금 만들기</a>
                </div>
            </div>
        </div>  
    </header>
    <jsp:include page="/include/footer.html"/>
    <script src="script/scripts.js"></script>
</body>
</html>