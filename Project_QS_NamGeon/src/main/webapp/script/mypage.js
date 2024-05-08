let name_pass = false;
let passwd_check_pass = false;
$(function(){
       
   $(".like_add_btn").on("click",function(event){
    event.stopPropagation();
    });
   $(".update_my_btn").on("click",function(event){
    event.stopPropagation();
    });
   $(".delete_my_btn").on("click",function(event){
    event.stopPropagation();
    });

    /* 이름 */ 
    $('input[name="user_name"]').keydown(function(){
        $('#name_msg').empty();
    })

    let regex_name = /[`~!@#$%^&*|\\\'\";:\/?]/;
    $('input[name="user_name"]').keyup(function(){
        let name = $('input[name="user_name"]').val();
        if(regex_name.test(name)){
            $('input[name="user_name"]').focus();
            $('#name_msg').html("특수문자를 제외한 문자를 입력해주세요.");
            name_pass = true;
        }else{
            name_pass = false;
        }
        $('input[name="user_name"]').val($.trim(name));
    })

    /* 휴대전화번호 */
    $('input[name="phone_number"]').keydown(function(){
        $('#phone_gender_msg').empty();
    })

    $('input[name="phone_number"]').keyup(function(){
        let phone_number = $('input[name="phone_number"]').val();
        // console.log(phone_number);
        let number = phone_number
          .replace(/[^0-9]/g, '')
         .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
         $('input[name="phone_number"]').val(number);
    })

    /* 비밀번호 */
    $('input[name="password"]').keydown(function(){
        $('#passwd_msg').empty();
        passwd_check_pass = true;
    })

    $('input[name="password_re"]').keydown(function(){
        $('#passwd_msg').empty();
    })

    $('input[name="password_re"]').keyup(function(){
        let password = $('input[name="password"]').val();
        let password_re = $('input[name="password_re"]').val();
        if(password!=password_re){
            $('input[name="password_re"]').focus();
            $('#passwd_msg').html("비밀번호가 일치하지 않습니다.");
            passwd_check_pass = true;
        }else{
            passwd_check_pass = false;
        }
    })

})

function update_check() {

    let blank_pass = false;
    let duplicate_pass = false;

    if( $('input[name="user_name"]').val()==""){
        $('input[name="user_name"]').focus();
        $('#name_msg').html("이름을 입력해주세요.");
        blank_pass = true; 
    }else if(name_pass){
        $('input[name="user_name"]').focus();
        $('#name_msg').html("특수문자를 제외한 문자를 입력해주세요.");
        return false;
    }

    if( $('input[name="phone_number"]').val()==""){
        $('input[name="phone_number"]').focus();
        $('#phone_gender_msg').html("휴대전화번호를 입력해주세요.");
        blank_pass = true; 
    }else if($('input[name="phone_number"]').val().length < 13){
        $('input[name="phone_number"]').focus();
        $('#phone_gender_msg').html("휴대전화번호를 올바른 형식으로 입력해주세요.");
        return false;
    }

    let regex_passwd = /^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,16}$/
    let pw = $('input[name="password"]').val();
    console.log(regex_passwd.test(pw))

    if( $('input[name="password"]').val()==""){
        $('input[name="password"]').focus();
        $('#passwd_msg').html("비밀번호를 입력해주세요.");
        blank_pass = true; 
    }else if(regex_passwd.test(pw)==false){
        $('input[name="password"]').focus();
        $('#passwd_msg').html("비밀번호를 올바른 형식으로 입력해주세요.");
        return false;
    }else if(passwd_check_pass){
        $('input[name="password_re"]').focus();
        $('#passwd_msg').html("비밀번호가 일치하지 않습니다.");
        return false;
    }
    
    if(blank_pass || duplicate_pass){
        return false;
    }else{
        update_profile();
        return false;
    }
    

}

function password_update(){

    passwd_check_pass=true;
    $('input[name="password"]').attr("disabled", false);
    $('input[name="password_re"]').show();

}

function update_profile(){

    $.ajax({
        url : "mypage_profile_Proc.jsp",
        data : ({
            user_name : $('input[name="user_name"]').val(),
            phone_number : $('input[name="phone_number"]').val(),
            password : $('input[name="password"]').val(),
            member_key : $('input[name="member_key"]').val(),
        }),
        success : function(data) {
            
            if($.trim(data)!=null){
                alert($.trim(data));
                location.href="mypage_profile.jsp";
            }

        }
    });

}

function delete_user(){

    let delete_check = confirm("계정을 삭제하시겠어요?");

    if(delete_check){
        $.ajax({
            url : "mypage_delete_Proc.jsp",
            data : ({
                member_key : $('input[name="member_key"]').val(),
            }),
            success : function(data) {
                
                if($.trim(data)!=null){
                    alert($.trim(data));
                    location.href="../../member/login.jsp";
                }
    
            }
        });
    }

}

function like_btn(like,content_key,member_key) {
    let like_check = like.classList.contains("bi-suit-heart");
    let like_count = like.nextElementSibling;
    let change_type = "";
    if(like_check){
       like.classList.replace("bi-suit-heart","bi-suit-heart-fill");
       change_type = "insert";
    }else{
       like.classList.replace("bi-suit-heart-fill","bi-suit-heart");
       change_type = "delete";
    }
 
    $.ajax({
       url : "../quiz/change_like_proc.jsp",
       data : ({
          content_key : content_key,
          member_key : member_key,
          change_type : change_type
       }),
       success : function() {
          if(like_check){
             like_count.innerText = Number(like_count.innerText)+1;
          }else{
             like_count.innerText = Number(like_count.innerText)-1;
          }
       }
   });
 
 }

 function delete_content(content_key,title) {

    let delete_check = confirm(`컨텐츠 (${title})를/을 삭제하시겠어요?`);

    if(delete_check){
        $.ajax({
            url : "mypage_content_delete_Proc.jsp",
            data : ({
                content_key : content_key,
            }),
            success : function(data) {
                
                if($.trim(data)!=null){
                    alert($.trim(data));
                    location.href="mypage_quiz.jsp?sort=my";
                }
    
            }
        });
    }

 }

 function update_content(content_key,title){

    let update_check = confirm(`컨텐츠 (${title})를/을 수정하시겠어요?`);

    if(update_check){
        location.href="../quiz/quiz_update.jsp?content_key="+content_key+"&start=start";
    }

 }

 function content_play(content_key){

    location.href="../quiz/quiz_play.jsp?content_key="+content_key;
 
 }

 function que_check(){
    if($('input[name="que_title"]').val()==""){
        $('input[name="que_title"]').focus();
        alert('문의명을 입력해주세요.');
        return false;
    }else if($('textarea[name="que_content"]').val()==""){
        $('textarea[name="que_content"]').focus();
        alert('문의내용을 입력해주세요.');
        return false;
    }

 }

 function que_update_msg(){
    alert('답변이 완료된 문의는 변경할 수 없습니다.');
    return false;
 }

function delete_question(member_key,question_key,title,pageNum,type){
    let delete_check = confirm(`문의 "${title}"을 삭제하시겠습니까?`);
    if(delete_check){
       location.href=`mypage_que_delete_Proc.jsp?member_key=${member_key}&question_key=${question_key}&pageNum=${pageNum}&queType=${type}`;
    }
 }

 $(function(){
    $(".bi-trash3-fill").on("click",function(event){
        event.stopPropagation();
     });
 })

 function view_question(member_key,question_key,pageNum,type){
    location.href=`mypage_view.jsp?member_key=${member_key}&question_key=${question_key}&pageNum=${pageNum}&queType=${type}`;
 }


 function settingChange() {
    let queType = $('.que_option').val();
    location.href=`mypage_questions.jsp?type=list&queType=${queType}`;
 }