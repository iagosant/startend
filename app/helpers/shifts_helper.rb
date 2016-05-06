module ShiftsHelper
  def find_shifts(guard)

    all_shifts = Shift.where(guard_id: guard.id)

    @week = Hash.new
    all_shifts.each do |shift|

    time = shift.datetime.strftime('%H:%M')
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
