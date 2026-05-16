class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      user.owner? ? scope.all : scope.none
    end
  end

  def index?
    user.owner?
  end

  def new?
    user.owner?
  end

  def create?
    user.owner? # && user.super?
  end

  def edit?
    user.owner? # && user.super?
  end

  def update?
    user.owner? # && user.super?
  end

  def destroy?
    user.owner? # && user.super?
  end
end
