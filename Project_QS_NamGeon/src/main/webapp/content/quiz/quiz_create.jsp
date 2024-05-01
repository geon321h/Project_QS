<%@page import="QS.CONTENT.Quiz_List_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../../include/header.jsp"/>    

<jsp:useBean id="content_quiz" class="QS.CONTENT.Content_Quiz_bean" scope="session"/>
<%
	String member_key = (String)session.getAttribute("member_key");
	String save = request.getParameter("save");
    String saveFolder = "/assets/img";
    String requestFolder = request.getContextPath()+"/"+saveFolder;

	save = "save";// 퀴즈생성을 위해 임시

	if(save==null){
		if(content_quiz.getCL_DTO().getThumbnail() != null){
			
			String configDir = config.getServletContext().getRealPath(saveFolder);
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
	ArrayList<Quiz_List_DTO> lists = content_quiz.getQuiz_List();
%>


<script src="<%=request.getContextPath()%>/script/quiz.js"></script>
<script type="text/javascript">
    /*  팝업이전에 로그인여부 확인  */
    function content_check() {
        let blank_pass = true;
        blank_pass = content_info_check(blank_pass);
        if(!blank_pass){
            return false;
        }
    }

    function delete_quiz_list(number){
        location.href = "quiz_list_delete.jsp?number="+number;
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
                    <div class="image_box" id="thumbnail_image_box">
                        <img src="" class="thumbnail_image">
                        <div>
                            <i class="bi bi-trash3-fill btn" id="thumbnail_delete"></i>
                        </div>
                    </div>
                    <div class="file_box text-center" id="thumbnail_file_box">
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

<div class="create_quiz_modal_wrap p-3">
    <div class="quiz_content_box">
        <div class="content_quiz_area pt-2 pb-4 px-3 text-center">
            <form action="quiz_add.jsp" class="text-start p-3 pb-3 mb-5" method="post" enctype="multipart/form-data" id="quiz_list_form">
                <p class="">퀴즈만들기</p>
                <hr>
                <div class="col_split my-3">
                    <p class="m-1">문제</p>
                    <input type="text" name="question" placeholder="문제를 입력해주세요.(20자)" maxlength="20">
                    <div class="error_msg_wrap text-start mt-1" id="question_msg"></div>
                </div>

                <div class="col_split my-3">
                    <div id="example_box_area">
                        <p class="m-1">보기</p>
                        <div class="my-2">
                            <span class="example_number me-3">1</span><input type="text" class="example1" name="example" placeholder="보기1" maxlength="20">
                        </div>
                        <div class="my-2">
                            <span class="example_number me-3">2</span><input type="text" class="example2" name="example" placeholder="보기1" maxlength="20">
                        </div>
                        <div class="my-2">
                            <span class="example_number me-3">3</span><input type="text" class="example3" name="example" placeholder="보기1" maxlength="20">
                        </div>
                        <div class="my-2">
                            <span class="example_number me-3">4</span><input type="text" class="example4" name="example" placeholder="보기1" maxlength="20">
                        </div>
                        <div class="error_msg_wrap text-start mt-1" id="example_msg"></div>
                    </div>
                    <div class="file_box_area" id="quiz_box_area">
                    <p class="m-1">이미지</p>
                        <div class="image_box" id="quiz_image_box">
                            <img src="" class="quiz_image">
                            <div>
                                <i class="bi bi-trash3-fill btn" id="quiz_delete"></i>
                            </div>
                        </div>
                        <div class="file_box text-center" id="quiz_file_box">
                            <h4>문제 이미지를 추가해주세요.</h4>
                            <p>Files Supported: JPG, PNG, GIF</p>
                            <i class="bi bi-plus-circle"></i>
                        </div>
                        <input type="file" name="image" id="quiz_file" hidden accept=".jpg,.png,.gif" style="display:none;">
                        <div class="error_msg_wrap text-start mt-1" id="image_msg"></div>
                    </div>
                </div>
                <div class="col_split  my-3">
                    <p class="m-1">정답</p>
                    <input type="text" name="answer" placeholder="정답을 입력해주세요.(20자)" maxlength="20">
                    <div class="error_msg_wrap text-start" id="answer_msg"></div>
                </div>
                <div class="col_split text-center  mt-4">
                    <input type="submit" class="btn btn-dark m-auto" onclick="return quiz_check()" id="quiz_check_btn" value="확인">
                    <input type="reset" class="btn btn-dark-outline m-auto" onclick="pop_quiz_Close()" id="quiz_reset_btn" value="취소">
                </div>
            </form>
        </div>
        <div class="choice_quiz_modal_wrap p-3 text-center">
            <button class=" align-top" id="quiz_type_1" onclick="type_1_setting()">
                    <p class="pt-1"><i class="bi bi-question-lg"></i></p>
                    <p class="pt-1">문답 퀴즈</pc>
            </button>
            <button class="align-middle" id="quiz_type_2" onclick="type_2_setting()">
                    <p class="pt-1"><i class="bi bi-image"></i></p>
                    <p class="pt-1">사진 퀴즈</pc>
            </button>
            <button class="align-bottom" id="quiz_type_3" onclick="type_3_setting()">
                    <p class="pt-1"><i class="bi bi-hdd-stack"></i></p>
                    <p class="pt-1">선택 퀴즈</pc>
            </button>
        </div>
    </div>
</div>
    <link href="<%=request.getContextPath()%>/css/quiz.css" rel="stylesheet" />
    <div class="container" id="container">
        <div id="content" class="row g-5 quiz_content">
        	<%
        		for(int i=0;i<lists.size();i++){
					int type = 1;
                    String question = lists.get(i).getQuestion();
                    String answer = lists.get(i).getAnswer();
                    String example = "";
                    String image = "";
        			if(lists.get(i).getExample() != null){
        				type = 3;
        				example = lists.get(i).getExample();
        			}else if(lists.get(i).getImage()!=null){
        				type = 2;
        				image = requestFolder+"/"+lists.get(i).getImage();
        			}
        			%>
			            <div class="col-xl-3 col-lg-4 col-sm-6 col-12">
			                <div class="quiz_content_info_box p-4" onclick="update_quiz_list(<%=i%>,<%=type%>,'<%=question%>','<%=answer%>','<%=example%>','<%=image%>')">
                                <h3 class="pb-2"><%=i+1%>번째 퀴즈</h3>
                                <p >문제: <%=lists.get(i).getQuestion()%></p>                                
			                	<p>
			                		타입: 
			                		<%
			                			if(type==3){
			                				%>선택 퀴즈<%
			                			}else if(type==2){
			                				%>사진 퀴즈<%
			                			}else{
			                				%>문답 퀴즈<%
			                			}
			                		%>
			                	</p>
                                <p>정답: <%=lists.get(i).getAnswer()%></p>
                                <i class="bi bi-trash3-fill btn" id="quiz_list_delete" onclick="delete_quiz_list(<%=i%>)"></i>
			                </div>
			            </div>
        			<%
        		}
        	%>
            <%
            String last_question = "";
            if(lists.size()>0){
                last_question = lists.get(lists.size()-1).getQuestion();
            }
            %>
            <div class="col-xl-3 col-lg-4 col-sm-6 col-12">
                <div class="create_quiz_btn text-center p-3" onclick="create_quiz_list('<%=last_question%>')">
                    <h4 class="mt-5">문제를 추가하세요!</h4>
                    <i class="bi bi-plus-circle"></i>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../../include/footer.jsp"/>