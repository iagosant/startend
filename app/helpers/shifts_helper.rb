module ShiftsHelper

  def find_date_week()
    # sort by datetime
    shift_order = Shift.all.sort_by{|t| t.datetime}
    shift = shift_order[0]

    @date_week = Hash.new

    if shift!= nil
      @week_number = shift.datetime.strftime('%W');
      day_0   = shift.datetime.strftime('%d').to_i - (shift.datetime.strftime('%w').to_i-1)

      7.times do |num|
        day = day_0 + num
        date = shift.datetime.strftime('%m/') + day.to_s + shift.datetime.strftime('/%y')
        @date_week[num] = date
      end
    end
  end

  def time_round(time)
    time = time.split(":")
    hours = time[0].to_i
    min = time[1].to_i

    if min >=51 || min <=5
      if min >= 51 && min <= 59

         hours =  (hours < 23)? hours + 1: 0
      end
      min  = 0
    elsif min >= 6 && min <= 20
      min = 15
    elsif min >= 21 && min <= 35
      min = 30
    elsif min >= 36 && min <= 50
      min = 45
    end

    hours = hours < 10 ? "0" + hours.to_s : hours.to_s
    min = min < 10 ? "0" + min.to_s : min.to_s
    return  hours + ":" + min

  end
  # def delete_repeated_time(array)
  #   # This method delete the repeated shift per day
  #   # I need to look for the repeated datetime and then select the on_shift and looking for the nexts and before shift for decide what shift take
  #   # maybe I need to create par of shift per day on-off
  #   # take only de times
  # end
  # def find_shifts(guard,week_number)
  #
  #   a = []
  #   all_shifts = Shift.where(guard_id: guard.id) # SUGGESTION: return all shift per guard and site
  #
  #   @week = Hash.new
  #   monday = []
  #   tuesday = []
  #   wednesday = []
  #   thursday = []
  #   friday = []
  #   saturday = []
  #   sunday = []
  #   next_monday =[]
  #
  #   all_shifts.each do |shift|
  #     @week['site'] = shift.site.codename
  #     time = time_round(shift.datetime.strftime('%H:%M'))
  #     datetime = shift.datetime
  #     on_shift = shift.on_shift
  #     shift_week_num = shift.datetime.strftime('%W')
  #   # THIS IF CHECK IF THE SHIFT IS BELONG TO THE CURRENT WEEK
  #   if shift_week_num == week_number
  #    # CASE FOR TAKE TIME PER WEEK DAYS
  #    case(shift.datetime.strftime('%A'))
  #     when 'Monday'
  #       if
  #       monday[monday.length] = {'datetime'=> datetime, 'on_shift' => on_shift}
  #     when 'Tuesday'
  #       tuesday[tuesday.length] = {'datetime'=> datetime, 'on_shift' => on_shift}
  #     when 'Wednesday'
  #       wednesday[wednesday.length] = {'datetime'=> datetime, 'on_shift' => on_shift}
  #     when 'Thursday'
  #       thursday[thursday.length] = {'datetime'=> datetime, 'on_shift' => on_shift}
  #     when 'Friday'
  #       friday[friday.length] = {'datetime'=> datetime, 'on_shift' => on_shift}
  #     when 'Saturday'
  #       saturday[saturday.length] = {'datetime'=> datetime, 'on_shift' => on_shift}
  #     when 'Sunday'
  #       sunday[sunday.length] = {'datetime'=> datetime, 'on_shift' => on_shift}
  #     end  # CASE END
  #   elsif (shift_week_num.to_i == week_number.to_i + 1) && (shift.datetime.strftime('%A') == 'Monday' )
  #       next_monday[next_monday.length] = {'datetime'=> datetime, 'on_shift' => on_shift}
  #     end   # IF END
  #
  #   end  # all_shifts.each do |shift| END
  #
  #   monday.reverse!
  #   tuesday.reverse!
  #   wednesday.reverse!
  #   thursday.reverse!
  #   friday.reverse!
  #   saturday.reverse!
  #   sunday.reverse!
  #   next_monday.reverse!
  #
  #   byebug
  # end   # def END

  def find_shifts(guard,week_number, id)

    a = []
    all_shifts = Shift.where(guard_id: guard.id, site_id: id) # SUGESTION: return all shift per guard and site

    @week = Hash.new
    monday = Hash.new
    count = 0
  if all_shifts.length != 0

    all_shifts.each do |shift|

      @week['site'] = shift.site.codename
      time = time_round(shift.datetime.strftime('%H:%M'))
      date = shift.datetime.strftime('%m/%d/%Y')
      shift_week_num = shift.datetime.strftime('%W')
    # THIS IF CHECK IF THE SHIFT IS BELONG TO THE CURRENT WEEK
    if shift_week_num == week_number
     # CASE FOR TAKE TIME PER WEEK DAYS
     case(shift.datetime.strftime('%A'))
        when 'Monday'
            if shift.on_shift
              @week['monday_on'] = time
            else
              @week['monday_off'] = time
            end
          when 'Tuesday'
              if shift.on_shift
                @week['tuesday_on'] = time
              else
                @week['tuesday_off'] = time
              end

            when 'Wednesday'
              if shift.on_shift
               @week['wednesday_on'] = time
              else
               @week['wednesday_off'] = time
              end

            when 'Thursday'
              if shift.on_shift
                @week['thursday_on'] = time
              else
                @week['thursday_off'] = time
              end

            when 'Friday'
             if shift.on_shift
               @week['friday_on'] = time
              else
                @week['friday_off'] = time
              end

            when 'Saturday'
             if shift.on_shift
               @week['saturday_on'] = time
             else
               @week['saturday_off'] = time
              end

            when 'Sunday'
              if shift.on_shift
                @week['sunday_on'] = time
              else
                @week['sunday_off'] = time
              end
          end  # CASE END
      elsif (shift_week_num.to_i == week_number.to_i + 1) && (shift.datetime.strftime('%A') == 'Monday' )
        if !shift.on_shift
          @week['sunday_off'] = time
        end
      end # IF END
      
    end # all_shifts bucle
  end # End if
  end
end
