class Owner::BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end
  def show?
    record.user == user
  end

  def create?
    true
  end

  def edit?
    record.user == user
  end

  def update?
    record.kitchen.user == user
  end

  def destroy?
    record.user == user
  end
end
