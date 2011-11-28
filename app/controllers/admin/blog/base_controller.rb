class Admin::Blog::BaseController < Admin::BaseController
  before_filter :create_sidebar

  #creates the sidemenu in the admin blog section
  def create_sidebar
    post_submenu = {all_posts: {url: admin_blog_posts_url,
                               title: "Edit Posts",
                               target: "",
                               submenu: nil},

                    add_post: {url: new_admin_blog_post_url,
                              title: "Add Post",
                              target: "",
                              submenu: nil},

                    categories: {url: admin_blog_categories_url,
                                title: "Edit Categories",
                                target: "",
                                submenu: nil},

                    tags: {url: admin_blog_tags_url,
                              title: "Edit Tags",
                              target: "",
                              submenu: nil} }

    # link_submenu = {all_links: {url: "#",
    #                             title: "Edit Links",
    #                             target: "",
    #                             submenu: nil},

    #                 add_link: {url: "#",
    #                           title: "Add Link",
    #                           target: "",
    #                           submenu: nil} }




    @sidebar = {posts:    {url: admin_blog_posts_url,
                          title: "Edit Posts",
                          target: "",
                          submenu: post_submenu},

                comments: {url: admin_blog_comments_url,
                          title: "Edit Comments",
                          target: "",
                          submenu: nil},

                links:    {url: admin_blog_links_page_url,
                          title: "Edit  Links",
                          target: "",
                          submenu: nil} }
  end
end