class Admin::Blog::CategoriesController < Admin::Blog::BaseController
  before_filter :set_active
  def index
    @sidebar_active << :categories
    @title = 'Categories'

    @category = Category.new

    paginate_category_page(params[:page])
  end

  def create
    @category = Category.find_or_create_by_category(params[:category][:category])

    paginate_category_page(params[:page])
  
    respond_to do |format|
      format.html
      format.js { render "admin/blog/categories/create", layout: false }
    end
  end

  def destroy
    Category.delete(params[:id])

    paginate_category_page(params[:page])

    respond_to do |format|
      format.html
      format.js { render "admin/blog/categories/update", layout: false }
    end
  end

  def update
    respond_to do |format|
      format.html 
      format.js { 
        @category = Category.find(params[:id])
        @category.update_attributes(params[:category])

        paginate_category_page(params[:page])

        render "admin/blog/categories/update", layout: false
      }
    end
  end

  def paginate_category_page(page)
    paginate_me :categories, base_url: admin_blog_categories_url, page: page, order: 'category'
  end

  private
    def set_active
      @sidebar_active = [:posts]
    end
end
