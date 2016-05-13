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
  var h_on = 00,m_on =00,h_off= 00,m_off =00,
      day_on = new Date(),
      day_off = new Date(),
      textOn = ($("#tr-"+index+" input[name='time"+day+"-on']").length > 0 ) ? $("#tr-"+index+" input[name='time"+day+"-on']").val() : $("#tr-"+index+" #"+day+"-on").text(),
      textOff = ($("#tr-"+index+" input[name='time"+day+"-off']").length > 0) ? $("#tr-"+index+" input[name='time"+day+"-off']").val() : $("#tr-"+index+" #"+day+"-off").text();

  if (textOn != " ") {
     h_on = textOn.substr(0, 2);
     m_on = textOn.substr(3, 2);
   }
   if (textOff != " ") {
     h_off = textOff.substr(0, 2);
     m_off = textOff.substr(3, 2);
   }
    day_on.setHours(h_on, m_on, 0);
    day_off.setHours(h_off, m_off, 0);
    var diff = day_off - day_on;
    $("#tr-"+index+" #"+day+"-total").text(convert_time_msecond(diff));
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
function trim(string){
    return string.replace(/^\s*|\s*$/g, '');
}
