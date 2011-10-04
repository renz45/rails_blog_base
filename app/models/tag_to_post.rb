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

class TagToPost < ActiveRecord::Base
  belongs_to :post, :counter_cache => :tags_count
  belongs_to :tag, :counter_cache => :posts_count
end


