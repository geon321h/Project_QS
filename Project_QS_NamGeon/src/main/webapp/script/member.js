

$(function(){

    // 로그인 및 비밀번호 찾기 페이지 //
    $('input[name="user_email"]').keydown(function(){
        $('.error_msg_wrap').empty();
    })
    $('input[name="user_password"]').keydown(function(){
        $('.error_msg_wrap').empty();
    })
    $('input[name="user_name"]').keydown(function(){
        $('.error_msg_wrap').empty();
    })
   
});

function login_check() {
    let login_pass = false;
    
    $.ajax({
        url : "login_Proc.jsp",
        data : ({
            user_email : $('input[name="user_email"]').val(),
            user_password : $('input[name="user_password"]').val()
        }),
        async: false,
        success : function(data) {
            // console.log(data);
            data = $.trim(data).substr(0,$.trim(data).indexOf('.')+1);
            // console.log(data);

            if($('input[name="user_email"]').val()==""){
                $('input[name="user_email"]').focus();
                $('.error_msg_wrap').html("이메일을 입력해주세요.").css('color','var(--bs-danger)');
            }else if($('input[name="user_password"]').val()==""){
                $('input[name="user_password"]').focus();
                $('.error_msg_wrap').html("비밀번호를 입력해주세요.").css('color','var(--bs-danger)');
            }else if(data == "아이디 혹은 비밀번호가 틀립니다."){
                $('input[name="user_email"]').focus();
                $('.error_msg_wrap').html(data).css('color','var(--bs-danger)');
            }else{
                login_pass = true;
            }
        }
    });
    console.log(login_pass);
    if(!login_pass){
        return false;
    }

}

function passwd_find() {

    $.ajax({
        url : "password_find_Proc.jsp",
        data : ({
            user_email : $('input[name="user_email"]').val(),
            user_name : $('input[name="user_name"]').val()
        }),
        success : function(data) {
            console.log(data);
            
            if($('input[name="user_name"]').val()==""){
                $('input[name="user_name"]').focus();
                $('.error_msg_wrap').html("이름을 입력해주세요.");
            }else if($('input[name="user_email"]').val()==""){
                $('input[name="user_email"]').focus();
                $('.error_msg_wrap').html("이메일을 입력해주세요.");
            }else if($.trim(data) == "X"){
                $('input[name="user_email"]').focus();
                $('.error_msg_wrap').html("일치하는 계정이 없습니다.");
            }else{
                let user_name = $('input[name="user_name"]').val();
                console.log(user_name)
                $('.passwd_find_text').html(user_name+"님의 비밀번호는 <span style='color: #333;font-size: 1.8rem;font-family:NanumSquare_EB;'>\""+data+"\"</span> 입니다.")
                                        .css('font-size','1.3rem')
                                        .css('margin-top','100px')
                                        .css('margin-bottom','100px')
                                        .removeClass( 'mb-5' );
                $('.passwd_find_wrap').css('display','none');
                $('.btn_find').css('display','none');
                $('.btn_back').css('display','');
            }
        }
    });

}

