class Category < ActiveRecord::Base
  has_many :category_to_posts
  has_many :posts, :through => :category_to_posts

end
