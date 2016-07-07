#SHIFT controller is linked to UserPolicy,
#not to this ShiftPolicy.
#To modify ShiftController permissions
#go to UserPolicy.

class ShiftPolicy
  attr_reader :current, :model

  def initialize(current, model)
    @logged_user = current
    @user = model
  end

  def index?
    @logged_user.role == "employee"
  end

  def show?
    @logged_user.role == "employee" || @logged_user == @user
  end
  def destroy?
    @logged_user.role == "employee"
  end

  def edit?
    @logged_user.role == "employee"
  end

  def update?
    @logged_user.role == "employee"
  end

end
