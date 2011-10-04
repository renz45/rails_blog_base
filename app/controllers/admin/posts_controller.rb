class Admin::PostsController < Admin::BaseController

  def index

  end

  def show
    @posts = Post.all
  end

  def new

  end
end
