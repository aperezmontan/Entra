$(document).on('ready page:load', function(){

  addForm('#add-guest', '/guests/new', 'GET');

  var placeId = $('#add-key').data('place-id')

  addForm('#add-key', '/keys?place_id=' + placeId, 'POST');
  addForm('#add-place', '/places/new', 'GET');

})

var addForm = function(selector, url, method, data) {
  $(selector).on('click', function(event){
    $.ajax({
      method: method,
      url: url,
    })
    .done(function ( response ) {
      response = response + dropDownFooter;
      $('#form-drop-down').html(response);
      if (selector == '#add-key') {
        $('#add-key').hide();
        $('#form-drop-down').find('#cancel-form').addClass('delete-key')
        $("#form-drop-down").find(".secret-url").select();
      }
    })
    .fail(function(jqXHR,textStatus){
      /* code ... */
    })
    .always(function(jqXHR,textStatus){
      /* code ... */
    });
  });
}


var dropDownFooter =
  "<a href='/' id='cancel-form'>Cancel And Delete</a>"+
  "<hr>";