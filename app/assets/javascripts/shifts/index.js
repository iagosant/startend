$(document).ready(function(){

});
function calculate_date_hours(){
  $("#listing-shifts tbody tr").each(function (index)
  {  var i=1;
     while (i <= 7){
       calculate_hours(i,index);
       i++;
      }
  })
}
function calculate_hours(day,index){
  var text_on = $("#tr-"+index+" #"+day+"-on").text(),
      text_off = $("#tr-"+index+" #"+day+"-off").text();

  //function restarHoras(inicio,fin) {

    var day_on = new Date(),
        day_off = new Date();
    text_on = text_on.split(":");
    text_off = text_off.split(":");
    day_on.setHours(text_on[0], text_on[1].split[" "], 0);
    day_off.setHours(text_off[0], text_off[1].split[" "], 0);
    var dif= day_off - day_on; // diferencia en milisegundos

    var difSeg = Math.floor(dif/1000); //diferencia en segundos

    var segundos = difSeg % 60; //segundos

    var difMin = Math.floor(difSeg/60); //diferencia en minutos

    var minutos = difMin % 60; //minutos

    var difHs = Math.floor(difMin/60); //diferencia en horas

    var horas = difHs % 24; //horas

    var total= horas+":"+minutos+":"+segundos; //armo el tiempo de diferencia
   $("#tr-"+index+" #"+day+"-total").text(total);
  //  }

}
