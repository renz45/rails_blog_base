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
#  comments_count   :integer         default(0)
#  tags_count       :integer         default(0)
#  categories_count :integer         default(0)
#  status_id        :integer
#

