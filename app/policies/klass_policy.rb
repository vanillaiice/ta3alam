class KlassPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      case user.role
      when "owner"
        scope
      when "teacher"
        scope.joins(:teachers)
          .where(teachers: { user: user })
      when "student"
        scope.joins(:students)
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
