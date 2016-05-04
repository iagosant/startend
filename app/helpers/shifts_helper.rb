module ShiftsHelper
  def find_shifts(guard)

    @all_shifts = Shift.where(guard_id: guard.id)
    @w ="test"
    @week = Hash.new
    @all_shifts.each do |shift|

      time = shift.datetime.strftime('%H:%M')
      case(shift.datetime.strftime('%A'))
      when 'Monday'
        if shift.on_shift == true
          @week['monday_on'] = time
        else
          @week['monday_off'] = time
        end
      when 'Saturday'
        if shift.on_shift == true
          @week['saturday_on'] = time
        else
          @week['saturday_off'] = time
        end
        when 'Wednesday'
          if shift.on_shift == true
        @week['tuesday_on'] = time
        else
        @week['tuesday_off'] = time
      end
      end

    end
   
  end
end
