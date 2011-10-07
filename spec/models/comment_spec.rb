require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
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

