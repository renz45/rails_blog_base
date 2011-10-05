require "modules/pagination"
require "modules/set_vars"

class Blog::PostsController < Blog::BaseController
  include Pagination::Comments
  include Pagination::Posts
  include SetVars::Posts
  #TODO add edit/moderator links to posts and comments for when admin level users are logged in
  #TODO integrate captcha functionality into comment form

  def show
    @comment = Comment.new

    #Sets @post, @title, @reply_comment, moved to a module since these vars are used again in
    #the comment controller when there is an error
    vars_for_show(params[:id], params[:reply_id]) #SetVars module
    
    # paginate_me is used internally, which sets the @comments variable
    paginate_comments_for_post(params[:id]) #Pagination module
    
    # list of comments including the original comment as well as all replies to each comment
    # keys are :comment, :replies           
    @comment_tree = Comment.build_comments(@comments)

  end

  def index
    @title = "Blog"
    # paginate_me is used internally, which sets the @posts variable
    paginate_index_posts(blog_root_path)#Pagination module
  end

  def search
    # define category and tag variable for use in the view
    @category = Category.find(params[:category_id].split(',')) unless params[:category_id].nil?
    @tag = Tag.find(params[:tag_id].split(',')) unless params[:tag_id].nil?

    # paginate_me is used internally, which sets the @posts variable
    paginate_search_posts(params[:tag_id],params[:category_id])#Pagination module
  end

  private
    
end
