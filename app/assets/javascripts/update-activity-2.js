$(document).on('ready page:load', function(event){
  var placeId = $('#giant-lock').data('place-id')
    updateActivity(lastUpdate(), placeId);
})

var updateActivity = function(time, placeId){
  console.log('last',time)
  $.ajax({
    url: '/logs',
    method: 'GET',
    data: {from_time: time, place_id: placeId}
  })
  .done(function(response){
    console.log('resp',response)
    logFormat(response);
    setTimeout(function(){
      updateActivity(lastUpdate(time), placeId);
    },1000);
  });
}

var lastDate;

var lastUpdate = function(rails_time){
  var lastDate = Date.now()
  if ($('#activityList span:first-of-type').data('log-time') === undefined){
    return lastDate;
   } else{
    // val = dateObj.getTime();
    lastDate = new Date($('#activityList span:first-of-type').data('log-time'))
    console.log('last time in log', lastDate.getTime())

    if (rails_time >= lastDate.getTime()){
      lastDate = lastDate.getTime() + 1000;
      // console.log('lastDate',lastDate.getTime(), 'rails_time', rails_time)
      return lastDate
    }
    // console.log('lastDate',lastDate.getTime(), 'rails_time', rails_time)
    // return lastDate.getTime()
    // console.log('lastDate',lastDate.getTime())
  }
}

var logFormat = function(newLogs){
  var html = "<i class='{i_tag_class}'></i><span data-log-time='{created_at}'> {message} <span class='timestamp'>{timeAgo}</span></span></br>";
  newLogs.forEach(function(log){
    var logdate = new Date(log['created_at'])
    var ld = new Date(lastUpdate())
    if(logdate > ld){
      $('#activityList div').remove();
      if (log['message'].indexOf("SUCCESS") > -1){
        var message = log['message'].substring(9,log['message'].length)
        $('#activityList').prepend(parseLog(html,log,message,"fa fa-check",moment(log['created_at']).fromNow()));
      } else {
        var message = log['message'].substring(10,log['message'].length)
        $('#activityList').prepend(parseLog(html,log,message,"fa fa-times",moment(log['created_at']).fromNow()));
      }
      $('#activityList i:first-child').hide().fadeIn('slow')
    }
  })
}

var parseLog = function(html,log,message,i_tag_class,ago){

  html = html.replace('{created_at}',log['created_at']);
  html = html.replace('{message}',message);
  html = html.replace('{i_tag_class}',i_tag_class);
  html = html.replace('{timeAgo}',ago);
}

  setInterval(function() {
    var thing = "";
    console.log('updating time since last activity...');
    var logSpans = $('#activityList>span');
    $.each(logSpans, function(i,v){
      $(v).find('.timestamp').html(" " + moment($(v).data('log-time')).fromNow()).fadeIn('slow');
    });
}, 15000);