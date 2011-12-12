require 'spec_helper'
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

describe Comment do
  before { @comment = Comment.new }

  subject {@comment}

  it {should respond_to :id}
  it {should respond_to :author}
  it {should respond_to :email}
  it {should respond_to :website}
  it {should respond_to :content}
  it {should respond_to :permission_id}
  it {should respond_to :status_id}
  it {should respond_to :reply_id}
  it {should respond_to :post_id}
  it {should respond_to :ip_address}
  it {should respond_to :created_at}
  it {should respond_to :updated_at}

  context 'when email is empty' do
    before { @comment = Factory.build(:comment, email: '') }
    it {should_not be_valid}
    specify { @comment.save.should == false }
  end

  context 'when email is not empty' do
    before { @comment = Factory(:comment, email: 'email@email.com') }
    it {should be_valid}
    specify { @comment.save.should == true }
  end

  context 'when email does not look like an email' do
    before { @comment = Factory.build(:comment, email: 'emailATgmailDOTcom') }
    it {should_not be_valid}
    specify { @comment.save.should == false }

    before { @comment.email = 'email@email' }
    it {should_not be_valid}
    specify { @comment.save.should == false }

    before { @comment.email = 'email.email.com' }
    it {should_not be_valid}
    specify { @comment.save.should == false }
  end

  context 'when email looks like an email' do 
    before { @comment = Factory.build(:comment, email: 'email@email.com') }
    it {should be_valid}
    specify { @comment.save.should == true }
  end

  context 'when content is empty' do
    before { @comment = Factory.build(:comment, content: '') }
    it {should_not be_valid}
    specify { @comment.save.should == false }
  end

  context 'when content is not empty' do
    before { @comment = Factory(:comment, content: 'Hey lookie, some content') }
    it {should be_valid}
    specify { @comment.save.should == true }
  end

  context 'when post_id is empty' do
    before { @comment = Factory.build(:comment, post_id: '') }
    it {should_not be_valid}
    specify { @comment.save.should == false }
  end

  context 'when post_id is not empty' do
    before { @comment = Factory(:comment, post_id: Factory(:post).id) }
    it {should be_valid}
    specify { @comment.save.should == true }
  end

end
