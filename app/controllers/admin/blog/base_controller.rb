class Admin::Blog::BaseController < Admin::BaseController
  before_filter :create_sidebar


  def create_sidebar
    @sidebar = {posts:    {url: admin_blog_posts_url,
                          title: "Edit Posts",
                          target: "",
                          submenu: nil},

                comments: {url: admin_blog_comments_url,
                          title: "Edit Comments",
                          target: "",
                          submenu: nil} }
  end
end