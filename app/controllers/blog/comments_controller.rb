require "modules/pagination"
require "modules/set_vars"

class Blog::CommentsController < Blog::BaseController
  include Pagination::Comments
  include SetVars::Posts

  def show
    @posts = Post.all
  end

  def new
    #will need a redirect to the post page which owns the comment
  end

  def create
    #save the ip address of posting user
    params[:comment][:ip_address] = request.env['REMOTE_ADDR']
    params[:comment][:status_id] = 2

    @comment = Comment.new(params[:comment])
    post_id = params[:comment][:post_id]

    if @comment.save
      flash[:success] = "Thanks for the comment!"

      redirect_to blog_post_path(id: post_id)
    else
      flash[:error] = "Something was wrong with your attempted comment."

      @errors = @comment.errors.messages

      #Sets @post, @title, @reply_comment, moved to a module since these vars
      #are also used in the post controller
      vars_for_show(post_id, params[:comment][:reply_id])#ShowVars module

      paginate_comments_for_post(post_id)#Pagination module
    
      # list of comments including the original comment as well as all replies to each comment
      # keys are :comment, :replies           
      @comment_tree = Comment.build_comments(@comments)

      render "blog/posts/show"
    end
  end

end
