module SetVars
  module Posts
    # sets vars for the show action in the PostsController
    def vars_for_show(post_id, reply_id)
      @post = Post.includes(:user).find(post_id)
      @title = "Blog | " + @post.title
      @reply_comment = Comment.find(reply_id) unless reply_id.nil?    
    end
  end
end
