class AssignmentsController < ApplicationController
  layout "klass"

  before_action :set_klass, only: %i[ index new create ]
  before_action :set_assignment, only: %i[ show edit update destroy ]

  def index
    @assignments = policy_scope(@klass.assignments)
      .order(deadline: :desc)
    @assignments = @assignments.page(params[:page])
  end

  def show
  end

  def new
    @assignment = @klass.assignments.new
    authorize @assignment
  end

  def create
    @assignment = authorize @klass.assignments.new(assignment_params)
    @assignment.user = Current.user

    if @assignment.save
      redirect_to [ @klass, @assignment ], notice: "assignment created", status: :see_other
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    authorize @assignment
  end

  def update
    authorize @assignment
    if @assignment.update(assignment_params)
      redirect_to [ @assignment.klass, @assignment ], notice: "assignment updated"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    authorize @assignment
    klass = @assignment.klass
    @assignment.destroy
    redirect_to [ klass, :assignments ], alert: "assignment deleted"
  end

  private
    def set_klass
      @klass = policy_scope(Klass).find(params[:klass_id])
    end

    def set_assignment
      @assignment = policy_scope(Assignment).find(params[:id])
      @klass = @assignment.klass
    end

    def assignment_params
      params.require(:assignment).permit(
        :title,
        :description,
        :deadline,
        :file,
        :max_score,
        :weight,
        :max_attempts,
        accept_content_types: []
      )
    end
end
