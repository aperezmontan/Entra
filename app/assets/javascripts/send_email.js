$(document).on('ready page:load', function(){
  $("#form-drop-down").on('click','.show-send-email',showEmailFieldGuest); 
  $("#form-drop-down").on('click','#send-email',sendEmailToGuest); 
});

var showEmailFieldGuest = function(event){
  event.preventDefault();
  $("#email-field-container").fadeIn('slow');
}

var sendEmailToGuest = function(event){  
  var email = $("#guest-email").val();
  var url_parts = $("#key_sc").val().split('/');
  var key_sc = url_parts[url_parts.length - 1] 
  var url = "/send_email";
  var params = {email:email,sc_url: key_sc}
  $.post(url,params,function(response){
    $("#email-field-container").fadeOut('slow');
  });
}