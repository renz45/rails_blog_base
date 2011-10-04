module ApplicationHelper
  #return a title on a per-page basis
  def title
    base_title = "blog"
    if @title.nil?
      base_title
    else
      "#{@title}"
    end
  end

  def nav_sign_in_items
    if user_signed_in?
      nav_str = content_tag(:li, "Welcome #{current_user.user_name}")
      nav_str << content_tag(:li, link_to("sign out", destroy_user_session_path, method: :delete))
    else
      nav_str = content_tag(:li, link_to("Sign In", new_user_session_url))
      nav_str << content_tag(:li, link_to("Register", new_user_registration_url))
    end

    if !current_user.nil? && current_user.can_access_admin
      nav_str << content_tag(:li, link_to("Admin", admin_root_url))
    end
    nav_str.html_safe
  end
end
