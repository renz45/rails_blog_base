class Admin::Settings::UsersController < Admin::Settings::BaseController

  def show
    @users = User.all
  end
end
