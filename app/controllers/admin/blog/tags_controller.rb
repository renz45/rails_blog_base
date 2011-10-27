class Admin::Blog::TagsController < Admin::Blog::BaseController

  def index
    tags = Tag.all.map{|t| t.tag}

    respond_to do |format|
      format.html
      format.json { render json: tags }
    end
    
  end

  def create
    @tags = []
    tags = params[:tags].split(',')#Tag.new(tag: params[:tag])
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
