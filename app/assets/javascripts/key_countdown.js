function availableIn(startDate){
  $("#available-in").countdown(startDate, function(event) {
    $(this).text(
      event.strftime('%D days %H:%M:%S')
    );
  });
}