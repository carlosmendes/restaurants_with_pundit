class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all # see all the restaurants
        # Restaurant.all
      else
        scope.where(user: user) # owners only see their restaurants
        # Restaurant.where(user: user)
      end
    end
  end


  def create?
    true
  end

  # Same as parent ApplicationPolicy, so we do not need it!
  # def new?
  #   create?
  # end
  #
  #

  def update?
    # if its the owner he can update
    # if user == record.user
    #   true
    # else
    #   false
    # end
    is_owner?
  end

  # Same as parent ApplicationPolicy, so we do not need it!
  # def edit?
  #   update?
  # end
  #

  def destroy?
    # if owner or admin can destroy
    is_owner? || user.admin
  end

  private

  def is_owner?
    user == record.user
  end


end
