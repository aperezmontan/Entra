$(document).on('ready page:load', function(){

  $('#unlock-message').css('display', 'none')
  $('#giant-lock').on('mouseenter', function(event){
    $('#unlock-message').fadeIn('slow')
  })
  $('#giant-lock').on('mouseleave', function(event){
    $('#unlock-message').fadeOut('slow')
  })

  $('#giant-lock').on('click', giantLockClicked);

})

var giantLockClicked = function(event){
  if($(event.target).data('place-id')){
    giantLockForPlaceFn(event);
  } else {
    giantLockForGuestFn(event);
  }
}

var giantLockForPlaceFn = function(event){
  place_url = '/places/' + $(event.target).data('place-id')
  $.ajax({
    method: 'PUT',
    url: place_url + '?o=t'
  })
  .done(function ( response ) {
    console.log(response)
      $(event.target).attr('class', 'fa fa-unlock-alt');
      $(event.target).attr('id', 'giant-lock-opened');
    setTimeout(function(){
      $(event.target).attr('class', 'fa fa-lock')
      $(event.target).attr('id', 'giant-lock')
      ensureFalse();
    }, 4000);
  })
  .fail(function(jqXHR,textStatus){
    ensureFalse();
  })
  .always(function(response){
  });
}

var ensureFalse = function(){
  $.ajax({
    method: 'PUT',
    url: place_url
  })
  .done(function ( response ) {
    console.log(response)
  })
};

var giantLockForGuestFn = function(event){
  $.ajax({
    method: 'PUT',
    url: "/keys/" + $(event.target).data('key-id'),
    data: { key:{ requested: 'true' }}
  }).done(function ( response ) {
    location.reload();
  })
}
