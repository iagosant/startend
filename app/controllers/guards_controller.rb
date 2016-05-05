class GuardsController < ApplicationController
  before_action :set_guard, only: [:show, :edit, :update, :destroy]

  # GET /guards
  # GET /guards.json
  @shift= Shift.all
  def index
    @guards = Guard.all
  end

  # GET /guards/1
  # GET /guards/1.json
  def show
  end

  # GET /guards/new
  def new
    @guard = Guard.new
  end

  # GET /guards/1/edit
  def edit
  end

  # POST /guards
  # POST /guards.json
  def create
    @guard = Guard.new(guard_params)

    respond_to do |format|
      if @guard.save
        format.html { redirect_to @guard, notice: 'Guard was successfully created.' }
        format.json { render :show, status: :created, location: @guard }
      else
        format.html { render :new }
        format.json { render json: @guard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guards/1
  # PATCH/PUT /guards/1.json
  def update
    respond_to do |format|
      if @guard.update(guard_params)
        format.html { redirect_to @guard, notice: 'Guard was successfully updated.' }
        format.json { render :show, status: :ok, location: @guard }
      else
        format.html { render :edit }
        format.json { render json: @guard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guards/1
  # DELETE /guards/1.json
  def destroy
    @guard.destroy
    respond_to do |format|
      format.html { redirect_to guards_url, notice: 'Guard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guard
      @guard = Guard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guard_params
      params.require(:guard).permit(:first_name, :last_name)
    end
end
