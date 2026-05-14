class SubmissionsController < ApplicationController
  layout "klass"

  before_action :set_assignment, only: %i[ index new create ]
  before_action :set_submission, only: %i[ show edit update destroy grade ]

  def index
    @submissions = policy_scope(@assignment.submissions)
    @submissions = @submissions.page(params[:page])
  end

  def show
  end

  def new
    @submission = @assignment.submissions.new
    authorize @submission
  end

  def create
    @submission = authorize @assignment.submissions.new(submission_params)
    @submission.user = Current.user

    if @submission.save
      redirect_to [ @klass, @submission ], notice: "submission created", status: :see_other
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    authorize @submission
  end

  def update
    authorize @submission
    if @submission.update(submission_params)
      redirect_to @submission, notice: "submission updated"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def grade
    authorize @submission
    if request.patch?
      new_score = grade_submission_params[:score].to_i
      @submission.is_graded = true

      if new_score > @submission.assignment.max_score
        @submission.assign_attributes(grade_submission_params)
        @submission.errors.add(:score, "cannot exceed maximum (#{@submission.assignment.max_score})")
        render :grade, status: :bad_request
      elsif @submission.update(grade_submission_params)
        redirect_to [ @klass, @submission ], notice: "grade submitted"
      else
        render :grade, status: :unprocessable_content
      end
    else
      render :grade
    end
  end

  def destroy
    authorize @submission
    assignment = @submission.assignment
    @submission.destroy
    redirect_to [ assignment.klass, assignment, :submissions ], alert: "submission deleted"
  end

  private
    def set_assignment
      @assignment = policy_scope(Assignment).find(params[:assignment_id])
      @klass = @assignment.klass
    end

    def set_submission
      @submission = policy_scope(Submission).find(params[:id])
      @klass = @submission.assignment.klass
    end

    def submission_params
      params.require(:submission).permit(
        :notes,
        :submission_file,
      )
    end

    def grade_submission_params
      params.require(:submission).permit(
        :score,
        :feedback,
        :graded_submission_file
      )
    end
end
