# == Schema Information
#
# Table name: tag_to_posts
#
#  id         :integer         not null, primary key
#  tag_id     :integer
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class PostTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :post
end


