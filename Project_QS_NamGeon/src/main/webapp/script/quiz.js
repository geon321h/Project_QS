function pop_content_info_Close() {
    var modalPop = $('.create_modal_wrap');
    var modalBg = $('.create_modal_bg');
 
    $(modalPop).hide();
    $(modalBg).hide();
 
 }

 $(function(){
     $('.file_box').click(function(){
         $('#thumbnail_file').click();
     })
     let thumbnail;
     $('#thumbnail_file').change(function(){
        thumbnail = this.files[0];
        //console.log(thumbnail);
        let reader = new FileReader();
        reader.readAsDataURL(thumbnail);

        reader.onload = function(){
            $('.image_box').show();
            $('.file_box').hide();
            $('.thumbnail_image').attr('src', reader.result);
        };
     })

     $('.image_box').mouseover(function(){
        $('.thumbnail_image').css('filter','brightness(70%)');
        $('#thumbnail_delete').show();
     })

     $('.image_box').mouseout(function(){
        $('.thumbnail_image').css('filter','brightness(100%)');
        $('#thumbnail_delete').hide();
     })

     $('#thumbnail_delete').click(function(){
         $('.thumbnail_image').attr('src', '');
         $('.thumbnail_image').css('filter','brightness(100%)');
         $('#thumbnail_delete').hide();
         $('.image_box').hide();
         $('.file_box').show();
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

 })

 function content_info_check(blank_pass){

    if($('input[name="title"]').val()==""){
        $('#title_msg').html("제목을 입력해주세요.");
        $('input[name="title"]').focus();
        blank_pass = false;
    }
    if($('textarea[name="explanation"]').val()==""){
        $('#explanation_msg').html("설명을 입력해주세요.");
        $('input[name="explanation"]').focus();
        blank_pass = false;
    }
    if($('input[name="thumbnail"]').val()==""){
        $('#thumbnail_msg').html("썸네일을 추가해주세요.");
        blank_pass = false;
    }

    return blank_pass;
 }


