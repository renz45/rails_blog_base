class Admin::Blog::CategoriesController < Admin::Blog::BaseController

  def create
    Category.find_or_create_by_category(params[:category]) #Category.create!(params[:category])
    @categories = Category.order(:category)
    @post = Post.where(id: params[:post]).first
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
