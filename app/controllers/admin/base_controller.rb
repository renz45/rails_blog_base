class Admin::BaseController < ApplicationController
  #devise authentication, checks to make sure the user is authenticated
  
  before_filter :admin_authenticate
  
  def admin_authenticate
    authenticate_user!
    redirect_to root_path unless current_user.can_access_admin
  end
end
