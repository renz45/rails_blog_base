# == Schema Information
#
# Table name: comments
#
#  id            :integer         not null, primary key
#  author        :string(255)
#  email         :string(255)
#  website       :string(255)
#  content       :text
#  permission_id :integer
#  status_id     :integer
#  reply_id      :integer
#  post_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true

  belongs_to :permission
  has_one :comment_status

  # Setup Validations
  validates :author, :presence => true
  validates :email, :presence => true,
                    :format   => { :with => email_test }
  validates :content, :presence => true
  validates :post_id, :presence => true
end

