class SubmissionPolicy < ApplicationPolicy
  def expected_attributes_for_action(action_name)
    case action_name
    when :create
    when :edit
    when :grade
      [ :grade ]
    else
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      case user.role
      when "owner"
        scope.all
      when "teacher"
        scope.joins(assignment: { klass: :teachers })
          .where(teachers: { user: user })
      when "student"
        scope.joins(assignment: { klass: :students })
          .where(students: { user: user })
      else
        scope.none
      end
    end
  end

  def new?
    student_in_klass? && !deadline_expired?
  end

  def create?
    student_in_klass?
  end

  def edit?
    teacher_in_klass?
  end

  def grade?
    teacher_in_klass?
  end

  def update?
    teacher_in_klass?
  end

  def destroy?
    user.owner?
  end

  private
  def teacher_in_klass?
    return false unless user.teacher?
    record.assignment.klass.teachers.exists?(user: user)
  end

  def student_in_klass?
    return false unless user.student?
    record.assignment.klass.students.exists?(user: user)
  end

  def deadline_expired?
    return false unless record.assignment&.deadline
    Time.current > record.assignment.deadline
  end
end
