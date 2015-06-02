$(document).on('ready page:load', function(){

  $('#form-drop-down').on('click', '.delete-key', function(event){

    var keyId = $('#form-drop-down').find('.secret-url').data('key-id');
    console.log(keyId)
    $.ajax({
      url: '/keys/' + keyId,
      method: 'delete'
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

  $('#form-drop-down').on('click', '#cancel-form', function(event){
    event.preventDefault();
    $('#form-drop-down').html('<hr>');
  });


})