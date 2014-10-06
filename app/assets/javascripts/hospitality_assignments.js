$(function() {  
  //alert('alert in hospitality_assignments.js firing...');
  $("select").live("change", function(e) {
    e.preventDefault();
    $.ajax({
      url: "/events/hospitality_assignments/" + $(this).val(), //I think, it could be something else
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      success: function(data) {
        //binding.pry
        //you're returning a JSON object, so just iterate through it and bind it to
        //the value attributes of each field
      },
      error: function(xhr,exception,status) {
        //console.log("In error clause")
        //catch any errors here
      }
    });
  }); 
});
