module ApplicationHelper
  #return a title on a per-page basis
  def title
    base_title = "My Site"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def nav_sign_in_items(admin_items = false)

    if user_signed_in?
      nav_str = content_tag(:li, "<span>Welcome #{current_user.user_name}</span>".html_safe)
      nav_str << content_tag(:li, link_to("sign out", destroy_user_session_url, method: :delete))
    else
      nav_str = content_tag(:li, link_to("Sign In", new_user_session_url))
      nav_str << content_tag(:li, link_to("Register", new_user_registration_url))
    end
    
    if !current_user.nil? && current_user.can_access_admin?
       nav_str << content_tag(:li , ( admin? ? link_to("Home", root_url) : link_to("Admin", admin_root_url) ) )
    end

    content_tag(:ul,nav_str).html_safe
  end

  def admin?
    self.controller.class.to_s.split("::")[0] == "Admin"
  end
end
