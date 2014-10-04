$( document ).ready(function() {
  // alert('in events.js');
  $('.hector').css('color', 'red');
  console.log("In event!");
 $('#event_begin_date').datepicker(
  {dateformat: 'yy-mm-dd'});
//	$("#event_end_date").datepicker(
//		{dateformat: 'yy-mm-dd'});
//	$("#event_registration_open_date").datepicker(
//		{dateformat: 'yy-mm-dd'});
//	$("#event_registration_close_date").datepicker(
//		{dateformat: 'yy-mm-dd'});
});
