$(document).ready(function() {
     $('input[type="submit"]').attr('disabled','disabled');
     $('input[type="file"]').keyup(function() {
        if($(this).val() != '') {
           $('input[type="submit"]').removeAttr('disabled');
        }
     });
 });
