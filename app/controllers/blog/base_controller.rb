class Blog::BaseController < ApplicationController
  layout "blog/layouts/application"
  before_filter :load_cats_tags

  def load_cats_tags
    @categories = Category.all
    @tags = Tag.all
  end

end
