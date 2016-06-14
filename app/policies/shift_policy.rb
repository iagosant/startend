class ShiftPolicy
  attr_reader :current, :model

  def initialize(current, model)
    byebug
    @logged_user = current
    @user = model
  end

  def index?
    byebug
    @logged_user.role == "employee"
  end

  def show?
    byebug
    @logged_user.role == "master" || @logged_user == @user
  end
  def destroy?
    @logged_user.role == "master"
  end

  def edit?
    @logged_user.role == "master"
  end

  def update?
    @logged_user.role == "master"
  end

end
