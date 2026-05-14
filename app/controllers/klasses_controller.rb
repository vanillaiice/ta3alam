class KlassesController < ApplicationController
  layout "klass"

  before_action :set_course, only: %i[ index new create ]
  before_action :set_klass, only: %i[show edit update destroy]

  def index
    @klasses = policy_scope(Klass)

    if @course
      @klasses = @klasses.joins(:course)
        .where(course: @course)
    end

    @klasses = @klasses.search(params[:q]) if params[:q].present?
    @klasses = @klasses.page(params[:page])
  end

  def show
    @contents = policy_scope(@klass.contents)
    @contents = @contents.order(:module_name, :created_at)
  end

  def new
    @klass = Klass.new
    authorize @klass
  end

  def create
    @klass = authorize Klass.new(klass_params)
    @klass.course = @course
    if @klass.save
      redirect_to @klass, notice: "class created"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    authorize @klass
  end

  def update
    authorize @klass
    if @klass.update(klass_params)
      redirect_to @klass, notice: "class updated"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @klass
    course = @klass.course
    @klass.destroy
    redirect_to [ @klass.course, :klasses ], alert: "class deleted"
  end

  private
    def set_course
      @course = policy_scope(Course).find(params[:course_id]) if params[:course_id].present?
    end

    def set_klass
      @klass = policy_scope(Klass).find(params[:id])
    end

    def klass_params
      params.require(:klass).permit(:code)
    end
end
