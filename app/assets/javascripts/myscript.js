
$(document).ready(function(){
    $('.wish-list').click(function(){
      window.open('https://twitter.com/TGots7?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor', "_blank");
  })
    $('.gotto-marry').click(function(){
      window.open('http://www.gottomarrygrace.com', "_blank");
  })
    $('.storypage').click(function(){
      window.open('http://www.gottomarrygrace.com/story.php', "_blank");
  })
    $('.email-button').on("click", function(e){
      
      url = "/users"
      data = {
        'authenticity_token': $("input[name='authenticity_token']").val(),
        'user': {'name': $('#user_name').val(),
        'email': $('#user_email').val()
        }
      };
      $.ajax({
        type: "POST",
        url: url,
        data: data,
        success: function(response){
          $('#user_name').val("")
          $('#user_email').val("")
          $('#call_to_action').hide()
          var $cta = $('#call_to_action2')
          $cta.html(response);
        }
      })
      
      e.preventDefault();
  })
});