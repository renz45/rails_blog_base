# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# get posts with category_id 9 and tag_id 8
# Post.includes(:category_to_posts, :tag_to_posts).where(category_to_posts: {category_id: 9}, tag_to_posts: {tag_id: 8})

class Post < ActiveRecord::Base
  belongs_to :user

  has_many :category_to_posts
  has_many :categories, :through => :category_to_posts

  has_many :tag_to_posts
  has_many :tags, :through => :tag_to_posts

  has_many :comments, :dependent => :destroy

  has_one :post_status

  # setup validations
  validates :title, :presence => true
  validates :user_id, :presence => true

end


