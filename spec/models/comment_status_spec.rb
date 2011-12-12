require 'spec_helper'
# == Schema Information
#
# Table name: comment_statuses
#
#  id         :integer         not null, primary key
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

describe CommentStatus do
  before { @comment_status = Factory.build(:comment_status) }

  subject { @comment_status }

  it {should respond_to :id}
  it {should respond_to :status}
  it {should respond_to :created_at}
  it {should respond_to :updated_at}

  context 'when status is empty' do
    before { @comment_status.status = '' }

    it{ should_not be_valid }
    specify { @comment_status.save.should == false }
  end

  context 'when status exists' do
    before { @comment_status.status = 'spam' }

    it{ should be_valid }
    specify { @comment_status.save.should == true }
  end

end
