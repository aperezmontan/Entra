$(document).on('ready page:load', function(event){
  var placeId = $('#giant-lock').data('place-id')
  updateAllActivity(placeId);
})


var updateAllActivity = function(placeId){
  activity.forEach(function(act){
    logFormat(act);
  })
  updateNewActivity(Date.now, placeId);
      // $('#activityList i:first-child').hide().fadeIn('slow')
}

var logFormat = function(act){
  console.log('gggg',act)
  var html = "<i class='{i_tag_class}'></i><span data-log-time='{created_at}'> {message} <span class='timestamp'>{timeAgo}</span></span></br>";
  $('#activityList div').remove();
  var message = act['message'].substring(8,act['message'].length)
  $('#activityList').prepend(parseLog(html,act,message,"fa fa-check",calculateSince(act['created_at']))).fadeIn('slow');
}


var parseLog = function(html,log,message,i_tag_class,time_ago){

  html = html.replace('{created_at}',log['created_at']);
  html = html.replace('{message}',message);
  html = html.replace('{i_tag_class}',i_tag_class);
  html = html.replace('{timeAgo}',time_ago);
  return html;
}

var updateNewActivity = function(time, placeId){
  console.log('last',time)
  $.ajax({
    url: '/logs',
    method: 'GET',
    data: {from_time: time, place_id: placeId}
  })
  .done(function(response){
    console.log('resp',response)
    if (response.length && response[response.length - 1].created_at != time){
      response.forEach(function(act){
        logFormat(act);
      });
    }
    setTimeout(function(){
      updateNewActivity(lastUpdate(), placeId);
    },700);
  });
}

var lastDate;

var lastUpdate = function(){
  console.log('lastdate', lastDate)
  if ($('#activityList span:first-of-type').data('log-time') === undefined){
    if(!lastDate) lastDate = Date.now();
    return lastDate;
   } else{
    return $('#activityList span:first-of-type').data('log-time')
  }
}


// var logFormat = function(act){
//   var html = "<i class='{i_tag_class}'></i><span data-log-time='{created_at}'> {message} <span class='timestamp'>{timeAgo}</span> ago</span></br>";
//   act.forEach(function(log){
//     var logdate = new Date(log['created_at'])
//     var ld = new Date(lastUpdate())
//     if(logdate > ld){
//       $('#activityList div').remove();
//       if (log['message'].indexOf("SUCCESS") > -1){
//         var message = log['message'].substring(9,log['message'].length)
//         $('#activityList').prepend(parseLog(html,log,message,"fa fa-check",calculateSince(log['created_at'])));
//       } else {
//         var message = log['message'].substring(10,log['message'].length)
//         $('#activityList').prepend(parseLog(html,log,message,"fa fa-times",calculateSince(log['created_at'])));
//       }
//       $('#activityList i:first-child').hide().fadeIn('slow')
//     }
//   })
// }

// var parseLog = function(html,log,message,i_tag_class,ago){

//   html = html.replace('{created_at}',log['created_at']);
//   html = html.replace('{message}',message);
//   html = html.replace('{i_tag_class}',i_tag_class);
//   html = html.replace('{timeAgo}',ago);
//   console.log(html);
//   html = html.replace('just now</span> ago', 'just now</span>');
//   return html;
// }


  setInterval(function() {
    console.log('updating time since last activity...');
    var logSpans = $('#activityList>span');
    $.each(logSpans, function(i,v){
      $(v).find('.timestamp').html(" " + calculateSince($(v).data('log-time'))).fadeIn('slow');
    });
}, 15000);

// setInterval(function() {
//     console.log('updating time since for tweets...');
//     var tweets = $('#tweets-container>ul>li');
//     $.each(tweets, function(i,v){
//         //update the time since for the tweet
//         var tweetsObjs = TwitterApp.controllers.Tweets.getTweets();
//         $(v).find('.timestamp').html(" " + calculateSince(tweetsObjs[i].created_at)).fadeIn();
//     });
// }, 15000);

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