<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<link href="<%=request.getContextPath()%>/css/quiz.css" rel="stylesheet" />
	<jsp:include page="../include/header.jsp"/>
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
                    <select class="btn bg-white" name="" id="">
                        <option value="">최신순</option>
                        <option value="">인기순</option>
                        <option value="">즐겨찾기</option>
                    </select>
                </div>
                <div class="col-3"></div>
            </header>
        </div>
    </div>
    <jsp:include page="../include/footer.jsp"/>
	