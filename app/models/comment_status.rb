# == Schema Information
#
# Table name: comment_statuses
#
#  id         :integer         not null, primary key
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CommentStatus < ActiveRecord::Base
  has_many :comments
  validates :status, presence: true

  scope :trash, where(status: "trash")
  scope :approved, where(status: "approved")
  scope :spam, where(status: "spam")
  scope :unapproved, where(status: "unapproved")
end


