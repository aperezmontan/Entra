// $(document).on('ready page:load', function(event){
//   var placeId = $('#giant-lock').data('place-id')
//     updateActivity(lastUpdate(), placeId);
// })

// var updateActivity = function(time, placeId){
//   console.log('last',time)
//   $.ajax({
//     url: '/logs',
//     method: 'GET',
//     data: {from_time: time, place_id: placeId}
//   })
//   .done(function(response){
//     console.log('resp',response)
//     logFormat(response);
//     setTimeout(function(){
//       updateActivity(lastUpdate(time), placeId);
//     },1000);
//   });
// }
