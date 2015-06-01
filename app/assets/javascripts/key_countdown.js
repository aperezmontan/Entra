function availableIn(startDate){
  $("#available_in").countdown(startDate, function(event) {
    $(this).text(
      event.strftime('%D days %H:%M:%S')
    );
  });
}