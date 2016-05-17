$(document).ready(function() {
  $('select').material_select();
     });
  /******** FUNCTION MISLEY ***********/
  function calculate_date_hours(){
    var  total_week, total, i;
    $("#listing-shifts tbody tr").each(function (index)
    {  i=1;
       total_week = 0;
       while (i <= 7){
         total_week = total_week +  parseInt(calculate_hours(i,index));
         i++;
       }

      if (total_week != 0){
        total = Math.abs(total_week);
        $("#tr-"+index+" #total_week").text(convert_time_msecond(total_week));
      }
    })
  }
  function calculate_hours(day,index){
    var h_on = 00,m_on =00,h_off= 00,m_off =00,
        day_on = new Date(),
        day_off = new Date(),
        diff = 0,
        textOn = ($("#tr-"+index+" input[name='time"+day+"-on']").length > 0 ) ? $("#tr-"+index+" input[name='time"+day+"-on']").val().split(":") : $("#tr-"+index+" #"+day+"-on").text().split(":"),
        textOff = ($("#tr-"+index+" input[name='time"+day+"-off']").length > 0) ? $("#tr-"+index+" input[name='time"+day+"-off']").val().split(":") : $("#tr-"+index+" #"+day+"-off").text().split(":");

    if ((textOn.length > 1) && (textOff.length > 1)){
       h_on = textOn[0];
       m_on = textOn[1];
       h_off = textOff[0];
       m_off = textOff[1];
       day_on.setHours(h_on, m_on, 0);
       day_off.setHours(h_off, m_off, 0);
       diff = day_off - day_on;
       if ( diff != 0 ){
         $("#tr-"+index+" #"+day+"-total").text(convert_time_msecond(diff));
       }
     }

       return diff;

  }

  function convert_time_msecond(msecond){
      var msecPerMinute = 1000 * 60;
      var msecPerHour = msecPerMinute * 60;
      var msecPerDay = msecPerHour * 24;
      // Calculate how many days the dif contains. Subtract that
      var days = Math.floor(msecond / msecPerDay );
      msecond = msecond - (days * msecPerDay );
      // Calculate the hours, minutes, and seconds.
      var hours = Math.floor(msecond / msecPerHour );
      msecond = msecond - (hours * msecPerHour );

      var minutes = Math.floor(msecond / msecPerMinute );
      msecond = msecond - (minutes * msecPerMinute );

      var seconds = Math.floor(msecond / 1000 );

      return (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) ;
  }
