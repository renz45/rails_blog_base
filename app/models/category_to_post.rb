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

class CategoryToPost < ActiveRecord::Base
  belongs_to :post , counter_cache: :categories_count
  belongs_to :category, counter_cache: :posts_count
end


