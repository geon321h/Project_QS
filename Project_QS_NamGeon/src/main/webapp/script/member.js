$(function(){

    $('input[name="user_email"]').keydown(function(){
        $('.error_msg_wrap').empty();
    })
    $('input[name="user_password"]').keydown(function(){
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
                $('.error_msg_wrap').html("이메일을 입력해주세요.").css('color','var(--bs-danger)');
            }else if($('input[name="user_password"]').val()==""){
                $('.error_msg_wrap').html("비밀번호를 입력해주세요.").css('color','var(--bs-danger)');
            }else if(data == "아이디 혹은 비밀번호가 틀립니다."){
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

function writeSave(){
    if(!isCheck){
        alert("아이디 중복체크를 해주세요.");
        return false;
    }else if(isBlack){
        alert("아이디를 입력해주세요.");
        $('input[name="id"]').focus();
        return false;
    }else if(!possible){
        alert("이미 사용중인 아이디입니다.");
        $('input[name="id"]').focus();
        return false;
    }else if(!pwCheck){
        alert("비밀번호 형식이 올바르지 않습니다.");
        $('input[name="id"]').focus();
        return false;
    }else if(!repwCheck){
        alert("비밀번호가 일치하지않습니다.");
        $('input[name="id"]').focus();
        return false;
    }

}