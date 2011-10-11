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
  has_many :tag_to_posts
  has_many :posts, through: :tag_to_posts

  validates :tag, presence: true

  before_save :add_slug

  def add_slug
    self.slug = Tag.clean_url(self.tag) unless self.tag.nil?
  end

  def self.clean_url(url)
    clean = url.gsub(" ", "-")
    clean = clean.gsub(/[?\\\.\,\<\>\!\@\#\$\%\^\&\*\(\)]/, "")
    clean
  end
end


