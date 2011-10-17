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
  has_many :posts, foreign_key: :status_id

  validates :status, presence: true

  def self.trashed 
    self.where(status: "trashed").first()
  end

  def self.published
    self.where(status: "published").first()
  end

  def self.draft
    self.where(status: "draft").first()
  end

  def self.unpublished
    self.where(status: "unpublished").first()
  end
end