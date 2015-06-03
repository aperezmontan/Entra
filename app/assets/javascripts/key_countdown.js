$(document).on('ready page:load', function(){

  var twentyFourHours = (24 * 60 * 60 * 1000)
  $('#add-key').on('click', function(event){
    refreshTime = setInterval(function(){
      twentyFourHours -= 1000;
      $('#form-drop-down').find('.key-expires-in').val('This key expires in ' + convertMS(twentyFourHours));
    }, 1000);
  });
})

function convertMS(ms) {
  var d, h, m, s;
  s = Math.floor(ms / 1000);
  m = Math.floor(s / 60);
  s = s % 60;
  h = Math.floor(m / 60);
  m = m % 60;
  return h + 'hrs ' +  m + 'min & ' + s + 'sec';
};

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