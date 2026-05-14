class TeacherPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      case user.role
      when "owner"
        scope.all
      when "teacher"
        scope
          .where(klass_id: user.teachers.select(:klass_id))
      when "student"
        scope
          .where(klass_id: user.students.select(:klass_id))
      else
        scope.none
      end
    end
  end

  def new?
    user.owner?
  end

  def create?
    user.owner?
  end

  def edit?
    user.owner?
  end

  def update?
    user.owner?
  end

  def destroy?
    user.owner?
  end
end
