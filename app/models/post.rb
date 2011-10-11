# == Schema Information
#
# Table name: posts
#
#  id               :integer         not null, primary key
#  title            :string(255)
#  content          :text
#  user_id          :integer
#  slug             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  categories_count :integer
#  tags_count       :integer
#  comments_count   :integer
#  status_id        :integer
#

class Post < ActiveRecord::Base
  belongs_to :user

  has_many :category_to_posts
  has_many :categories, through: :category_to_posts

  has_many :tag_to_posts
  has_many :tags, through: :tag_to_posts

  has_many :comments, dependent: :destroy

  has_one :post_status

  # setup validations
  validates :title, presence: true
  validates :user_id, presence: true

  before_save :add_slug

  def add_slug
    self.slug ||= Post.clean_url(self.title) unless self.title.nil?
  end
  

  def self.clean_url(url)
    clean = url.gsub(" ", "-")
    clean = clean.gsub(/[?\\\.\,\<\>\!\@\#\$\%\^\&\*\(\)]/, "")
    clean
  end

end


