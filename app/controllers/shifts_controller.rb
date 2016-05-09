class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  helper ShiftsHelper
  # GET /shifts
  # GET /shifts.json
  def index

    @shifts = Shift.all
    @guards = Guard.all

    respond_to do |format|
      format.html
      format.csv { send_data @shifts.to_csv }
      format.xls #{ send_data @shifts.to_csv(col_sep: "\t") }
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
      params.fetch(:shift, {}).permit(:file)
    end

end
