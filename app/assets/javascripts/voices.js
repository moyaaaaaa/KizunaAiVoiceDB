$(window).load(function(){
    $("[id^=voice]").on("click", function(){
        $(this).find("[id^=audio]").get(0).play();
    });
});
