module SetVars
  module Posts
    # sets vars for the show action in the PostsController
    #reused in the error return in CommentsController#Create
    def vars_for_show(post_slug, reply_id)
      @post = Post.includes(:user).where(posts: {slug: post_slug})[0]
      @title = "Blog | " + @post.title
      @reply_comment = Comment.find(reply_id) unless reply_id.nil?    
    end
  end
end
