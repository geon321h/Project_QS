// 전체 선택 기능 //
function choiceAll(obj){ 
    let rcheck = document.getElementsByName("rowcheck"); 
    let check = obj.checked;
    if(check){
        for(let i=0;i<rcheck.length;i++){
            rcheck[i].checked = true;
        }
    }else{
        for(let i=0;i<rcheck.length;i++){
            rcheck[i].checked = false;
        }
    }
}

function ban_member(){
    let rcheck = document.getElementsByName("rowcheck"); 
    let rowcheck_value =[];
    let flag = false;
    let flag_ban = false;
    
    for(let i=0;i<rcheck.length;i++){
        if(rcheck[i].checked){
            if(rcheck[i].classList.contains('ban_check')){
                // console.log("ban");
                flag_ban = true;
            }else{
                rowcheck_value.push(rcheck[i].value); 
                flag=true;
            }
        }
    }
    if(flag_ban){
        alert("활동 정지되지 않은 회원만 선택해주세요.");
        document.getElementsByName("checkAll")[0].checked =false; 
        for(let i=0;i<rcheck.length;i++){
            rcheck[i].checked = false;
        }
    }else if(flag){
        $.ajax({
            url : "ban_proc.jsp",
            traditional: true,
            data : ({
                rowcheck : rowcheck_value,
                ban : "Y",
            }),
            success : function(data) {
                if($.trim(data)>0){
                    // console.log("밴성공");
                    alert(`회원 ${$.trim(data)}명을 활동정지 상태로 변경했습니다.`);
                    location.href="member_admin.jsp";
                }
            }
        });
    }else{
        alert("활동 정지할 회원을 선택해주세요.");
    }
}

function ban_off_member(){

    let rcheck = document.getElementsByName("rowcheck"); 
    let rowcheck_value =[];
    let flag = false;
    let flag_ban = false;
    
    for(let i=0;i<rcheck.length;i++){
        if(rcheck[i].checked){
            if(rcheck[i].classList.contains('ban_check')){
                rowcheck_value.push(rcheck[i].value); 
                flag=true;
            }else{
                flag_ban = true;
            }
        }
    }
    if(flag_ban){
        alert("활동정지된 회원만 선택해주세요.");
        document.getElementsByName("checkAll")[0].checked =false; 
        for(let i=0;i<rcheck.length;i++){
            rcheck[i].checked = false;
        }
    }else if(flag){
        $.ajax({
            url : "ban_proc.jsp",
            traditional: true,
            data : ({
                rowcheck : rowcheck_value,
                ban : "N",
            }),
            success : function(data) {
                if($.trim(data)>0){
                    //console.log("밴해제 성공");
                    alert(`회원 ${$.trim(data)}명의 활동정지 상태를 해제했습니다.`);
                    location.href="member_admin.jsp";
                }
            }
        });
    }else{
        alert("활동 정지를 해제할 회원을 선택해주세요.");
    }
}

function delete_quiz(){
    console.log(1);
    let rcheck = document.getElementsByName("rowcheck"); 
    let rowcheck_value =[];
    let flag = false;
    
    for(let i=0;i<rcheck.length;i++){
        if(rcheck[i].checked){
            rowcheck_value.push(rcheck[i].value); 
            flag=true;
        }
    }
    if(flag){
        $.ajax({
            url : "delete_quiz_admin_proc.jsp",
            traditional: true,
            data : ({
                rowcheck : rowcheck_value,
            }),
            success : function(data) {
                if($.trim(data)>0){
                    alert(`${$.trim(data)}개의 컨텐츠를 삭제했습니다.`);
                    location.href="quiz_admin.jsp";
                }
            }
        });
    }else{
        alert("삭제할 컨텐츠를 선택해주세요.");
    }
}

