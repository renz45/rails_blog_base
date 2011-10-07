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
  has_many :posts, :through => :tag_to_posts

  validates :tag, :presence => true
end


