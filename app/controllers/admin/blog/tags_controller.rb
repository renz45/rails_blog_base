class Admin::Blog::TagsController < Admin::Blog::BaseController

  def index
    
    respond_to do |format|
      format.html {
        @tag = Tag.new
        paginate_tag_page(params[:page])
      }
      format.json { render json: Tag.select('tag').map{|t| t.id} }
    end
    
  end

  def create

    respond_to do |format|
      format.html
      format.js { 
        @tags = []

        if params[:tags]
          tags = params[:tags].split(',')
          tags.each do |t|
            @tags.push(Tag.find_or_create_by_tag(tag: t))
          end
        end

        if params[:tag]
          Tag.find_or_create_by_tag(tag: params[:tag][:tag])
          paginate_tag_page(params[:page])
        end

        render "admin/blog/tags/create", layout: false 
      }
    end
  end

  def destroy
    respond_to do |format|
      format.html
      format.js { 
        @tag = params[:tag]

        Tag.delete(Tag.where(tag: params[:tag]).first.id)

        paginate_tag_page(params[:page])

        render "admin/blog/tags/destroy", layout: false 
      }
    end
  end

  def update
    respond_to do |format|
      format.html
      format.js {
        @tag = Tag.find(params[:id])
        @tag.update_attributes(params[:tag])

        paginate_tag_page(params[:page])
        render "admin/blog/tags/update", layout: false
      }
    end   
  end

  private
    def paginate_tag_page(page)
      paginate_me :tags, base_url: admin_blog_tags_url, page: page, order: 'tag'
    end
end
