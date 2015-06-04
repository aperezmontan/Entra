$(document).on('ready page:load', function(event){
  var placeId = $('#giant-lock').data('place-id')
  updateNewActivity(0, placeId);
})

var logFormat = function(act){
  // console.log('gggg',act)
  var html = "<i class='{i_tag_class}'></i><span data-log-id='{id}' data-log-time='{created_at}'> {message} <span class='timestamp'>{timeAgo}</span></span></br>";
  $('#activityList div').remove();
  var message = act['message'].substring(8,act['message'].length)
  $('#activityList').prepend(parseLog(html,act,message,"fa fa-check",calculateSince(act['created_at']))).fadeIn('slow');
}


var parseLog = function(html,log,message,i_tag_class,time_ago){

  html = html.replace('{created_at}',log['created_at']);
  html = html.replace('{message}',message);
  html = html.replace('{i_tag_class}',i_tag_class);
  html = html.replace('{timeAgo}',time_ago);
  html = html.replace('{id}',log['id']);
  return html;
}

var updateNewActivity = function(actId, placeId){
  removeOldActivity();
  // console.log('actId',actId)
  // console.log('placeID',placeId)
  $.ajax({
    url: '/logs',
    method: 'GET',
    data: {logs:{act_id: actId, place_id: placeId}}
  })
  .done(function(response){
    // console.log('resp',response)
    if (response.length){
      response.forEach(function(act){
        logFormat(act);
      });
    }
    setTimeout(function(){
      // var placeId = $('#giant-lock').data('place-id')
      updateNewActivity(lastUpdate(), placeId);
      removeOldActivity();
      // $('#activityList i:first-child').hide().fadeIn('slow')
    },700);
  });
}

var lastId;

var lastUpdate = function(){
 // console.log('lastId', lastId)
  if ($('#activityList span:first-of-type').data('log-id') === undefined){
    if(!lastId) lastId = 0;
    return lastId;
   } else{
    return $('#activityList span:first-of-type').data('log-id')
  }
}

var removeOldActivity = function(){
  if ($('#activityList > span').length > 6){
    $('#activityList > span:gt(6)').fadeOut();
    $('#activityList > br:gt(6)').fadeOut();
    $('#activityList > i:gt(6)').fadeOut();
    // $('#activityList > span:gt(6)').remove();
    // $('#activityList > i:gt(6)').remove();
    // $('#activityList > br:gt(6)').remove();
  }
}

  setInterval(function() {
    // console.log('updating time since last activity...');
    var logSpans = $('#activityList>span');
    $.each(logSpans, function(i,v){
      $(v).find('.timestamp').html(" " + calculateSince($(v).data('log-time'))).fadeIn('slow');
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
          var since='less than 10 seconds ago';
        else if(sinceSec < 20)
          var since='less than 20 seconds ago';
        else
          var since='half a minute ago';
    }
    else if(sinceMin==1)
    {
        var sinceSec=Math.round((cTime-tTime)/1000);
        if(sinceSec==30)
          var since='half a minute ago';
        else if(sinceSec < 60)
          var since='less than a minute ago';
        else
          var since='1 minute ago';
    }
    else if(sinceMin < 45)
        var since=sinceMin+' minutes ago';
    else if(sinceMin>44&&sinceMin<60)
        var since='about 1 hour ago';
    else if(sinceMin<1440){
        var sinceHr=Math.round(sinceMin/60);
    if(sinceHr==1)
      var since='about 1 hour ago';
    else
      var since='about '+sinceHr+' hours ago';
    }
    else if(sinceMin>1439&&sinceMin<2880)
        var since='1 day ago';
    else
    {
        var sinceDay=Math.round(sinceMin/1440);
        var since=sinceDay+' days ago';
    }
    return since;
};