class CoursesController < ApplicationController
  include CoursesHelper
  before_action :set_course, only: [:destroy, :update, :show]
  before_action :training_status, only: [:show]
  before_action :set_training, only: [:complete_training]

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

  def set_training
    @training = Training.find_by(guard_id: params[:guard_id], course_id: params[:course_id])
  end

  def training_status
    @completed_by = Array.new
    @not_completed_by = Array.new
    @course.guards.each do |guard|
      t_status = Training.find_by(guard_id: guard.id, course_id: @course.id).completed_at
      if t_status != nil
        @completed_by << guard
      elsif t_status.nil?
        @not_completed_by << guard
      end
    end
  end

#   def completed?
#     byebug
#   !completed_at.blank?
# end


  def complete_training
    @training.update(completed_at: Time.now)
    respond_to do |format|
      format.html {  redirect_to @course, notice: "Training marked as completed" }
      format.js
    end
  end

  private

  def course_params
    params.require(:course).permit(:subject, :course_id, :guard_id, :instructor_id, :description, :id)
  end

end
