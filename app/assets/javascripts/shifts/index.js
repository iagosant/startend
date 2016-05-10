$(document).ready(function(){
/*
  $('.time').each(function(){
    self.timepicker({
             minuteStep: 1,
             template: 'modal',
             appendWidgetTo: 'body',
             showSeconds: true,
             showMeridian: false,
             defaultTime: false
         });
  })*/
});

/*function convertTo24Hour(time) {
    var hours = parseInt(time.substr(0, 2));
    if(time.indexOf('am') != -1 && hours == 12) {
        time = time.replace('12', '0');
    }
    if(time.indexOf('pm')  != -1 && hours < 12) {
        time = time.replace(hours, (hours + 12));
    }
    return time.replace(/(am|pm)/, '');
}*/
function calculate_date_hours(){
  var  total_week, i;
  $("#listing-shifts tbody tr").each(function (index)
  {  i=1;
     total_week = 0;
     while (i <= 7){
       total_week = total_week + parseInt(calculate_hours(i,index));
       i++;
      }
    $("#tr-"+index+" #total_week").text(convert_time_msecond(total_week) );
  })
}
function calculate_hours(day,index){
  var h_on,m_on,s_on,h_off,m_off,s_off,
      day_on = new Date(),
      day_off = new Date(),
      text_on = $("#tr-"+index+" #"+day+"-on").text(),
      text_off = $("#tr-"+index+" #"+day+"-off").text();
    //  text_on = $("#tr-"+index+" #"+day+"-on input") ? $("#tr-"+index+" #"+day+"-on input").val() : $("#tr-"+index+" #"+day+"-on").text(),
    //  text_off =  $("#tr-"+index+" #"+day+"-off input") ? $("#tr-"+index+" #"+day+"-off input").val() : $("#tr-"+index+" #"+day+"-off").text();

  //   text_on = ''+text_on+''
  //   text_off = ''+text_off+''
     h_on = text_on.substr(0, 2);
    m_on = text_on.substr(3, 2);
    h_off = text_off.substr(0, 2);
    m_off = text_off.substr(3, 2);

    day_on.setHours(h_on, m_on, 0);
    day_off.setHours(h_off, m_off, 0);
    var diff = day_off - day_on;
//diff_time(day_on, day_off)
    $("#tr-"+index+" #"+day+"-total").text(convert_time_msecond(diff));
    return diff;

}

function convert_time_msecond(msecond){
    var msecPerMinute = 1000 * 60;
    var msecPerHour = msecPerMinute * 60;
    var msecPerDay = msecPerHour * 24;

    // Get the difference in milliseconds.

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
