class CoursePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      case user.role
      when "owner"
        scope.all
      when "teacher"
        scope.joins(klasses: :teachers)
          .where(teachers: { user: user })
          .distinct
      when "student"
        scope.joins(klasses: :students)
          .where(students: { user: user })
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
