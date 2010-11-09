$(document).ready(function(){
    $(".field_with_errors > input").css("border", "2px solid red");
    $(".field_with_errors > label").css("color", "red");
    $(".field_with_errors > textarea").css("border", "2px solid red");
});


$(document).ready(function(){
    $(".edit_comment_link").click(function(){
        var klass = $(this).attr("class").split(" ")[0];
        $("." + klass + "_form").slideToggle("slow");
        return false;
    });

});


$(document).ready(function(){
    $('.question-comment-link').click(function(){
        var klasses = $(this).attr('class');
        var comment_box_klass = klasses.split(" ")[0];
        $("." + comment_box_klass + "_form").slideToggle("slow");
        return false;
    });
})