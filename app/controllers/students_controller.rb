class StudentsController < ApplicationController
  layout "klass"

  before_action :set_klass
  before_action :set_student, only: %i[ show destroy ]

  def index
    @students = policy_scope(@klass.students)
    @students = @students.search(params[:q]) if params[:q].present?
    @students = @students.page(params[:page])
  end

  def show
  end

  def new
    @student = @klass.students.new
    authorize @student
  end

  def create
    @student = authorize @klass.students.new(user_id: student_params[:id], klass_id: @klass.id)
    if @student.save
      redirect_to [ @klass, @student ], notice: "student created", status: :see_other
    else
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    authorize @student
    @student.destroy
    redirect_to [ @klass, :students ], alert: "student deleted"
  end

  private
    def set_klass
      @klass = policy_scope(Klass).find(params[:klass_id])
    end

    def set_student
      @student = policy_scope(Student).find(params[:id])
    end

    def student_params
      params.require(:student).permit(:id)
    end
end
