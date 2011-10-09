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
#  ip_address    :string(255)
#

class Comment < ActiveRecord::Base
  belongs_to :post, counter_cache: true

  belongs_to :permission
  has_one :comment_status

  # Setup Validations
  validates :author, presence: true

  email_regex = /\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/

  validates :email, presence: true, format: { with: email_regex }
  validates :content, presence: true
  validates :post_id, presence: true

  def self.for_post(post_id, per_page = 10, page = 1)
    comments = Comment.where(post_id: post_id, reply_id: nil, status_id: 1)
           .limit(per_page)
           .offset(page)
           .order("created_at DESC")

    self.build_comments(comments)
  end

  # recursive function that builds a comment object
  # NOTE I traded server calls for 2 map functions, this will save a lot of server calls depending on
  #      how many replies there are for each comment, could be slower than just doing the queries, 
  #      I'm not sure yet.
  def self.build_comments(initial_comments)
    comment_list = {}

    # get all replies for the initial_comments
    reply_list = self.where(reply_id: initial_comments.map{|ic| ic.id}, status_id: 1)

    # loop through initial_comments
    initial_comments.each do |c|
      comment_list[c.id] = {}
      comment_list[c.id][:comment] = c
      
      # pull out the individual replies for each comment looped through
      replies = reply_list.map{|r| r if r.reply_id == c.id} 

      # if there were any replies send them back through this function to check if they have comments
      comment_list[c.id][:replies] = (replies == [nil] ? [] : build_comments(replies) )
    end
    comment_list
  end
end

