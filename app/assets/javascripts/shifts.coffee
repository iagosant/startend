# calculate = ->
#   $('#listing-shifts tbody tr').each (index) ->
#     calculate_hours_total index
#     return
#   return
#
# calculate_hours_total = (row) ->
#   total_week = undefined
#   total = undefined
#   i = undefined
#   h_on = undefined
#   total_week = [
#     0
#     0
#   ]
#   i = 1
#   while i < 8
#     time = convert_time_msecond(calculate_hours(i, row))
#     hon = time.split(':')
#     hon[0] = if isNaN(parseInt(hon[0])) then 0 else parseInt(hon[0])
#     hon[1] = if isNaN(parseInt(hon[1])) then 0 else parseInt(hon[1])
#     total_week[0] = total_week[0] + hon[0]
#     total_week[1] = total_week[1] + hon[1]
#     i++
#   text = (if total_week[0] < 10 then '0' + total_week[0] else total_week[0]) + ':' + (if total_week[1] < 10 then '0' + total_week[1] else total_week[1])
#   $('#tr-' + row + ' #total_week').text text
#   return
#
# calculate_hours = (day, index) ->
#   day_on = new Date
#   day_off = new Date
#   diff = 0
#   h_on = $('#tr-' + index + ' input[name=\'time' + day + '-on\']').val().split(':')
#   h_off = $('#tr-' + index + ' input[name=\'time' + day + '-off\']').val().split(':')
#   if h_on.length > 1 and h_off.length > 1
#     i = 0
#     while i < 3
#       h_on[i] = if isNaN(parseInt(h_on[i])) then 0 else parseInt(h_on[i])
#       h_off[i] = if isNaN(parseInt(h_off[i])) then 0 else parseInt(h_off[i])
#       i++
#     day_on.setHours h_on[0], h_on[1], 0
#     day_off.setHours h_off[0], h_off[1], 0
#     diff = day_off - day_on
#     if diff != 0
#       $('#tr-' + index + ' #' + day + '-total').text convert_time_msecond(diff)
#     else
#       $('#tr-' + index + ' #' + day + '-total').text ''
#   diff
#
# convert_time_msecond = (msecond) ->
#   msecPerMinute = 1000 * 60
#   msecPerHour = msecPerMinute * 60
#   msecPerDay = msecPerHour * 24
#   # Calculate how many days the dif contains. Subtract that
#   days = Math.floor(msecond / msecPerDay)
#   msecond = msecond - (days * msecPerDay)
#   # Calculate the hours, minutes, and seconds.
#   hours = Math.floor(msecond / msecPerHour)
#   msecond = msecond - (hours * msecPerHour)
#   minutes = Math.floor(msecond / msecPerMinute)
#   msecond = msecond - (minutes * msecPerMinute)
#   seconds = Math.floor(msecond / 1000)
#   total_hours = if days > 0 then Math.abs(days) * 24 + Math.abs(hours) else hours
#   (if total_hours < 10 then '0' + total_hours else total_hours) + ':' + (if minutes < 10 then '0' + minutes else minutes)
#
# $(document).ready ->
#   $('select').material_select()
#   $('#datepicker').datepicker
#     dateFormat: 'yy-mm-dd'
#     disabled: true
#   $('#site_select').on 'change', ->
#     if $('#site_select').val() != ''
#       $('#datepicker').datepicker 'enable'
#     else
#       $('#datepicker').datepicker 'enable'
#       $('#table-shift').css 'display', 'none'
#       $('#datepicker').datepicker 'setDate', null
#     return
#   $('input#datepicker').on 'change', ->
#     if $(this).val() != ''
#       firstDay = $(this).val()
#       site = $('#site_select').val()
#       # alert(site);
#       $.ajax
#         type: 'GET'
#         url: 'shifts/shifts'
#         dataType: 'json'
#         data:
#           'date': firstDay
#           'site': site
#         success: (result) ->
#           table = <%= render partial: 'shiftTable' %>
#           $('#table-shift').css 'display', 'block'
#           $('#table-shift').html result
#           # $("#table-shift").append("<%= render '_shiftTable' %>");
#           $('#table-shift').append table
#           # $('#table-shift').append("#{escape_javascript( render 'shiftTable')}");
#           # <%= escape_javascript(render :partial => 'posts/comment', :locals => { :comment => @comment }).html_safe %>
#           return
#     return
#   calculate()
#   $('input.upload_button').on 'change', ->
#     if $(this).val() != ''
#       $('#upload_a').removeClass 'disabled'
#     else
#       $('#upload_a').addClass 'disabled'
#     return
#   return
