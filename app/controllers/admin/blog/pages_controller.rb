class Admin::Blog::PagesController < Admin::Blog::BaseController

  def index
    @title = "Admin"
    @post_count = Post.count
    @comment_count = Comment.count
    @spam_count = Comment.spam.count
    @approved_count = Comment.approved.count
    @pending_count = Comment.unapproved.count
    @trash_count = Comment.trash.count
    @tag_count = Tag.count
    @category_count = Category.count
  end
end
