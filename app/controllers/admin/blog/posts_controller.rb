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

  def edit
    @title = "Edit Post"
    @post = Post.find(params[:id])
    @categories = Category.order(:category)
    #@form_url = edit_admin_blog_post_url(@post.id)
  end

  def search
    @title = "Posts"
    # define category and tag variable for use in the view
    @category = Category.where(slug: params[:category].split(',')) unless params[:category].nil?
    @tag = Tag.where(slug: params[:tag].split(',')) unless params[:tag].nil?
    @post_types = PostStatus.all
    @type = params[:type] || "all"

    # paginate_me is used internally, which sets the @posts variable
    paginate_search_posts(@tag,@category, "/admin/blog/posts/type/#{@type}", @type)#Pagination module
  end

  def new
    @title = "New Post"
    @post = Post.new
    @categories = Category.order(:category)
    render "admin/blog/posts/edit"
  end

  def destroy
    Post.find(params[:id]).delete

    redirect_to :back
  end

  def trash
    post = Post.find(params[:id])
    post.post_status = PostStatus.trashed
    post.save
    redirect_to :back
  end

  def update
    binding.pry
  end

  def create
    binding.pry
  end

  private
    def set_active
      @sidebar_active = :posts
    end
end
