class Permission < ActiveRecord::Base
  has_many :user 
  has_many :comment
end
