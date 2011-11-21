require "modules/pagination"
require "modules/set_vars"

class Blog::PostsController < Blog::BaseController
  include Pagination::Comments
  include Pagination::Posts
  include SetVars::Posts
  #TODO integrate captcha functionality into comment form

  def show 
    @comment = Comment.new
          
    #Sets @post, @title, @reply_comment, moved to a module since these vars are used again in
    #the comment controller when there is an error

    vars_for_show(params[:slug], params[:reply_id]) #SetVars module
    
    # paginate_me is used internally, which sets the @comments variable
    paginate_comments_for_post(@post) #Pagination module

    # @post.content = markdown.render(@post.content)
    
    # list of comments including the original comment as well as all replies to each comment
    # keys are :comment, :replies
          
    @comment_tree = Comment.build_comments(@comments)

  end

  def index
    @title = "Blog"
    # paginate_me is used internally, which sets the @posts variable
    paginate_index_posts(blog_root_path,:published)#Pagination module
  end

  def search
    # define category and tag variable for use in the view
    @category = Category.where(slug: params[:category].split(',')) unless params[:category].nil?
    @tag = Tag.where(slug: params[:tag].split(',')) unless params[:tag].nil?
    
    # paginate_me is used internally, which sets the @posts variable
    paginate_search_posts(@tag,@category,"/blog/posts", :published)#Pagination module
  end

  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "Feed"

    # the news items
    @feed_items = Post.order("updated_at desc")

    # this will be our Feed's update timestamp
    @updated = @feed_items.first.updated_at unless @feed_items.empty?

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end
    
end
