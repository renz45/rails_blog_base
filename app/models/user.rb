# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  user_name              :string(255)
#  bio                    :text
#  website_url            :string(255)
#  permission_id          :integer
#

class User < ActiveRecord::Base
  belongs_to :permission
  # going to assume for now that posts will be reasigned if a user is deleted
  # instead of making it dependent on destroy
  has_many :posts 

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :name, :user_name, :website_url

  # setup validations
  validates :user_name, 
              presence: true,
              length: {:maximum => 30}

  def can_access_admin?

    permission = self.permission.permission

    case permission
      when "admin"
        true
      when "editor"
        true
      when "author"
        true
      else 
        false
    end
  end

  def admin?
    self.permission.permission == "admin"
  end

  def editor?
    self.permission.permission == "editor"
  end

  def author?
    self.permission.permission == "author"
  end

  def user?
    self.permission.permission == "user"
  end

  def anon?
    self.permission.permission == "anon"
  end
                        
end
