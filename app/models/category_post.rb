# == Schema Information
#
# Table name: category_to_posts
#
#  id          :integer         not null, primary key
#  category_id :integer
#  post_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class CategoryPost < ActiveRecord::Base
  belongs_to :category
  belongs_to :post
end


