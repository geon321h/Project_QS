function pop_content_info_Close() {
    var modalPop = $('.create_modal_wrap');
    var modalBg = $('.create_modal_bg');
 
    $(modalPop).hide();
    $(modalBg).hide();
 
 }

 function pop_quiz_Open() {
    var modalPop = $('.create_quiz_modal_wrap');
    var modalPop2 = $('.choice_quiz_modal_wrap');
    var modalBg = $('.create_modal_bg');
 
    $(modalPop).show();
    $(modalPop2).show();
    $(modalBg).show();
 
 }

 function pop_quiz_Close() {
    var modalPop = $('.create_quiz_modal_wrap');
    var modalPop2 = $('.choice_quiz_modal_wrap');
    var modalBg = $('.create_modal_bg');
 
    $(modalPop).hide();
    $(modalPop2).hide();
    $(modalBg).hide();
 
 }

 $(function(){
   
   $(".like_add_btn").on("click",function(event){
      event.stopPropagation();
   });

   // 컨텐츠 정보 - 파일업로드 //
   $('#thumbnail_file_box').click(function(){
      $('#thumbnail_file').click();
   })
   let thumbnail;
   $('#thumbnail_file').change(function(){
      thumbnail = this.files[0];
      let reader = new FileReader();
      reader.readAsDataURL(thumbnail);
      
      reader.onload = function(){
         $('#thumbnail_image_box').show();
         $('#thumbnail_file_box').hide();
         $('.thumbnail_image').attr('src', reader.result);
      };
   })

   $('#thumbnail_image_box').mouseover(function(){
      $('.thumbnail_image').css('filter','brightness(70%)');
      $('#thumbnail_delete').show();
   })

   $('#thumbnail_image_box').mouseout(function(){
      $('.thumbnail_image').css('filter','brightness(100%)');
      $('#thumbnail_delete').hide();
   })

   $('#thumbnail_delete').click(function(){
      $('.thumbnail_image').attr('src', '');
      $('#thumbnail_file').val("");
      $('.thumbnail_image').css('filter','brightness(100%)');
      $('#thumbnail_delete').hide();
      $('#thumbnail_image_box').hide();
      $('#thumbnail_file_box').show();
   })

   $('input[name="title"]').keydown(function(){
      $('#title_msg').empty();
   })
   $('textarea[name="explanation"]').keydown(function(){
      $('#explanation_msg').empty();
   })
   $('input[name="thumbnail"]').change(function(){
      $('#thumbnail_msg').empty();
   })

   // 퀴즈 파일 //

   $('#quiz_file_box').click(function(){
      $('#quiz_file').click();
   })

   let quiz_image;
   $('#quiz_file').change(function(){
      quiz_image = this.files[0];
      //console.log(thumbnail);
      let reader = new FileReader();
      reader.readAsDataURL(quiz_image);

      reader.onload = function(){
         $('#quiz_image_box').show();
         $('#quiz_file_box').hide();
         $('.quiz_image').attr('src', reader.result);
      };
   })

   $('#quiz_image_box').mouseover(function(){
      $('.quiz_image').css('filter','brightness(70%)');
      $('#quiz_delete').show();
   })

   $('#quiz_image_box').mouseout(function(){
      $('.quiz_image').css('filter','brightness(100%)');
      $('#quiz_delete').hide();
   })

   $('#quiz_delete').click(function(){
      $('.quiz_image').attr('src', '');
      $('#quiz_file').val("");
      $('.quiz_image').css('filter','brightness(100%)');
      $('#quiz_delete').hide();
      $('#quiz_image_box').hide();
      $('#quiz_file_box').show();
   })



 })

 function content_info_check(blank_pass){

    if($('input[name="title"]').val()==""){
        $('#title_msg').html("제목을 입력해주세요.");
        $('input[name="title"]').focus();
        blank_pass = false;
    }
    if($('textarea[name="explanation"]').val()==""){
        $('#explanation_msg').html("설명을 입력해주세요.");
        $('textarea[name="explanation"]').focus();
        blank_pass = false;
    }
    if($('input[name="thumbnail"]').val()=="" && $('.thumbnail_image').attr('src')==""){
        $('#thumbnail_msg').html("썸네일을 추가해주세요.");
        blank_pass = false;
    }

    return blank_pass;
 }


 // 퀴즈 타입 정하기 //
