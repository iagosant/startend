module ShiftsHelper

  def find_date_week()
    # sort by datetime
    shift_order = Shift.all.sort_by{|t| t.datetime}
    shift = shift_order[0]

    @date_week = Hash.new

    if shift!= nil

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
  def find_shifts(guard)

    a = []
    all_shifts = Shift.where(guard_id: guard.id)

    @week = Hash.new
    monday = Hash.new
    count = 0

    all_shifts.each do |shift|
      @week['site'] = shift.site.codename
      time = time_round(shift.datetime.strftime('%H:%M'))
      date = shift.datetime.strftime('%m/%d/%Y')
    if shift.datetime.strftime('%A')=='Monday'
      if shift.on_shift
        a[count]=["date_on"=>date,"time_on"=>time]
      else
        a[count]=["date_off"=>date,"time_off"=>time]
      end

      count = count + 1
    end
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

      end


    end


  end

end
