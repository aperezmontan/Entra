var fade_flash = function() {
  $(".alert").delay(2000).fadeOut("slow");
};

var flash_class = function(type){
  switch(type){
    case 'notice' : return "alert alert-info";
    case 'success' : return "alert alert-success"
    case 'error' : return "alert alert-danger"
    case 'alert' : return "alert alert-warning"
  }
}
var show_ajax_message = function(msg, type) {
  var flash_html = "<div class='" + flash_class(type) + " fade in'>";
  flash_html +=  "<a href='#' data-dismiss='alert' class='close'>×</a>";
  flash_html += msg + "</div>";
  $("#flash_msg_container").html(flash_html);
  fade_flash();
};

$( document ).ajaxComplete(function(event, request) {
  console.log('ajaxComplete')
    var msg = request.getResponseHeader('X-Message');
    var type = request.getResponseHeader('X-Message-Type');
    show_ajax_message(msg, type); //use whatever popup, notification or whatever plugin you want

});