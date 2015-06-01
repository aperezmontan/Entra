$(document).on('ready page:load', function(){

  addForm('#add-client', 'clients');
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

    $.ajax({
      method: 'GET',
      url: '/'+ type +'/new'
    })
    .done(function ( response ) {
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

  // function(event){

  //   $.ajax({
  //     method: 'GET',
  //     url: '/clients/new'
  //   })
  //   .done(function ( response ) {
  //     response = response + dropDownFooter;
  //     $('#form-drop-down').append(response);
  //   })
  //   .fail(function(jqXHR,textStatus){
  //     /* code ... */
  //   })
  //   .always(function(jqXHR,textStatus){
  //     /* code ... */
  //   });