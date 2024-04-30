<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../../include/header.jsp"/>    

<jsp:useBean id="content_quiz" class="QS.CONTENT.Content_Quiz_bean" scope="session"/>
<%
	String member_key = (String)session.getAttribute("member_key");
	String save = request.getParameter("save");
	save = "save";// 퀴즈생성을 위해 임시
	if(save==null){
		if(content_quiz.getCL_DTO().getThumbnail() != null){
			
			String configDir = config.getServletContext().getRealPath("/assets/img");
		 	String fullPath = configDir+"\\"+content_quiz.getCL_DTO().getThumbnail();
		  	
 		 	File file = new File(fullPath);
		 	if(file.exists()){
		 		if(file.delete()){
		 			System.out.println("파일삭제 성공");
		 		}else{
		 			System.out.println("파일삭제 실패");
		 		}
		 	}else{
		 			System.out.println("파일없음");
		 	}
		}
 		content_quiz.resetSaveData();
		
	}else{
		%>
		<script type="text/javascript">
            $(function(){
                pop_content_info_Close();
            })
		</script>
		<%
	}

%>


<script src="<%=request.getContextPath()%>/script/quiz.js"></script>
<script type="text/javascript">
    /*  팝업이전에 로그인여부 확인  */
    function content_check() {
        
        let blank_pass = true;
        blank_pass = content_info_check(blank_pass);
        if(!blank_pass){
            return false
        }
        
    }
</script>
<div class="create_modal_bg"></div>
<div class="create_modal_wrap p-3">
    <div class="content_info_area pt-2 pb-4 px-3 text-center ">
        <form action="quiz_info_add.jsp?member_key=<%=member_key%>" class="text-start p-3 pb-1 mb-0" method="post"  enctype="multipart/form-data">
            <p class="">퀴즈만들기</p>
            <hr>
            <div class="col_split my-3">
                <p class="m-1">제목</p>
                <input type="text" name="title" placeholder="제목을 입력해주세요.(최대20자)" maxlength="20">
                <div class="error_msg_wrap text-start mt-1" id="title_msg"></div>
            </div>
            <div class="col_split  my-3">
                <p class="m-1">설명</p>
                <textarea cols="40" name="explanation" rows="4" placeholder="설명을 입력해주세요.(최대50자)" maxlength="50"></textarea>
                <div class="error_msg_wrap text-start" id="explanation_msg"></div>
            </div>
            <div class="col_split my-3">
                <p class="m-1">썸네일</p>
                <div class="file_box_area">
                    <div class="image_box">
                        <img src="" class="thumbnail_image">
                        <div>
                            <i class="bi bi-trash3-fill btn" id="thumbnail_delete"></i>
                        </div>
                    </div>
                    <div class="file_box text-center">
                        <h4>썸네일을 추가해주세요.</h4>
                        <p>Files Supported: JPG, PNG, GIF</p>
                        <i class="bi bi-plus-circle"></i>
                    </div>
                    <input type="file" name="thumbnail" id="thumbnail_file" hidden accept=".jpg,.png,.gif" style="display:none;">
                    <div class="error_msg_wrap text-start mt-1" id="thumbnail_msg"></div>
                </div>
            </div>
            <div class="col_split my-3">
                <div class="form-check form-switch ps-0">
                    <p class="form-check-label" for="flexSwitchCheckDefault">공개여부<br>
                        <input class="form-check-input mt-1 ms-0 mb-4" name="content_public" type="checkbox" role="switch" id="flexSwitchCheckDefault">
                    </p>
                </div>
            </div>
            <div class="col_split text-center  mt-4">
                <input type="submit" class="btn btn-dark m-auto" onclick="return content_check()" id="create_check_btn" value="생성하기">
            </div>
        </form>
    </div>
</div>

    <link href="<%=request.getContextPath()%>/css/quiz.css" rel="stylesheet" />
    
    <div class="container" id="container">
        <div id="content" class="row g-5 quiz_content">

            <div class="col-xl-3 col-lg-4 col-sm-6 col-12">
                <div class="">Custom column padding</div>
            </div>

            <div class="col-xl-3 col-lg-4 col-sm-6 col-12">
                <div class="create_quiz_btn text-center p-3">
                    <h4 class="mt-5">문제를 추가하세요!</h4>
                    <i class="bi bi-plus-circle"></i>
                </div>
            </div>

        </div>
    </div>
    <jsp:include page="../../include/footer.jsp"/>