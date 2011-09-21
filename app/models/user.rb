class User < ActiveRecord::Base
  belongs_to :permission
  # going to assume for now that posts will be reasigned if a user is deleted
  # instead of making it dependent on destroy
  has_many :posts 

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
