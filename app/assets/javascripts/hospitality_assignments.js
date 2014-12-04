$(function() {  
  $('select#event_localities').change(function(){
    var locality_id = $(this).val();
    var hospitality_id = $(this).parent().parent().attr('id');//update this
    var url_base = '/events/' + 
              currentEvent +
              '/hospitality_assignments/'
    console.log('locality_id: ' + locality_id);
    console.log('hospitality_id: ' + hospitality_id);
    console.log('currentEvent: ' + currentEvent);

    if (locality_id == "") { 
      //alert('no locality_id...');
      // Send the request and update sub category dropdown
      $.ajax({
        url: url_base + 'unassign_lodging_from_locality',
        type: 'POST',
        data: { event: {
          //locality_id: locality_id,
          hospitality_id: hospitality_id }},
        // Need to pass in 'event' (js event) first:
        // http://blog.bigbinary.com/2012/05/11/jquery-ujs-and-jquery-trigger.html
        success: function(event,data, status){
        }
      });
    }
    else {
      // Send the request and update sub category dropdown 
      $.ajax({
        url: url_base + 'assign_lodging_to_locality',
        type: 'POST',
        data: { event: {
          locality_id: locality_id,
          hospitality_id: hospitality_id }},
        // Need to pass in 'event' first:
        // http://blog.bigbinary.com/2012/05/11/jquery-ujs-and-jquery-trigger.html
        success: function(event, result){
          alert("result" + result); 
          // $('#participating_localities_content').html(result);
        }
      });
    }
  });

  $('select#event_registrations').change(function(){
    //alert('alert in select#event_localities firing...');
    var registration_id = $(this).val();
    var locality_id = $(this).parent().parent().attr('id');//update this
    var url_base = '/events/' + 
              currentEvent +
              '/hospitality_assignments/'

    console.log('registration_id: ' + registration_id);
    console.log('locality_id: ' + locality_id);
    console.log('url_base: ' + url_base);

    if (registration_id == "") { 
      alert('no registration_id..');
      // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
    }
    else {
      // Send the request and update sub category dropdown 
      alert('sending data to assign_registration_user_to_hospitality\n');
      $.ajax({
        url: url_base + 'assign_registration_user_to_hospitality',
        type: 'POST',
        data: { event: {
          locality_id: locality_id,
          registration_id: registration_id}},
        // Need to pass in 'event' first:
        // http://blog.bigbinary.com/2012/05/11/jquery-ujs-and-jquery-trigger.html
        success: function(event,data, status){
          alert("Need to change update table now...");
        }
      });
    }
  });
});
