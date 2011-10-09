class Admin::Blog::PagesController < Admin::Blog::BaseController

  def index
    @title = "Admin"
    @post_count = Post.count
    @comment_count = Comment.count
    @spam_count = Comment.where(status_id: CommentStatus.where(status: "spam")).count
    @approved_count = Comment.where(status_id: CommentStatus.where(status: "approved")).count
    @pending_count = Comment.where(status_id: CommentStatus.where(status: "unapproved")).count
    @trash_count = Comment.where(status_id: CommentStatus.where(status: "trash")).count
    @tag_count = Tag.count
    @category_count = Category.count
  end
end
