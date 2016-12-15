/* global $ */


$(document).ready(function(){
    var textarea = document.getElementById('comment-field');
    $(textarea).on("keydown",function(e){
        if(e.which == 13){
            $(this).closest('form').submit();
            $(textarea).val("");
            return false;
        }
    });
});


$(document).ready(function() {
    $(document).find("#show-comments-btn").each(function() {
        $(this).click(function () {
            $(this).css('background', 'yellow');
            $(this).closest(".content").find(".fb-comments").show();
            console.log($(this).attr("id"));
        });
        console.log("dupa");
    });
});