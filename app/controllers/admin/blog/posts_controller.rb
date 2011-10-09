require "modules/pagination"
class Admin::Blog::PostsController < Admin::Blog::BaseController
  before_filter :set_active

  include Pagination::Posts

  def index
    @title = "Posts"
    # paginate_me is used internally, which sets the @posts variable
    paginate_index_posts(blog_root_path)#Pagination module
  end

  def show
    @posts = Post.all
  end

  def new

  end

  private
    def set_active
      @sidebar_active = :posts
    end
end
