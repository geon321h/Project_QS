<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <jsp:include page="/include/header.jsp" />
    <header class="masthead">
        <div class="container px-4 px-lg-5 h-100">
            <div class="row gx-4 gx-lg-5 h-100 align-items-center justify-content-center text-center position-relative">
                <div class="col-lg-8 align-self-end">
                    <h1 class="text-white font-weight-bold">나만의 퀴즈와 설문을 만들어 보세요!</h1>
                    <hr class="divider" />
                </div>
                <div class="col-lg-8 align-self-baseline">
                    <p class="mb-5">
                        다양한 형식의 퀴즈를 직접 제작하여 다른 사람들과 공유해보세요.<br>
                        또한 여러 사람들의 생각을 듣고 싶다면 맞춤 설문조사를 만들 수 있어요.<br>
                        지금 바로 여러분의 아이디어를 만들어 보세요!
                    </p>
                    <a class="btn btn-xl px-5 py-4" href="javascript:login_check();">지금 만들기</a>
                </div>
            </div>
        </div>
    </header>
    <jsp:include page="/include/footer.jsp" />