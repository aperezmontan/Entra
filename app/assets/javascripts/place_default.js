$(document).on('ready page:load', function(){
  $('#default-container').on('click','a.default-place',setDefault);
});

var setDefault = function(event){
  event.preventDefault();
  var placeId = $(event.target).data('place-id');
  var action = $(event.target).data('action');
  $.ajax({
      url: '/place/' + placeId + '/default',
      method: 'PUT',
      data: {action:action}
    }).done(function ( response ) {
      console.log(response);
      updateDefaultContainer(placeId,action);
    }).fail(function(jqXHR,textStatus){
      
    });
}

var updateDefaultContainer = function(placeId,action){
  console.log(action)
  var linkLabel = "";
  if(action == 'remove-default'){
    linkLabel = 'Set this place as your default'
    action = 'set-default'
  } else {
    action = 'remove-default'
    linkLabel = "This is your default place"
  }
  var linkHtml = "<a href='#' class='default-place' data-place-id='";
  linkHtml += placeId + "' data-action='";
  linkHtml += action + "' >"+linkLabel+"</a>";
  $("#default-container").html(linkHtml);
}