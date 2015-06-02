$(document).on('ready page:load', function(){

  $('#unlock-message').css('display', 'none')
  $('#giant-lock').on('mouseenter', function(event){
    $('#unlock-message').fadeIn('slow')
  })
  $('#giant-lock').on('mouseleave', function(event){
    $('#unlock-message').fadeOut('slow')
  })



  $('#giant-lock').on('click', function(event){

    $(event.target).attr('class', 'fa fa-unlock-alt');
    $(event.target).attr('id', 'giant-lock-opened');
    $.ajax({
      method: 'PUT',
      url: '/places/' + $(event.target).data('place-id')
    })
    .done(function ( response ) {
      console.log(response)
      setTimeout(function(){
        $(event.target).attr('class', 'fa fa-lock')
        $(event.target).attr('id', 'giant-lock')
      }, 3000);
    })
    .fail(function(jqXHR,textStatus){
      /* code ... */
    })
    .always(function(jqXHR,textStatus){
      /* code ... */
    });

  })






})