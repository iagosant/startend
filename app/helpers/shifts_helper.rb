module ShiftsHelper
  def find_shifts(guard)

    all_shifts = Shift.where(guard_id: Guard.first.id)

    @week = Hash.new
    all_shifts.each do |shift|

      time = shift.datetime.strftime('%H:%M')
      case(shift.datetime.strftime('%A'))
      when 'Monday'
        if shift.on_shift == true
          @week['monday_on'] = time
        else
          @week['monday_off'] = time
        end
      when 'Tuesday'
        if shift.on_shift == true
          @week['tuesday_on'] = time
        else
          @week['tuesday_off'] = time
        end
      when 'Wednesday'
          if shift.on_shift == true
        @week['wednesday_on'] = time
        else
        @week['wednesday_off'] = time
        end
      end
      when 'Thursday'
          if shift.on_shift == true
        @week['thursday_on'] = time
        else
        @week['thursday_off'] = time
        end
      end
      when 'Friday'
          if shift.on_shift == true
        @week['friday_on'] = time
        else
        @week['friday_off'] = time
        end
      end
      when 'Saturday'
          if shift.on_shift == true
        @week['saturday_on'] = time
        else
        @week['saturday_off'] = time
        end
      end
      when 'Sunday'
            if shift.on_shift == true
          @week['sunday_on'] = time
          else
          @week['sunday_off'] = time
          end
      end
    end
  end
end
