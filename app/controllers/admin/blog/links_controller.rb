class Admin::Blog::LinksController < Admin::Blog::BaseController
  before_filter :set_active
  def index
    @link = Link.new
    set_page_params()
  end

  def update
    Link.find(params[:link][:id]).update_attributes(params[:link])

    set_page_params()

    respond_to do |format|
      format.html
      format.js {render 'update.js', layout: false}
    end
  end

  def destroy
    Link.delete(params[:id])

    respond_to do |format|
      format.html
      format.js { render nothing: true }
    end
  end

  def create
    Link.create!(params[:link])

    set_page_params()

    respond_to do |format|
      format.html
      format.js {render 'create.js', layout: false}
    end
  end

  private
    def set_active
      @sidebar_active = [:links]
    end

    def set_page_params
      paginate_me :links, 
                  base_url: admin_blog_links_page_url,
                  order: "lower(links.name) ASC"
    end
end
