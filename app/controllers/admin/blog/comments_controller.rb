class Admin::Blog::CommentsController < Admin::Blog::BaseController
  before_filter :set_active

  def index
    @title = "Comments"
    @comment_types = CommentStatus.all
    @type = "all"
    
    @unapproved_id = CommentStatus.unapproved.first.id
    @approved_id = CommentStatus.approved.first.id

    paginate_me :comments, 
                base_url: admin_blog_comments_path, 
                order: 'created_at DESC', 
                where: {status_id: [@unapproved_id, @approved_id] }
  end

  def search
    @title = "Comments"
    @comment_types = CommentStatus.all
    @type = params[:type]

    current_type = @comment_types.dup.keep_if{|v| v.status == @type}.first
    paginate_me :comments, 
                base_url: admin_blog_comments_path,
                order: 'created_at DESC', 
                where: {status_id: current_type.id},
                page: params[:page] || "1"
    
    render "admin/blog/comments/index"
  end

  def update
    respond_to do |format|
      format.html
      format.js {
        
        comment = Comment.find(params[:id])
        comment.update_attributes(params[:comment])

        update_comment_page_items()
      }
    end
  end

  def update_status
    respond_to do |format|
      format.html
      format.js {
        
        set_status(params[:id],params[:status])

        update_comment_page_items()
      }
    end
  end

  def delete
    respond_to do |format|
      format.html
      format.js {
        
        Comment.find(params[:id]).delete

        update_comment_page_items()
      }
    end
  end

  private
    def set_active
      @sidebar_active = [:comments]
    end

    def update_comment_page_items
      @comment_types = CommentStatus.all
      @type = params[:type]
      @type = 'all' if @type == ""

      if @type == "all"
        where = {status_id: [CommentStatus.unapproved.first.id, CommentStatus.approved.first.id]} 
      else
        current_type = CommentStatus.where(status: @type).first
        where = {status_id: current_type.id}
      end

      paginate_me :comments, 
                  base_url: admin_blog_comments_path,
                  order: 'created_at DESC', 
                  where: where,
                  page: params[:page] || "1"

      render "admin/blog/comments/update.js", layout: false
    end

    def set_status(id,status)
      comment = Comment.find(id)
      comment.update_attributes(status_id: CommentStatus.send(status).first.id)
    end
end
