class Admin::Blog::TagsController < Admin::Blog::BaseController

  def index
    tags = Tag.select('tag').map{|t| t.id}

    respond_to do |format|
      format.html
      format.json { render json: tags }
    end
    
  end

  def create
    @tags = []
    tags = params[:tags].split(',')
    tags.each do |t|
      @tags.push(Tag.new(tag: t))
    end

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
