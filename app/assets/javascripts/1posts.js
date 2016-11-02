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