module ShiftsHelper

  # def find_date_week()
  #   # sort by datetime
  #   shift_order = Shift.all.sort_by{|t| t.datetime}
  #   shift = shift_order[0]
  #
  #   @date_week = Hash.new
  #
  #   if shift!= nil
  #     @week_number = shift.datetime.strftime('%W');
  #     day_0   = shift.datetime.strftime('%d').to_i - (shift.datetime.strftime('%w').to_i-1)
  #
  #     7.times do |num|
  #       day = day_0 + num
  #       date = shift.datetime.strftime('%m/') + day.to_s + shift.datetime.strftime('/%y')
  #       @date_week[num] = date
  #     end
  #   end
  # end

  # def time_round(time)
  #   time = time.split(":")
  #   hours = time[0].to_i
  #   min = time[1].to_i
  #
  #   if min >=51 || min <=5
  #     if min >= 51 && min <= 59
  #
  #        hours =  (hours < 23)? hours + 1: 0
  #     end
  #     min  = 0
  #   elsif min >= 6 && min <= 20
  #     min = 15
  #   elsif min >= 21 && min <= 35
  #     min = 30
  #   elsif min >= 36 && min <= 50
  #     min = 45
  #   end
  #
  #   hours = hours < 10 ? "0" + hours.to_s : hours.to_s
  #   min = min < 10 ? "0" + min.to_s : min.to_s
  #   return  hours + ":" + min
  #
  # end
  #

  # def find_shifts(guard, week_number, id)
  #   all_shifts = Shift.where(guard_id: guard.id, site_id: id) # SUGESTION: return all shift per guard and site
  #       all_shifts = all_shifts.sort_by{|t| t.datetime}
  #       flag = false
  #       @week = Hash.new
  #       if all_shifts.length != 0
  #
  #         all_shifts.each do |shift|
  #             datetime = shift.datetime
  #             on_shift = shift.on_shift
  #             day_week = shift.datetime.strftime('%w').to_i == 0 ? 7 : shift.datetime.strftime('%w').to_i
  #             shift_week_num = shift.datetime.strftime('%W')
  #             time = time_round(shift.datetime.strftime('%H:%M'))
  #             d_time = Time.new(0,1,1,shift.datetime.strftime('%H').to_i,shift.datetime.strftime('%M').to_i)
  #             d_noon = Time.new(0,1,1,12,0)
  #
  #             flag_before = false
  #             # THIS IF CHECK IF THE SHIFT IS BELONG TO THE CURRENT WEEK
  #             if shift_week_num == week_number
  #               if on_shift
  #                    @week[day_week] = [time,""]
  #               elsif @week[day_week] == nil
  #                 if @week[day_week-1] != nil
  #                     if @week[day_week-1][1] == "" && @week[day_week-1][0] != ""
  #                          @week[day_week-1][1] = time
  #                          flag_before = true
  #                     end
  #                 end
  #                 if !flag_before && ( day_week != 1 || (day_week == 1 && ( Time.at(d_time) > Time.at(d_noon))))
  #                     @week[day_week] = ["",time]
  #                 end
  #               elsif @week[day_week][1] == ""
  #                   @week[day_week][1] = time
  #
  #               end
  #
  #             elsif (shift_week_num.to_i == week_number.to_i + 1) && (day_week == 1 ) && !flag
  #                flag = true
  #                if !on_shift && @week[7]!= nil
  #                  if @week[7][0]!= ""
  #                    @week[7][1] = time
  #                  end
  #                end
  #             end   # IF END
  #         end  # all_shifts.each do |shift| END
  #
  #       end # IF all_shifts.length != 0
  #       if @week.length != 0
  #         @week['site'] = all_shifts.first.site.codename
  #       end
  #     end   # def END
    # all_shifts = Shift.where(guard_id: guard.id, site_id: id) # SUGESTION: return all shift per guard and site
    # all_shifts = all_shifts.sort_by{|t| t.datetime}
    # flag = false
    # @week = Hash.new
    # if all_shifts.length != 0
    #
    #   all_shifts.each do |shift|
    #       datetime = shift.datetime
    #       on_shift = shift.on_shift
    #       day_week = shift.datetime.strftime('%w').to_i
    #       shift_week_num = shift.datetime.strftime('%W')
    #       time = time_round(shift.datetime.strftime('%H:%M'))
    #       # THIS IF CHECK IF THE SHIFT IS BELONG TO THE CURRENT WEEK
    #       if shift_week_num == week_number
    #           if on_shift
    #              @week[day_week] = [time,""]
    #           elsif @week[day_week] == nil && @week.length != 0
    #               if @week[day_week-1] != nil
    #                  if @week[day_week-1][1] == "" && @week[day_week-1][0] != ""
    #                    @week[day_week-1][1] = time
    #                  end
    #               elsif
    #                    @week[day_week] = ["",time]
    #               end
    #            end
    #       elsif (shift_week_num.to_i == week_number.to_i + 1) && (shift.datetime.strftime('%A') == 'Monday' ) && !flag
    #          flag = true
    #          if !on_shift && @week[0]!= nil
    #            if @week[0][0]!= ""
    #              @week[0][1] = time
    #            end
    #          end
    #       end   # IF END
    #   end  # all_shifts.each do |shift| END
    #
    # end # IF all_shifts.length != 0
    # if @week.length != 0
    #   @week['site'] = all_shifts.first.site.codename
    #
    # end

  # end   # def END

  # def find_shifts(guard, week_number, id)
  #
  #   a = []
  #   all_shifts = Shift.where(guard_id: guard.id, site_id: id) # SUGESTION: return all shift per guard and site
  #   all_shifts.sort_by{|t| t.datetime}!
  #   week = Hash.new
  #   monday = Hash.new
  #   count = 0
  # if all_shifts.length != 0
  #
  #   all_shifts.each do |shift|
  #     time = time_round(shift.datetime.strftime('%H:%M'))
  #     date = shift.datetime.strftime('%m/%d/%Y')
  #     shift_week_num = shift.datetime.strftime('%W')
  #   # THIS IF CHECK IF THE SHIFT IS BELONG TO THE CURRENT WEEK
  #   if shift_week_num == week_number
  #    week['site'] = shift.site.codename
  #    # CASE FOR TAKE TIME PER WEEK DAYS
  #
  #    case(shift.datetime.strftime('%A'))
  #       when 'Monday'
  #
  #           if shift.on_shift
  #             week['monday_on'] = time
  #           else
  #             week['monday_off'] = time
  #           end
  #         when 'Tuesday'
  #             if shift.on_shift
  #               week['tuesday_on'] = time
  #             else
  #               week['tuesday_off'] = time
  #             end
  #
  #           when 'Wednesday'
  #             if shift.on_shift
  #              week['wednesday_on'] = time
  #             else
  #              week['wednesday_off'] = time
  #             end
  #
  #           when 'Thursday'
  #             if shift.on_shift
  #               week['thursday_on'] = time
  #             else
  #               week['thursday_off'] = time
  #             end
  #
  #           when 'Friday'
  #            if shift.on_shift
  #              week['friday_on'] = time
  #             else
  #               week['friday_off'] = time
  #             end
  #
  #           when 'Saturday'
  #            if shift.on_shift
  #              week['saturday_on'] = time
  #            else
  #              week['saturday_off'] = time
  #             end
  #
  #           when 'Sunday'
  #             if shift.on_shift
  #               week['sunday_on'] = time
  #             else
  #               week['sunday_off'] = time
  #             end
  #         end  # CASE END
  #     elsif (shift_week_num.to_i == week_number.to_i + 1) && (shift.datetime.strftime('%A') == 'Monday' )
  #       if !shift.on_shift
  #         week['sunday_off'] = time
  #       end
  #     end # IF END
  #
  #   end # all_shifts bucle
  # end # End if
  # return week
  # end
end
