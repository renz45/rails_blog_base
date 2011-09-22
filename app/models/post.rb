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

class Post < ActiveRecord::Base
  belongs_to :user, :counter_cache => true

  has_many :category_to_posts
  has_many :categories, :through => :category_to_posts

  has_many :tag_to_posts
  has_many :tags, :through => :tag_to_posts

  has_many :comments, :dependent => :destroy

  # setup validations
  validates :title, :presence => true
  validates :user_id, :presence => true
end


