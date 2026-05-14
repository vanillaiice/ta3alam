class AnnouncementPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      case user.role
      when "owner"
        scope.all
      when "teacher"
        scope.joins(klass: :teachers)
          .where(teachers: { user: user })
      when "student"
        scope.joins(klass: :students)
          .where(students: { user: user })
      else
        scope.none
      end
    end
  end

  def new?
    teacher_in_klass?
  end

  def create?
    teacher_in_klass?
  end

  def edit?
    teacher_in_klass?
  end

  def update?
    teacher_in_klass?
  end

  def destroy?
    teacher_in_klass? || user.owner?
  end

  private
  def teacher_in_klass?
    return false unless user.teacher?
    record.klass.teachers.exists?(user: user)
  end
end
