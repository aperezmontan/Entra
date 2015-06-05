$(document).on('ready page:load', function(){

  // $('#unlock-message').css('display', 'none')
  // $('#giant-lock').on('mouseenter', function(event){
  //   $('#unlock-message').fadeIn('slow')
  // })
  // $('#giant-lock').on('mouseleave', function(event){
  //   $('#unlock-message').fadeOut('slow')
  // })

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
    openLock(event);
    setTimeout(function(){
      closeLock(event);
      ensureFalse();
    }, 5000);
  })
  .fail(function(jqXHR,textStatus){
    ensureFalse();
  })
  .always(function(response){
  });
}

var openLock = function(event){
  $(event.target).attr('class', 'fa fa-unlock-alt');
  $(event.target).attr('id', 'giant-lock-opened');
}

var closeLock = function(event){
  $(event.target).attr('class', 'fa fa-lock');
  $(event.target).attr('id', 'giant-lock');
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
    openLock(event);
    setTimeout(function(){
      closeLock(event);
      location.reload();
    }, 5000);
  })
}
