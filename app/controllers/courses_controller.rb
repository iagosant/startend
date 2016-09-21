class CoursesController < ApplicationController

  before_action :set_course, only: [:destroy, :update, :show]

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

  private

  def course_params
    params.require(:course).permit(:subject, :instructor_id, :description, :id)
  end

end
