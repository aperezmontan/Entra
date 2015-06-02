function availableIn(startDate){
  $("#available-in").countdown(startDate, function(event) {
    var countDown = event.strftime('%D days %H:%M:%S');
    if(countDown != "00 days 00:00:00"){
      $(this).text(countDown);      
    } else {
      location.reload();
    }
  });
}