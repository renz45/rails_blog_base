require "modules/pagination"
class Admin::Blog::PostsController < Admin::Blog::BaseController
  before_filter :set_active

  include Pagination::Posts

  def index
    @title = "Posts"
    @post_types = PostStatus.all
    @type = params[:type]
    # paginate_me is used internally, which sets the @posts variable
    if @type.nil?
      paginate_index_posts(admin_blog_posts_url)
    else
      paginate_index_posts(admin_blog_posts_type_url(@type), @type)
    end

    #Pagination module
  end

  def show
    @posts = Post.all
  end

  def search
    # define category and tag variable for use in the view
    @category = Category.where(slug: params[:category].split(',')) unless params[:category].nil?
    @tag = Tag.where(slug: params[:tag].split(',')) unless params[:tag].nil?
    @post_types = PostStatus.all
    @type = params[:type] || "all"
    
    # paginate_me is used internally, which sets the @posts variable
    paginate_search_posts(@tag,@category, "/admin/blog/posts/type/#{@type}", @type)#Pagination module
  end

  def new

  end

  private
    def set_active
      @sidebar_active = :posts
    end
end
