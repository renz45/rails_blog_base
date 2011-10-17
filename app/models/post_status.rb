class PostStatus < ActiveRecord::Base
  has_many :posts, foreign_key: :status_id

  validates :status, presence: true
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

