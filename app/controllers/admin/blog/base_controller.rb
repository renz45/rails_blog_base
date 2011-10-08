class Admin::Blog::BaseController < Admin::BaseController
  before_filter :create_sidebar


  def create_sidebar
    post_submenu = {all_posts: {url: admin_blog_posts_url,
                                title: "Edit Posts",
                                target: "",
                                submenu: nil},

                    add_post: {url: admin_blog_comments_url,
                             title: "Edit Comments",
                              target: "",
                              submenu: nil},

                    categories: {url: admin_blog_comments_url,
                             title: "Edit Comments",
                              target: "",
                              submenu: nil},

                    tags: {url: admin_blog_comments_url,
                             title: "Edit Comments",
                              target: "",
                              submenu: nil} }




    @sidebar = {posts:    {url: admin_blog_posts_url,
                          title: "Edit Posts",
                          target: "",
                          submenu: post_submenu},

                comments: {url: admin_blog_comments_url,
                          title: "Edit Comments",
                          target: "",
                          submenu: nil} }
  end
end