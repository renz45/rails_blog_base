require 'spec_helper'
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
#  permission_id          :integer         default(1)
#


# devise has it's own tests, so I'm just going to test the parts I added
describe User do
  before {@user = Factory.build(:user)}

  subject {@user}

  it {should respond_to :id}
  it {should respond_to :email}
  it {should respond_to :updated_at}
  it {should respond_to :created_at}
  it {should respond_to :name}
  it {should respond_to :bio}
  it {should respond_to :website_url}
  it {should respond_to :permission_id}

  context 'when validates user_name' do
    context 'when exists' do
      before {@user.user_name = 'sample user'}
      it {should be_valid}
      specify {@user.save.should == true}
    end

    context 'when empty' do
      before {@user.user_name = ''}
      it {should_not be_valid}
      specify {@user.save.should == false}
    end

    context 'when length > 30' do
      before {@user.user_name = 'asdfghjklpoiuytrewqazxcvbnmlkjhgfdsaqwe'}
      it {should_not be_valid}
      specify {@user.save.should == false}
    end
  end
end