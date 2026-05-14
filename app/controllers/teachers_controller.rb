class TeachersController < ApplicationController
  layout "klass"

  before_action :set_klass
  before_action :set_teacher, only: %i[ show destroy ]

  def index
    @teachers = policy_scope(@klass.teachers)
    @teachers = @teachers.search(params[:q]) if params[:q].present?
    @teachers = @teachers.page(params[:page])
  end

  def show
  end

  def new
    @teacher = @klass.teachers.new
    authorize @teacher
  end

  def create
    @teacher = authorize @klass.teachers.new(user_id: teacher_params[:id], klass_id: @klass.id)
    if @teacher.save
      redirect_to [ @klass, @teacher ], notice: "teacher created", status: :see_other
    else
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    authorize @teacher
    @teacher.destroy
    redirect_to [ @klass, :teachers ], alert: "teacher deleted"
  end

  private
    def set_klass
      @klass = policy_scope(Klass).find(params[:klass_id])
    end

    def set_teacher
      @teacher = policy_scope(Teacher).find(params[:id])
    end

    def teacher_params
      params.require(:teacher).permit(:id)
    end
end
