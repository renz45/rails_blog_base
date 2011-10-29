require "modules/pagination"
class Admin::Blog::PostsController < Admin::Blog::BaseController
  before_filter :set_active

  include Pagination::Posts

  def index
    @title = "Posts"
    @post_types = PostStatus.all
    @type = params[:type] || "all"
    # paginate_me is used internally, which sets the @posts variable
    if @type.nil?
      paginate_index_posts(admin_blog_posts_url) # paginate module
    else
      paginate_index_posts(admin_blog_posts_search_url(type: @type)) # paginate module
    end
  end

  def edit
    @title = "Edit Post"
    @post = Post.includes(:tags).find(params[:id])
    @categories = Category.order(:category)
    @tags = @post.tags().order(:tag)
    @statuses = PostStatus.all
    @current_status = @post.post_status
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
    @statuses = PostStatus.all
    @current_status = PostStatus.published

    render "admin/blog/posts/edit"
  end

  def destroy
    Post.find(params[:id]).delete

    redirect_to :back
  end

  def trash
    post = Post.find(params[:id])

    post.trash!

    redirect_to :back
  end

  def update
    @title = "Edit Post"
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])

    set_params()
    get_categories_tags()
    attempt_to_save_post()
  end

  def create
    @title = "Add Post"
    params[:post][:user_id] = current_user.id
    @post = Post.new(params[:post])

    set_params()
    get_categories_tags()

    attempt_to_save_post()
  end

  private
    def set_active
      @sidebar_active = :posts
    end

    def set_params
      @post.categories = params[:categories].map {|c| Category.find_or_create_by_category(category: c)} unless params[:categories].nil?
      @post.tags = params[:tags].map {|t| Tag.find_or_create_by_tag(tag: t)} unless params[:tags].nil?
      @post.status_id = params[:status]
    end

    def get_categories_tags
      @categories = Category.order(:category)
      @tags = @post.tags().order(:tag)
    end

    def attempt_to_save_post
      if @post.save
        flash[:success] = "Post was updated successfully"
        redirect_to :back
      else
        flash[:form_error] = "uh oh! There was a problem"
        @errors = @post.errors.messages
        render "admin/blog/posts/edit"
      end
    end
end
