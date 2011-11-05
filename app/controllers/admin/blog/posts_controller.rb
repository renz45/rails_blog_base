require "modules/pagination"
require "modules/set_vars"
class Admin::Blog::PostsController < Admin::Blog::BaseController
  before_filter :set_active

  include Pagination::Posts
  include Pagination::Comments
  include SetVars::Posts

  def index
    @title = "Posts"
    @sidebar_active << :all_posts

    @post_types = PostStatus.all
    @type = params[:type] || "all"

    paginate_index_posts(admin_blog_posts_search_url(type: @type)) # paginate module

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
    @sidebar_active << :all_posts
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
    @sidebar_active << :add_post
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
    @preview = (params[:commit] == "Preview")
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])

    set_params()
    get_categories_tags()
    attempt_to_save_post()
  end

  def create
    params[:post][:user_id] = current_user.id
    @post = Post.new(params[:post])

    set_params()
    get_categories_tags()

    attempt_to_save_post()
  end

  #seems a bit crude, I'll need to clean this up at some point
  def create_preview
    params[:post][:user_id] = current_user.id
    params[:post][:title] << " %preview%"

    #destroy the preview if one exists (result of hitting preview multiple times before post submit)
    preview = Post.where(title: params[:post][:title]).first()
    if preview
      preview.destroy
    end

    @post = Post.new(params[:post])

    set_params()
    get_categories_tags()
    @post.status_id = PostStatus.draft.id

    @post.categories = Category.where(category: params[:categories])
    @post.tags = Tag.where(tag: params[:tags])
    if @post.save
      respond_to do |format|
        format.html
        format.js { render json: @post.id }
      end
    else
      @errors = @post.errors.messages
      respond_to do |format|
        format.html
        format.js { render json: @errors }
      end
    end
  end

  def show_preview
    @title = "Preview"

    @comment = Comment.new

    # sort of hacky, when the preview is loaded the tempary saved draft in the DB is deleted
    # so if the user refreshes the preview it redirects to the home page, the preview expires
    # after one use. I don't really like this, maybe something involving the session would be 
    # a better solution. I'll come to this later.
    begin
    temp_post = Post.find(params[:id]) 
    @post = temp_post
    @post.title = @post.title.split("%preview%")[0]
    @categories = Category.all
    @tags = Tag.all

    # paginate_me is used internally, which sets the @comments variable
    paginate_comments_for_post(@post) #Pagination module    
    @comment_tree = {}
    temp_post.delete
    render "blog/posts/show", layout: "blog/layouts/application"
    rescue Exception => e
      redirect_to blog_root_url
    end
  end

  private
    def set_active
      @sidebar_active = [:posts]
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
