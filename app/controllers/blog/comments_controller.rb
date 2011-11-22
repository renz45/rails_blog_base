require "modules/pagination"
require "modules/set_vars"

class Blog::CommentsController < Blog::BaseController
  include Pagination::Comments
  include SetVars::Posts

  def show
    @posts = Post.all
  end

  def create
    @captcha = Captcha.new

    #save the ip address of posting user
    params[:comment][:ip_address] = request.env['REMOTE_ADDR']
    params[:comment][:status_id] = 2

    slug = params[:comment].delete(:slug)

    @comment = Comment.new(params[:comment])
    #post_id = params[:comment][:post_id]

    # validates the captcha
    unless @captcha.is_valid(params)
      flash[:error] = "Human test failed, either your a robot, or you made a mistake."

      vars_for_show(slug, params[:comment][:reply_id])#ShowVars module

      paginate_comments_for_post(@post)#Pagination module
    
      # list of comments including the original comment as well as all replies to each comment
      # keys are :comment, :replies           
      @comment_tree = Comment.build_comments(@comments)

      render "blog/posts/show"
      return
    end

    if @comment.save
      flash[:success] = "Thanks for the comment!"

      redirect_to blog_post_path(slug)
    else
      flash[:error] = "Something was wrong with your attempted comment."

      @errors = @comment.errors.messages

      #Sets @post, @title, @reply_comment, moved to a module since these vars
      #are also used in the post controller
      vars_for_show(slug, params[:comment][:reply_id])#ShowVars module

      paginate_comments_for_post(@post)#Pagination module
    
      # list of comments including the original comment as well as all replies to each comment
      # keys are :comment, :replies           
      @comment_tree = Comment.build_comments(@comments)

      render "blog/posts/show"
    end
  end

end