let Quiz_type = 1;
 function type_1_setting(){
   $('#quiz_box_area').hide();
   $('#example_box_area').hide();
   $('#quiz_delete').click();
   $('input[name="example"]').val("");
   $('#quiz_type_value').val(1);
   Quiz_type = 1;
 }
 function type_2_setting(){
    $('#quiz_box_area').show();
    $('#example_box_area').hide();
    $('input[name="example"]').val("");
    $('#quiz_type_value').val(2);
    Quiz_type = 2;
   }
   function type_3_setting(){
   $('#example_box_area').show();
   $('#quiz_box_area').hide();
   $('#quiz_delete').click();
   $('#quiz_type_value').val(3);
   Quiz_type = 3;
 }

 // 퀴즈 생성 버튼 //

function quiz_check() {
   let blank_pass = true;
   blank_pass = quiz_blank_check(blank_pass);
   if(!blank_pass){
      return false
   }
}

function quiz_blank_check(blank_pass){

   if($('input[name="question"]').val()==""){
       $('#question_msg').html("문제를 입력해주세요.");
       $('input[name="question"]').focus();
       blank_pass = false;
   }
   if($('input[name="answer"]').val()==""){
       $('#answer_msg').html("정답을 입력해주세요.");
       $('input[name="answer"]').focus();
       blank_pass = false;
   }
   if(Quiz_type == 2){
      if($('input[name="image"]').val()=="" && $('.quiz_image').attr('src')==""){
         $('#image_msg').html("이미지를 추가해주세요.");
         blank_pass = false;
     }
   }else if(Quiz_type == 3){
      if($('.example1').val()==""){
          $('#example_msg').html("보기를 모두 입력해주세요.");
          $('.example1').focus();
          blank_pass = false;
      }
      if($('.example2').val()==""){
          $('#example_msg').html("보기를 모두 입력해주세요.");
          $('.example2').focus();
          blank_pass = false;
      }
      if($('.example3').val()==""){
          $('#example_msg').html("보기를 모두 입력해주세요.");
          $('.example3').focus();
          blank_pass = false;
      }
      if($('.example4').val()==""){
          $('#example_msg').html("보기를 모두 입력해주세요.");
          $('.example4').focus();
          blank_pass = false;
      }
   }

   return blank_pass;
}

$(function(){
   $('input[name="question"]').keydown(function(){
      $('#question_msg').empty();
   })
   $('input[name="answer"]').keydown(function(){
      $('#answer_msg').empty();
   })
   $('input[name="example"]').keydown(function(){
      $('#example_msg').empty();
   })
   $('input[name="image"]').change(function(){
      $('#image_msg').empty();
   })

})

// 퀴즈 생성버튼 //
function create_quiz_list(last_question,last_type){
   $('#quiz_list_form').attr("action","quiz_list_add.jsp");
   $('input[name="question"]').val(last_question);
   $('#quiz_delete').click();
   $('input[name="answer"]').val("");
   $('input[name="example"]').val("");

   if(last_type == 1){
      type_1_setting();
   }else if(last_type == 2){
      type_2_setting();
   }else if(last_type == 3){
      type_3_setting();
   }

   pop_quiz_Open();
}

// 퀴즈 수정하기 //
function update_quiz_list(number,type,question,answer,example,image){
   $('#quiz_delete').click();
   $('input[name="example"]').val("");
   if(type==1){
      type_1_setting();
   }else if(type==2){
      type_2_setting();
      $('#quiz_image_box').show();
      $('#quiz_file_box').hide();
      $('.quiz_image').attr('src', image);
   }else if(type==3){
      let example_arr = example.split(' ');
      $('.example1').val(example_arr[0]);
      $('.example2').val(example_arr[1]);
      $('.example3').val(example_arr[2]);
      $('.example4').val(example_arr[3]);
      type_3_setting();
   }
   $('input[name="question"]').val(question);
   $('input[name="answer"]').val(answer);

   $('#quiz_list_form').attr("action","quiz_list_update.jsp?number="+number);
   pop_quiz_Open();

}

