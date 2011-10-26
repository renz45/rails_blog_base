class Admin::Blog::TagsController < Admin::Blog::BaseController
  def create
    @tag = Tag.new(tag: params[:tag])
    respond_to do |format|
      format.html
      format.js { render "admin/blog/tags/create", layout: false }
    end
  end

  def destroy
    @tag = params[:tag]

    respond_to do |format|
      format.html
      format.js { render "admin/blog/tags/destroy", layout: false }
    end
  end

  def update

    #redirect_to :back
  end
end
