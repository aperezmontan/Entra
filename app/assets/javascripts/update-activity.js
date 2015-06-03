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
      updateActivity(lastUpdate(), placeId);
    },700);
  });
}

var logFormat = function(newLogs){
  var html = "<i class='{i_tag_class}'></i><span data-log-time='{created_at}'> {message} <span class='timestamp'>{timeAgo}</span> ago</span></br>";
  newLogs.forEach(function(log){
    var logdate = new Date(log['created_at'])
    var ld = new Date(lastUpdate())
    if(logdate > ld){
      $('#activityList div').remove();
      if (log['message'].indexOf("SUCCESS") > -1){
        var message = log['message'].substring(9,log['message'].length)
        $('#activityList').prepend(parseLog(html,log,message,"fa fa-check",calculateSince(log['created_at'])));
      } else {
        var message = log['message'].substring(10,log['message'].length)
        $('#activityList').prepend(parseLog(html,log,message,"fa fa-times",calculateSince(log['created_at'])));
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
  console.log(html);
  html = html.replace('just now</span> ago', 'just now</span>');
  return html;
}

var lastDate;

var lastUpdate = function(){
  if ($('#activityList span:first-of-type').data('log-time') === undefined){
    if(!lastDate) lastDate = Date.now();
    return lastDate;
   } else{
    return $('#activityList span:first-of-type').data('log-time')
  }
}

  setInterval(function() {
    console.log('updating time since last activity...');
    var logSpans = $('#activityList>span');
    $.each(logSpans, function(i,v){
        //update the time since for the tweet
        $(v).find('.timestamp').html(" " + calculateSince($(v).data('log-time'))).fadeIn();
    });
}, 15000);

function calculateSince(datetime)
{
    var tTime=new Date(datetime);
    var cTime=new Date();
    var sinceMin=Math.round((cTime-tTime)/60000);
    if(sinceMin==0)
    {
        var sinceSec=Math.round((cTime-tTime)/1000);
        if(sinceSec < 5)
          var since='just now';
        else if(sinceSec < 20)
          var since='less than 10 seconds';
        else if(sinceSec < 20)
          var since='less than 20 seconds';
        else
          var since='half a minute';
    }
    else if(sinceMin==1)
    {
        var sinceSec=Math.round((cTime-tTime)/1000);
        if(sinceSec==30)
          var since='half a minute';
        else if(sinceSec < 60)
          var since='less than a minute';
        else
          var since='1 minute';
    }
    else if(sinceMin < 45)
        var since=sinceMin+' minutes';
    else if(sinceMin>44&&sinceMin<60)
        var since='about 1 hour';
    else if(sinceMin<1440){
        var sinceHr=Math.round(sinceMin/60);
    if(sinceHr==1)
      var since='about 1 hour';
    else
      var since='about '+sinceHr+' hours';
    }
    else if(sinceMin>1439&&sinceMin<2880)
        var since='1 day';
    else
    {
        var sinceDay=Math.round(sinceMin/1440);
        var since=sinceDay+' days';
    }
    return since;
};