function info_controller(title,explanation,thumbnail,content_public) {

   var modalPop = $('.create_modal_wrap');
   var modalBg = $('.create_modal_bg');
   
   $(modalPop).show();
   $(modalBg).show();

   $('input[name="title"]').val(title);
   $('textarea[name="explanation"]').val(explanation);
   if(content_public == 'Y'){
      $('input[name="content_public"]').prop('checked',true);
   }else{
      $('input[name="content_public"]').prop('checked',false);
   }
   $('input[name="title"]').val(title);

   $('#thumbnail_image_box').show();
   $('#thumbnail_file_box').hide();
   $('.thumbnail_image').attr('src', thumbnail);

}

function delete_controller(){
   location.href="quiz_create.jsp";
}

function insert_controller(quiz_count){
   if(quiz_count>0){
      location.href="quiz_add_proc.jsp";
   }else{
      alert("퀴즈를 1개 이상 추가해주세요.");
   }
}


// 퀴즈 메인 //
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
      url : "change_like_proc.jsp",
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



function settingChange(){
   
   $('#setting_form').submit();

}

function content_play(content_key){

   location.href="quiz_play.jsp?content_key="+content_key;

}

let timeoutId_quiz;
const vibration_quiz = (target) => {
    target.classList.add("vibration");
    setTimeout(function() {
      target.classList.remove("vibration");
    }, 400);
    timeoutId_quiz = setInterval(function() {
        target.classList.add("vibration");
        setTimeout(function() {
          target.classList.remove("vibration");
        }, 400);
    }, 1500);

}

const vibration_off_quiz = (target) => {
    clearTimeout(timeoutId_quiz);
    target.classList.remove("vibration");
}

function deleteComment(content_key,num,comment_key) {
   let comment_check = confirm("댓글을 삭제하시겠습니까?");

   if(comment_check){
      location.href="quiz_comment_delete.jsp?content_key="+content_key+"&num="+num+"&comment_key="+comment_key;
   }

}


// 퀴즈 수정하기 //

// 퀴즈 생성버튼 //
function create_quiz_list_update(last_question,last_type,content_key){
   $('#quiz_list_form').attr("action","quiz_list_add.jsp?content_key="+content_key);
   $('input[name="question"]').val(last_question);
   $('#quiz_delete').click();
   $('input[name="answer"]').val("");
   $('input[name="example"]').val("");

   if(last_type == 1){
      type_1_setting();
   }else if(last_type == 2){
      type_2_setting();
   }else if(last_type == 3){
      type_3_setting();
   }

   pop_quiz_Open();
}

// 퀴즈 수정하기 //
function update_quiz_list_update(number,type,question,answer,example,image,content_key){
   $('#quiz_delete').click();
   $('input[name="example"]').val("");
   if(type==1){
      type_1_setting();
   }else if(type==2){
      type_2_setting();
      $('#quiz_image_box').show();
      $('#quiz_file_box').hide();
      $('.quiz_image').attr('src', image);
   }else if(type==3){
      let example_arr = example.split(' ');
      $('.example1').val(example_arr[0]);
      $('.example2').val(example_arr[1]);
      $('.example3').val(example_arr[2]);
      $('.example4').val(example_arr[3]);
      type_3_setting();
   }
   $('input[name="question"]').val(question);
   $('input[name="answer"]').val(answer);

   $('#quiz_list_form').attr("action","quiz_list_update.jsp?number="+number+"&content_key="+content_key);
   pop_quiz_Open();

}

function info_controller_update(title,explanation,thumbnail,content_public) {

   var modalPop = $('.create_modal_wrap');
   var modalBg = $('.create_modal_bg');
   
   $(modalPop).show();
   $(modalBg).show();

   $('input[name="title"]').val(title);
   $('textarea[name="explanation"]').val(explanation);
   if(content_public == 'Y'){
      $('input[name="content_public"]').prop('checked',true);
   }else{
      $('input[name="content_public"]').prop('checked',false);
   }
   $('input[name="title"]').val(title);

   $('#thumbnail_image_box').show();
   $('#thumbnail_file_box').hide();
   $('.thumbnail_image').attr('src', thumbnail);

}

function delete_controller_update(){
   let delete_check = confirm("저장하지않고 수정을 취소하시겠습니까?");
   if(delete_check){
      location.href="../mypage/mypage_quiz.jsp?sort=my";
   }
}

function insert_controller_update(quiz_count,content_key){
   if(quiz_count>0){
      location.href="quiz_add_proc.jsp?content_key="+content_key;
   }else{
      alert("퀴즈를 1개 이상 추가해주세요.");
   }
}
