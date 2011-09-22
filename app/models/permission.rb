# == Schema Information
#
# Table name: permissions
#
#  id         :integer         not null, primary key
#  permission :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Permission < ActiveRecord::Base
  has_many :user 
  has_many :comment

  validates :permission, :presence => true
end


