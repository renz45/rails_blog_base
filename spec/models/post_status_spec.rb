require 'spec_helper'
# == Schema Information
#
# Table name: post_statuses
#
#  id          :integer         not null, primary key
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  posts_count :integer         default(0)
#

describe PostStatus do
  before {@post_status = Factory.build(:post_status)}

  subject {@post_status}

  it {should respond_to :id}
  it {should respond_to :status}
  it {should respond_to :created_at}
  it {should respond_to :updated_at}
  it {should respond_to :posts_count}

  context 'when status is empty' do
    before {@post_status.status = ''}
    it {should_not be_valid}
    specify {@post_status.save.should == false}
  end

  context 'when status exists' do
    before {@post_status.status = 'published'}
    it {should be_valid}
    specify {@post_status.save.should == true}
  end

  context 'when created, posts_count defaults to 0' do
    before {@post_status.save}
    subject {@post_status.posts_count}
    it {should equal 0}
    specify {@post_status.posts_count.should == 0}
  end
end