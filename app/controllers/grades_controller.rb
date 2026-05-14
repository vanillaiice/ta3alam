class GradesController < ApplicationController
  layout "klass"

  def index
    @klass = Klass.find(params[:klass_id])
    @grades = Submission
      .joins(:assignment)
      .where(is_graded: true)
      .where(user: Current.user)
      .where(assignments: { klass: @klass })
  end
end
