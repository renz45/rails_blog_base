class Post < ActiveRecord::Base
  belongs_to :user, :counter_cache => true

  has_many :category_to_posts
  has_many :categories, :through => :category_to_posts

  has_many :tag_to_posts
  has_many :tags, :through => :tag_to_posts

  has_many :comments, :dependent => :destroy
end
