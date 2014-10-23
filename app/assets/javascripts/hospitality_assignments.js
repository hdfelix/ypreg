$(function() {  
  $('select#event_localities').change(function(){
    var locality_id = $(this).val();
    var hospitality_id = $(this).parent().parent().attr('id');//update this
    console.log('locality_id: ' + locality_id);
    console.log('hospitality_id: ' + hospitality_id);
    alert('locality_id: ' + locality_id + '\nhospitality_id: ' + hospitality_id);
    if (locality_id == "") { 
      alert('no locality_id...');
      // Send the request and update sub category dropdown 
      $.ajax({
        url: '/events/1/hospitality_assignments/unassign_lodging_from_locality',
        type: 'POST',
        data: { event: {
          //locality_id: locality_id,
          hospitality_id: hospitality_id }},
        // Need to pass in 'event' (js event) first:
        // http://blog.bigbinary.com/2012/05/11/jquery-ujs-and-jquery-trigger.html
        success: function(event,data, status){
          alert("Data: " + data + "\nStatus: " + status.html);
        }
      });
    }
    else {
      // Send the request and update sub category dropdown 
      $.ajax({
        url: '/events/1/hospitality_assignments/assign_lodging_to_locality',
        type: 'POST',
        data: { event: {
          locality_id: locality_id,
          hospitality_id: hospitality_id }},
        // Need to pass in 'event' first:
        // http://blog.bigbinary.com/2012/05/11/jquery-ujs-and-jquery-trigger.html
        success: function(event,data, status){
          alert("Data: " + data + "\nStatus: " + status.html);
        }
      });
    }
  });

  $('select#event_registrations').change(function(){
    alert('alert in select#event_localities firing...');
    var registration_id = $(this).val();
    var locality_id = $(this).parent().parent().attr('id');//update this
    console.log('registration_id: ' + registration_id);
    console.log('locality_id: ' + locality_id);
    alert('registration_id: ' + registration_id + '\nlocality_id: ' + locality_id);
    if (registration_id == "") { 
      alert('no registration_id..');
      // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
    }
    else {
      // Send the request and update sub category dropdown 
      $.ajax({
        url: '/events/1/hospitality_assignments/assign_lodging_to_locality',
        type: 'POST',
        data: { event: {
          locality_id: locality_id,
          hospitality_id: hospitality_id }},
        // Need to pass in 'event' first:
        // http://blog.bigbinary.com/2012/05/11/jquery-ujs-and-jquery-trigger.html
        success: function(event,data, status){
          alert("Data: " + data + "\nStatus: " + status.html);
        }
      });
    }
  });
});
