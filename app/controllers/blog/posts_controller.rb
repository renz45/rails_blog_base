class Blog::PostsController < Blog::BaseController
  #TODO refactor model calls to their own function in the models where possible

  def show
    @post = Post.includes(:user).find(params[:id])
    @title = "Blog | " + @post.title
    @comment = Comment.new
    @reply_comment = Comment.find(params[:reply_id]) unless params[:reply_id].nil?

    paginate_me :comments, where: {comments: {post_id: params[:id], reply_id: nil}}, 
                           base_url: blog_post_path(params[:id]), 
                           per_page: 5,
                           order: "created_at DESC"
    
    # list of comments including the original comment as well as all replies to each comment
    # keys are :comment, :replies           
    @comment_tree = build_comments(@comments)

  end

  def index
    @title = "Blog"

    paginate_me(:posts, params_var: :posts_page, base_url: blog_root_path)
  end

  def search
    # define category and tag variable for use in the view
    @category = Category.find(params[:category_id].split(',')) unless params[:category_id].nil?
    @tag = Tag.find(params[:tag_id].split(',')) unless params[:tag_id].nil?

    includes = []
    where = {}
    page_url = "/blog"

    unless params[:category_id].nil?
      includes << :category_to_posts
      where[:category_to_posts] = {category_id: params[:category_id]}
      page_url << "/category/#{params[:category_id]}"
    end

    unless params[:tag_id].nil?
      includes << :tag_to_posts
      where[:tag_to_posts] = {tag_id: params[:tag_id]}
      page_url << "/tag/#{params[:tag_id]}"
    end

    # posts/category_to_posts/category_id/2/tag_to_posts/tag_id/4
   paginate_me(:posts, where: where, includes: includes, params_var: :page, base_url: page_url)
  end

  def new

  end

  private
    # recursive function that builds a comment object
    # TODO Investigate a more efficiant way to do this
    def build_comments(inital_comments)
      comment_list = {}

      inital_comments.each do |c|
        comment_list[c.id] = {}
        comment_list[c.id][:comment] = c
        comment_list[c.id][:replies] = build_comments(Comment.where(reply_id: c.id))
      end
      comment_list
    end
  
  
end
