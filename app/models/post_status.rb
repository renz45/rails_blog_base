class PostStatus < ActiveRecord::Base
  belongs_to :posts

  validates :status, :presence => true
end
# == Schema Information
#
# Table name: post_statuses
#
#  id         :integer         not null, primary key
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

