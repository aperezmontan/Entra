$(document).on('ready page:load', function(){

  $('#form-drop-down').on('click', '#give-unlimited-access', function(event){

    $.ajax({
      url: '',
      method: 'PUT',
    })
    .done(function ( data ) {
      /* code ... */
    })
    .fail(function(jqXHR,textStatus){
      /* code ... */
    })
    .always(function(jqXHR,textStatus){
      /* code ... */
    });
  })

})