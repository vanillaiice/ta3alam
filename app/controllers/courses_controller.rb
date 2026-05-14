class CoursesController < ApplicationController
  layout "dashboard"

  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = policy_scope(Course)
    @courses = @courses.search(params[:q]) if params[:q].present?
    @courses = @courses.page(params[:page])
  end

  def show
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = authorize Course.new(course_params)
    if @course.save
      redirect_to @course, notice: "course created"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    authorize @course
  end

  def update
    authorize @course
    if @course.update(course_params)
      redirect_to @course, notice: "course updated"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @course
    @course.destroy
    redirect_to [ :courses ], alert: "course deleted"
  end

  private
    def set_course
      @course = policy_scope(Course).find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :number, :description)
    end
end
