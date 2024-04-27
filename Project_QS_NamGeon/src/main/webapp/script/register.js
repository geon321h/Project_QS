let email_pass = true;
let name_pass = true;
let passwd_check_pass = true;

$(function(){

// 회원가입 페이지 //
    
    /* 이메일 */
    $('input[name="email"]').keydown(function(){
        $('#email_msg').empty();
    })

    let regex_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])+@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])+\.[a-zA-Z]{2,3}$/;
    $('input[name="email"]').keyup(function(){
        let email = $('input[name="email"]').val();
        if(email.match(regex_email)==null && email!=""){
            $('input[name="email"]').focus();
            $('#email_msg').html("이메일 형식으로 입력해주세요.");
            email_pass = true;
        }else{
            email_pass = false;
        }
    })

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

    /* 휴대전화번호 성별 */
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

    $('input[name="gender"]').change(function(){
        $('#phone_gender_msg').empty();
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

});

function register_check() {

    let blank_pass = false;
    let duplicate_pass = false;
    duplicate(blank_pass,duplicate_pass);
    
    

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
    }else if($("input[name='gender']:checked").length==0){
        $('#phone_gender_msg').html("성별을 선택해주세요.");
        blank_pass = false;
    }

    let regex_passwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/
    let pw = $('input[name="password"]').val();

    if( $('input[name="password"]').val()==""){
        $('input[name="password"]').focus();
        $('#passwd_msg').html("비밀번호를 입력해주세요.");
        blank_pass = true; 
    }else if( $('input[name="password_re"]').val()==""){
        $('input[name="password_re"]').focus();
        $('#passwd_msg').html("비밀번호 확인을 해주세요.");
        blank_pass = true; 
    }else if(pw.match(regex_passwd)==null){
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
    }

}

function duplicate(blank_pass,duplicate_pass){

    $.ajax({
        url : "duplicate_proc.jsp",
        data : ({
            user_email : $('input[name="email"]').val(),
        }),
        async: false,
        success : function(data) {
            
            if($('input[name="email"]').val()==""){
                $('input[name="email"]').focus();
                $('#email_msg').html("이메일을 입력해주세요.");
                blank_pass = true; 
            }else if(email_pass){
                $('input[name="email"]').focus();
                $('#email_msg').html("이메일 형식으로 입력해주세요.");
                blank_pass = true; 
            }else if($.trim(data) == "exist"){
                $('input[name="email"]').focus();
                $('#email_msg').html("이미 사용중인 이메일입니다.");
                duplicate_pass = true; 
            }
        }
    });

}
