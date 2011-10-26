class Admin::Blog::CategoriesController < Admin::Blog::BaseController

  def create
    @category = Category.new(category: params[:category])
    
    respond_to do |format|
      format.html
      format.js { render "admin/blog/categories/create", layout: false }
    end
  end

  def destroy
    redirect_to :back
  end

  def update
    redirect_to :back
  end

  def new
    binding.pry
  end

end
