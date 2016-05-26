class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  helper ShiftsHelper

  respond_to :json, :xml, :html

  def found
    date = params[:date].to_time
    site = params[:site]
    site_id = Site.find_by(codename: params[:site]).id

    @shifts_by_date = Shift.where(:datetime => Time.at(date)..Time.at(date) + 1.days, :site_id => site_id)
    # respond_to do |format|
    #      format.html {redirect_to customers_url}
    #      format.js {}
    #  end
  render :json => {:data => @shifts_by_date}
    # respond_with(@shifts_by_date)
  end
  def name_site
      "#{Site.name}"
  end

  # GET /shifts
  # GET /shifts.json
  def index

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

  def remove_all

    Shift.delete_all
    Shift.reset_pk_sequence
    Guard.delete_all
    Guard.reset_pk_sequence
    Site.delete_all
    Site.reset_pk_sequence
    flash[:notice] = "All shift data has been cleared!"
    redirect_to shifts_path

  end

  def import
    Shift.import(params[:file])
      redirect_to shifts_path, notice: "Shifts uploaded succesfully"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift

      @shift = Shift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params

      params.fetch(:shift, {}).permit(:file, :search_date)

    end
end
