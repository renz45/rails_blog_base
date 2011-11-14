# == Schema Information
#
# Table name: tags
#
#  id          :integer         not null, primary key
#  tag         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  posts_count :integer
#

class Tag < ActiveRecord::Base
  before_save :add_slug
  #after_initialize :add_slug

  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :tag, presence: true

  def add_slug
    self.slug = Tag.clean_url(self.tag) unless self.tag.nil?
  end

  def self.clean_url(url)
    clean = url.gsub(" ", "-")
    clean = clean.gsub(/[?\\\.\,\<\>\!\@\#\$\%\^\&\*\(\)]/, "")
    clean
  end
end


