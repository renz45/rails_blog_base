class Admin::Blog::PostsController < Admin::Blog::BaseController
  before_filter :set_active

  def index

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
