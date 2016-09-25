class CoursesController < ApplicationController

  before_action :set_course, only: [:destroy, :update, :show]
  before_action :training_status, only: [:index, :show]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def show

  end

  def create
    @course = Course.create(course_params)
    if @course.save
      redirect_to courses_path
    end
  end

  def destroy
    @course.delete
    respond_to do |format|
      format.html { redirect_to courses_path, notice: 'User was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def training_status
    @completed_by = Array.new
    @not_completed_by = Array.new
    @course.guards.each do |guard|
      t_status = Training.find_by(guard_id: guard.id, course_id: @course.id)

      if t_stauts = false
        @not_completed_by << guard
      else
        @completed_by << guard
      end
    end
  end

  private

  def course_params
    params.require(:course).permit(:subject, :instructor_id, :description, :id)
  end

end
