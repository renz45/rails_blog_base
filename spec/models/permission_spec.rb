require 'spec_helper'
# == Schema Information
#
# Table name: permissions
#
#  id         :integer         not null, primary key
#  permission :string(255)
#  created_at :datetime
#  updated_at :datetime
#  level      :integer
#

describe Permission do 
  before {@permission = Factory.build(:permission)}

  subject {@permission}

  it {should respond_to :id}
  it {should respond_to :permission}
  it {should respond_to :created_at}
  it {should respond_to :updated_at}
  it {should respond_to :level}

  context 'when permission is empty' do
    before {@permission.permission = ''}
    it {should_not be_valid}
    specify {@permission.save.should ==false}
  end

  context 'when permission exists' do
    before {@permission.permission = 'admin'}
    it {should be_valid}
    specify {@permission.save.should == true}
  end
end