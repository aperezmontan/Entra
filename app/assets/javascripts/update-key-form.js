$(document).on('ready page:load', function(){

  unlimitedAccessToggle();
  extendAccess();

  $('#keys_container').on('click','.revoke-access',revokeAccess);
  $('#keys_container').on('click','.grant-unlimeted-access',grantAccess);

})

var extendAccess = function(){
  $('#form-drop-down').on('click','#extend-access-container li a', function(event){
    event.preventDefault();
    console.log($(this).attr('id'))
    if ( $(this).attr('id') === '48_hours') {
      extendAccessAJAX(2, '48hrs')
    } else if ( $(this).attr('id') === '3_days') {
      extendAccessAJAX(3, '3 days')
    } else if ( $(this).attr('id') === '1_week') {
      extendAccessAJAX(7, '1 week')
    } else if ( $(this).attr('id') === '2_weeks') {
      extendAccessAJAX(14, '2 weeks')
    } else if ( $(this).attr('id') === '1_month') {
      extendAccessAJAX(30, '1 month')
    };
  })
}

var extendAccessAJAX = function(days, message){
  var keyId = $('.secret-url').data('key-id')
  $.ajax({
    url: '/keys/' + keyId ,
    method: 'PUT',
    data: {add_days: days, key: {unlimited_access: false}}
  })
  .done(function ( response ) {
    clearInterval(refreshTime);
    $('.key-expires-in').val('This key expires in ' + message);
  })
  .fail(function(jqXHR,textStatus){
    /* code ... */
  })
  .always(function(jqXHR,textStatus){
    /* code ... */
  });
}

var unlimitedAccessToggle = function(){
  $('#form-drop-down').on('change', '#give-unlimited-access', function(event){
    var keyId = $('.secret-url').data('key-id')
    if (this.checked) {
      $.ajax({
        url: '/keys/' + keyId,
        method: 'PUT',
        data: {key: {unlimited_access: true}}
      })
      .done(function ( response ) {
        clearInterval(refreshTime);
        $('.key-expires-in').val('This key has unlimited access');
        $('#form-drop-down').find('#extend-access-container').hide()
      })
      .fail(function(jqXHR,textStatus){
        /* code ... */
      })
      .always(function(jqXHR,textStatus){
        /* code ... */
      });
    } else if (!this.checked) {
      $.ajax({
        url: '/keys/' + keyId,
        method: 'PUT',
        data: {add_days: '1', key: {unlimited_access: false}}
      })
      .done(function ( response ) {
        $('.key-expires-in').val('This key expires in 24hrs');
        $('#form-drop-down').find('#extend-access-container').show()
      })
      .fail(function(jqXHR,textStatus){
        /* code ... */
      })
      .always(function(jqXHR,textStatus){
        /* code ... */
      });
    };

  })
};

var revokeAccess = function(event){
  var params = {add_days: '1', key: {unlimited_access: false}, partial: true};
  updateKeyAndGetPartial(event,params);
}

var grantAccess = function(event){
  var params = {key: {unlimited_access: true}, partial: true};
  updateKeyAndGetPartial(event,params);
}

var updateKeyAndGetPartial = function(event,params){
  event.preventDefault();
  var keyId = $(event.target).data('key-id');
  $.ajax({
      url: '/keys/' + keyId,
      method: 'PUT',
      data: params
    })
    .done(function ( response ) {
      var $content = $($.parseHTML(response));
      $('#key_' + keyId).html($content.html());
    })
    .fail(function(jqXHR,textStatus){
      /* code ... */
    })
    .always(function(jqXHR,textStatus){
      /* code ... */
    });
}