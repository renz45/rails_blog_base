class Admin::PostsController < Admin::BaseController

  def show
    @posts = Post.all
  end

  def new

  end
end
