

$( document ).ready(function() {
  $('#event_begin_date').datepicker(
    {format: 'dd-mm-yyyy'});
  $("#event_end_date").datepicker(
    {format: 'dd-mm-yyyy'});
  $("#event_registration_open_date").datepicker(
    {format: 'dd/mmd/yyyy'});
  $("#event_registration_close_date").datepicker(
    {format: 'dd-mm-yyyy'});
})
