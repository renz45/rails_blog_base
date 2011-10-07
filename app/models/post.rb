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
  has_many :categories, :through => :category_to_posts

  has_many :tag_to_posts
  has_many :tags, :through => :tag_to_posts

  has_many :comments, :dependent => :destroy

  has_one :post_status

  # setup validations
  validates :title, :presence => true
  validates :user_id, :presence => true

  # gets called after the constructor
  # overriding the constructor wasn't working for some reason.
  def after_initialize
    # if there is a title and the slug doesnt exist, generate a slug from the title
    unless self[:title].nil?
      self[:slug] ||= Post.clean_url(self[:title])
      self.save
    end
  end

  def title
    self[:title]
  end

  def title=(title)
    self[:slug] ||= Post.clean_url(title.to_s)
    self[:title] = title
  end

  def self.create(attributes = nil, options = {}, &block)
    attributes[:slug] ||= Post.clean_url(attributes[:title]) unless attributes[:title].nil?
    super.create(attributes = nil, options = {}, &block)
  end

  def self.create!(attributes = nil, options = {}, &block)
    attributes[:slug] ||= Post.clean_url(attributes[:title]) unless attributes[:title].nil?
    super.create!(attributes = nil, options = {}, &block)
  end

  def self.clean_url(url)
    clean = url.gsub(" ", "-")
    clean = clean.gsub(/[?\\\.\,\<\>\!\@\#\$\%\^\&\*\(\)]/, "")
    clean
  end

end


