class Admin::UsersController < Admin::BaseController

  def show
    @users = User.all
  end
end
