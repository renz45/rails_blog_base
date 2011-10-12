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
      paginate_index_posts(admin_blog_posts_url) # paginate module
    else
      paginate_index_posts(admin_blog_posts_search_url(type: @type), @type) # paginate module
    end
  end

  # NOTE probably won't need this for the admin
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
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
    @post = Post.new
  end

  def destroy
    Post.find(params[:id]).delete

    redirect_to :back
  end

  private
    def set_active
      @sidebar_active = :posts
    end
end
