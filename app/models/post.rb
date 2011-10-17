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

  before_save :update_slug

  belongs_to :user

  has_many :category_posts
  has_many :categories, through: :category_posts

  has_many :post_tags
  has_many :tags, through: :post_tags

  has_many :comments, dependent: :destroy

  belongs_to :post_status, foreign_key: :status_id, counter_cache: :posts_count

  # setup validations
  validates :title, presence: true
  validates :user_id, presence: true

  def update_slug
    self.slug ||= Post.clean_url(self.title) unless self.title.nil?
    binding.pry

    # update count caches
    self.categories.each do |c|
      c.posts_count = c.posts.count
    end

    self.tags.each do |t|
      t.posts_count = t.posts.count
    end
  end

  def self.clean_url(url)
    clean = url.gsub(" ", "-")
    clean.gsub(/[?\\\.\,\<\>\!\@\#\$\%\^\&\*\(\)]/, "")
  end

end


