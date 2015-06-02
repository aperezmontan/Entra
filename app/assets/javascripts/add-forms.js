$(document).on('ready page:load', function(){

  addForm('#add-guest', 'guests');
  addForm('#add-key', 'keys');
  addForm('#add-place', 'places');

  $('#form-drop-down').on('click', '#cancel-form', function(event){
    event.preventDefault();
    console.log($('#form-drop-down'))
    $('#form-drop-down').html('<hr>');
  });

})

var addForm = function(selector, type) {
  $(selector).on('click', function(event){
    data = $(event.target).data();

    $.ajax({
      method: 'GET',
      url: '/'+ type +'/new',
      data: data
    })
    .done(function ( response ) {
      console.log(data);
      response = response + dropDownFooter;
      $('#form-drop-down').append(response);
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
  "<a href='/' id='cancel-form'>Cancel</a>"+
  "<hr>";