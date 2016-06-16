class ShiftsController < ApplicationController
  before_action :set_session, only: [:index, :show, :edit, :update, :destroy]
  # before_action :require_logged_in
  # before_action :set_current_user
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  helper ShiftsHelper

  # Functions looking for Guards and their week shedule
  def found
    date = params[:date].to_time
    # site = params[:site]
    week = []
    day_0 = date.strftime('%d').to_i - (date.strftime('%w').to_i-1)
    date_m = (date.strftime('%Y-')+date.strftime('%m-')+day_0.to_s).to_time
    if Shift.all.length != 0
      if params[:site]!= ""
        site_id = Site.find_by(codename: params[:site]).id
        shifts_by_date = Shift.where(:datetime => Time.at(date_m)..Time.at(date_m) + 8.days, :site_id => site_id)
      else
        shifts_by_date = Shift.where(:datetime => Time.at(date_m)..Time.at(date_m) + 8.days)
      end # END site!= ""
      if shifts_by_date.all.length != 0
        sites = shifts_by_date.select("site_id").uniq
        count = 0
        sites.each do |site|
          guards = shifts_by_date.select(:guard_id).uniq { |m| m.site_id  == site.site_id }
          week_number = date_m.strftime('%W');
          guards.each do |guard|
            all_shifts = shifts_by_date.where(guard_id: guard.guard_id, site_id: site.site_id)
            week_per_guard = find_shifts(guard.guard_id, week_number, all_shifts)
            if week_per_guard != ""
              week[count] = week_per_guard
              count += 1
            end
           end # END guards.each
         end # END sites.each
       end # END shifts_by_date.length
    end # END  Shift.length != 0
    respond_to do |format|
      format.html { redirect_to shifts_path, notice: 'Shifts_by_date was successfully created.' }
      format.json { render json: week }
    end # respond_to
 end
 def find_shifts(guard, week_number,all_shifts)
   all_shifts = all_shifts.sort_by{|t| t.datetime}
   flag = false
   week = Hash.new
   if all_shifts.length != 0
     all_shifts.each do |shift|
         datetime = shift.datetime
         on_shift = shift.on_shift
         day_week = shift.datetime.strftime('%w').to_i == 0 ? 7 : shift.datetime.strftime('%w').to_i
         shift_week_num = shift.datetime.strftime('%W')
         time = time_round(shift.datetime.strftime('%H:%M'))
         d_time = Time.new(0,1,1,shift.datetime.strftime('%H').to_i,shift.datetime.strftime('%M').to_i)
         d_noon = Time.new(0,1,1,12,0)
         flag_before = false
         # THIS IF CHECK IF THE SHIFT IS BELONG TO THE CURRENT WEEK
         if shift_week_num == week_number
           if on_shift
                week[day_week] = [time,""]
           elsif week[day_week] == nil
             if week[day_week-1] != nil
                 if week[day_week-1][1] == "" && week[day_week-1][0] != ""
                      week[day_week-1][1] = time
                      flag_before = true
                 end
              end # week[day_week-1] != nil
              if !flag_before && ( day_week != 1 || (day_week == 1 && ( Time.at(d_time) > Time.at(d_noon))))
                 week[day_week] = ["",time]
              end
           elsif week[day_week][1] == ""
               week[day_week][1] = time
           end # on_shift
       elsif (shift_week_num.to_i == week_number.to_i + 1) && (day_week == 1 ) && !flag
            flag = true
            if !on_shift && week[7]!= nil
              if week[7][0]!= ""
                week[7][1] = time
              end
            end
         end   # IF END
     end  # all_shifts.each do |shift| END
   end # IF all_shifts.length != 0
   if week.length != 0
     week['guard'] = Guard.find(guard).first_name + " " + Guard.find(guard).last_name
     week['site'] = all_shifts.first.site.codename
     return week
   else
     return ""
   end
  end   # def END
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
  end  # def END
 # END Functions looking for Guards and their week shedule
  def name_site
      "#{Site.name}"
  end

  # GET /shifts
  # GET /shifts.json
  def index
    # authorize @user
    @shifts = Shift.all
    @guards = Guard.all
    @shift = Shift.new
    respond_to do |format|
      format.html
      format.xls
      format.js {}
      format.csv { send_data @shifts.to_csv }
      format.pdf do
        render :pdf => 'shifts_index'
        pdf = WickedPdf.new.pdf_from_string(
        render_to_string('shifts/index.html.erb', layout: false))
      end
    end
  end
  # GET /shifts/1
  # GET /shifts/1.json
  def show
  end
  # GET /shifts/new
  def new
    @shift = Shift.new
  end
  # GET /shifts/1/edit
  def edit
  end
  # POST /shifts
  # POST /shifts.json
  def create
    # authorize @user
  #import redirects to import method in this(shifts) controller
    import
    @shift = Shift.new(shift_params)
  end
  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update

    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
        redirect_to shifts_path
      end
    end
  end
  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
      format.json { head :no_content }
      Shift.reset_pk_sequence
    end
  end

  def import
    Shift.import(params[:file])
    redirect_to shifts_path, notice: "Shifts uploaded succesfully"
  end
  private
    # Use callbacks to share common setup or constraints between actions.

    def set_current_user
      @user = current_user
    end

    def set_session
      @session = session[:user_id]
    end

    def set_shift
      @shift = Shift.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.fetch(:shift, {}).permit(:file, :search_date)
    end
end
