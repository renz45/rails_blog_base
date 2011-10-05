class PostStatus < ActiveRecord::Base
  belongs_to :posts

  validates :status, :presence => true
end
