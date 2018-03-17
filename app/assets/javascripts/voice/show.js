$(window).on('load', function(){
    $("[id^=voice]").children('.serif').on("click", function(){
        $(this).parent().find("[id^=audio]").get(0).play();
    });
});