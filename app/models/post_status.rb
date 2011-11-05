# == Schema Information
#
# Table name: post_statuses
#
#  id         :integer         not null, primary key
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class PostStatus < ActiveRecord::Base
  has_many :posts

  validates :status, presence: true

  scope :trashed, where(status: "trashed")
  scope :published, where(status: "published")
  scope :draft, where(status: "draft")
  scope :unpublished, where(status: "unpublished")

end