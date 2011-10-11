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
  has_many :category_to_posts
  has_many :posts, :through => :category_to_posts

  validates :category, :presence => true

  before_save :add_slug

  def add_slug
    self.slug = Category.clean_url(self.category) unless self.category.nil?
  end

  def self.clean_url(url)
    clean = url.gsub(" ", "-")
    clean = clean.gsub(/[?\\\.\,\<\>\!\@\#\$\%\^\&\*\(\)]/, "")
    clean
  end
end


