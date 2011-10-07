class Admin::Blog::CommentsController < Admin::Blog::BaseController
  before_filter :set_active

  def show
    @posts = Post.all
  end

  def index 

  end

  def new

  end
  private
    def set_active
      @sidebar_active = :comments
    end
end
