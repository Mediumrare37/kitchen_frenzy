class KitchenPolicy < ApplicationPolicy
  def resolve
    scope.all
  end

  def show?
    true
  end

  def create?
    true
  end

  def edit
    record.user == user
  end

  def update
    record.user == user
  end

  def destroy
    record.user == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
  end
end
