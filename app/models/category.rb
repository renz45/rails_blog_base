# == Schema Information
#
# Table name: categories
#
#  id          :integer         not null, primary key
#  category    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  posts_count :integer
#

class Category < ActiveRecord::Base
  before_save :add_slug
  after_initialize :add_slug
  
  has_many :category_posts
  has_many :posts, through: :category_posts

  validates :category, presence: true, uniqueness: true

  def add_slug
    self.slug = Category.clean_url(self.category) unless self.category.nil?
  end

  def self.clean_url(url)
    clean = url.gsub(" ", "-")
    clean = clean.gsub(/[?\\\.\,\<\>\!\@\#\$\%\^\&\*\(\)]/, "")
    clean
  end
end


