class Blog::CommentsController < Blog::BaseController

  def show
    @posts = Post.all
  end

  def new
    #will need a redirect to the post page which owns the comment
  end

  def create
    params[:comment][:ip_address] = request.env['REMOTE_ADDR']

    @comment = Comment.new(params[:comment])
    post_id = params[:comment][:post_id]

    if @comment.save
      flash[:success] = "Thanks for the comment!"

      redirect_to blog_post_path(id: post_id)
    else
      flash[:error] = "Something was wrong with your attempted comment."
      @errors = @comment.errors.messages
      @post = Post.includes(:user).find(post_id)
      @title = "Blog | " + @post.title
      @comments = @post.comments.order('created_at DESC')

      render "blog/posts/show"
    end
  end

end
