require 'spec_helper'
# == Schema Information
#
# Table name: links
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  target     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#

describe Link do
  before {@link = Factory.build(:link)}

  subject {@link}

  it {should respond_to :id}
  it {should respond_to :url}
  it {should respond_to :target}
  it {should respond_to :created_at}
  it {should respond_to :updated_at}
  it {should respond_to :name}

  context 'when url is empty' do
    before {@link.url = ''}
    it {should_not be_valid}
    specify {@link.save.should == false}
  end

  context 'when url exists' do
    before {@link.url = 'http://www.mylink.com'}
    it {should be_valid}
    specify {@link.save.should == true}
  end
end