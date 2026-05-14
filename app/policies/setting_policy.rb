class SettingPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      user.owner? ? scope.all : scope.none
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
