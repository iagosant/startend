$(document).ready(function() {
  $('select').material_select();


   $( "#datepicker" ).datepicker({
     dateFormat: 'yy-mm-dd'
//      ,
//      onClose: function(strDate, datepicker) {
//   // According to the docs this situation occurs when
//   // the dialog closes without the user making a selection
//   if(strDate == "") {
//     return;
//   }
//
//   // According to the docs this refers to the input
//   // Some digging in jquery-ujs on github make it
//   // look like triggering the 'submit.rails' event
//   // on the form will cause the normal unobtrusive
//   // js helpers to post the form.
//   // What's not clear is if the input element has the
//   // updated value at this point.
//   $(this).parent().trigger('submit.rails')
// }
   });

   $( "#datepicker" ).change(function(){
     if ($(this).val()!=""){
       var firstDay = $(this).val().split("-"),
           firstDay = new Date(firstDay[0],firstDay[1],firstDay[2],0,0,0),
           site = $('.select-dropdown').val();

        alert(site);
        $.ajax({
          type: "GET",
          url: "shifts/shifts",
          dataType: "json",
          data: {'date': firstDay, 'site': site},
          success:function(result){

            $(".divider").append("<li data-id="+result+"></li>");
            }
          })
        }
      });
   calculate();
   $('input.upload_button').on('change', function(){
     if($(this).val() != '') {
       $('#upload_a').removeClass('disabled');
     } else {$('#upload_a').addClass('disabled');}
   });
 });
  /******** FUNCTION MISLEY ***********/
  function calculate(){
    $("#listing-shifts tbody tr").each(function (index){
      calculate_hours_total(index);
    });
  }
  function calculate_hours_total(row){
    var  total_week , total, i, h_on;

      total_week = [0,0];
      for(i=1;i<8;i++){
        var time = convert_time_msecond(calculate_hours(i,row));
        var h_on = time.split(":");
        h_on[0]=(isNaN(parseInt(h_on[0])))?0:parseInt(h_on[0]);
        h_on[1]=(isNaN(parseInt(h_on[1])))?0:parseInt(h_on[1]);
        total_week[0] = total_week[0] + h_on[0];
        total_week[1] = total_week[1] + h_on[1];
      }
        var text = (total_week[0] < 10 ? "0" + total_week[0] : total_week[0]) + ":" + (total_week[1] < 10 ? "0" + total_week[1] : total_week[1]) ;
        $("#tr-"+row+" #total_week").text(text);
    }

  function calculate_hours(day,index){
    var day_on = new Date(),
        day_off = new Date(),
        diff = 0,
        h_on = $("#tr-"+index+" input[name='time"+day+"-on']").val().split(":") ,
        h_off = $("#tr-"+index+" input[name='time"+day+"-off']").val().split(":");

    if ((h_on.length > 1) && (h_off.length > 1)) {
      for(i=0;i<3;i++){
        h_on[i]=(isNaN(parseInt(h_on[i])))?0:parseInt(h_on[i])
        h_off[i]=(isNaN(parseInt(h_off[i])))?0:parseInt(h_off[i])
      }
      day_on.setHours(h_on[0], h_on[1], 0);
      day_off.setHours(h_off[0], h_off[1], 0);

      diff = day_off - day_on;
      if ( diff != 0 ){
        $("#tr-"+index+" #"+day+"-total").text(convert_time_msecond(diff));
      } else {
        $("#tr-"+index+" #"+day+"-total").text("");
      }

    }
    return diff;
  }

  function convert_time_msecond(msecond){
      var msecPerMinute = 1000 * 60;
      var msecPerHour = msecPerMinute * 60;
      var msecPerDay = msecPerHour * 24;
      // Calculate how many days the dif contains. Subtract that
      var days = Math.floor(msecond / msecPerDay ) ;
      msecond = msecond - (days * msecPerDay );
      // Calculate the hours, minutes, and seconds.
      var hours = Math.floor(msecond / msecPerHour );
      msecond = msecond - (hours * msecPerHour );

      var minutes = Math.floor(msecond / msecPerMinute );
      msecond = msecond - (minutes * msecPerMinute );

      var seconds = Math.floor(msecond / 1000 );
      var total_hours = days > 0 ? ( Math.abs(days) * 24 + Math.abs(hours) ) : hours;
      return (total_hours < 10 ? "0" + total_hours : total_hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) ;
  }
