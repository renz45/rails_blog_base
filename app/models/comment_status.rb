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

  validates :status, :presence => true
end


