class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true

  belongs_to :permission
  has_one :comment_status
end
