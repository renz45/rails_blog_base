class Admin::Blog::CommentsController < Admin::Blog::BaseController
  before_filter :set_active

  def show
    @posts = Post.all
  end

  def index 
    #@comments = Comment.includes(:post).all
    paginate_me :comments, base_url: admin_blog_comments_path, order: :updated_at
  end

  def new

  end
  private
    def set_active
      @sidebar_active = :comments
    end
end
