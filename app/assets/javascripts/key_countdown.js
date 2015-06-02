function availableIn(startDate){
  $("#available-in").countdown(startDate, function(event) {
    var countDown = event.strftime('%D days %H:%M:%S');
    if(countDown != "00 days 00:00:00"){
      $(this).text(countDown);      
    } else {
      $('#lock-container').html("<%= escape_javascript(render partial: 'places/giant_lock', locals: { name: @key.guest.name, id: @key.id, place_name: @key.place.nickname, tag: 'key'}) %>");
    }
  });
}