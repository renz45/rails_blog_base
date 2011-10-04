class Blog::PostsController < Blog::BaseController
  #TODO refactor model calls to their own function in the models where possible
  #TODO add edit/moderator links to posts and comments for when admin level users are logged in

  def show
    @post = Post.includes(:user).find(params[:id])
    @title = "Blog | " + @post.title
    @comment = Comment.new

    # comment being replied to, if reply was clicked
    @reply_comment = Comment.find(params[:reply_id]) unless params[:reply_id].nil?

    #paginate comments for the current post which aren't replies with a status of approved(1)
    paginate_me :comments, where: {comments: {post_id: params[:id], reply_id: nil, status_id: 1}},
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

    # build the url and where/includes statements based on tags and/or categories
    # this seems long because it takes into account both categories or tags seperately
    # or both categories and tags together incase narrowing a search is wanted
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

   paginate_me(:posts, where: where, includes: includes, params_var: :page, base_url: page_url)
  end

  private
    # recursive function that builds a comment object
    # NOTE I traded server calls for 2 map functions, this will save a lot of server calls depending on
    #      how many replies there are for each comment, could be slower than just doing the queries, 
    #      I'm not sure yet.
    def build_comments(initial_comments)
      comment_list = {}

      # get all replies for the initial_comments
      reply_list = Comment.where(reply_id: initial_comments.map{|ic| ic.id})

      # loop through initial_comments
      initial_comments.each do |c|
        comment_list[c.id] = {}
        comment_list[c.id][:comment] = c
        
        # pull out the individual replies for each comment looped through
        replies = reply_list.map{|r| r if r.reply_id == c.id} 

        # if there were any replies send them back through this function to check if they have comments
        comment_list[c.id][:replies] = (replies == [nil] ? [] : build_comments(replies) )
      end
      comment_list
    end
  
  
end
