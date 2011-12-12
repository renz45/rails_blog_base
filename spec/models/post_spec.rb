require 'spec_helper'
# == Schema Information
#
# Table name: posts
#
#  id               :integer         not null, primary key
#  title            :string(255)
#  content          :text
#  user_id          :integer
#  slug             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  comments_count   :integer         default(0)
#  tags_count       :integer         default(0)
#  categories_count :integer         default(0)
#  status_id        :integer
#

describe Post do
  before {@post = Factory.build(:post)}

  subject {@post}

  it {should respond_to :id}
  it {should respond_to :title}
  it {should respond_to :content}
  it {should respond_to :user_id}
  it {should respond_to :slug}
  it {should respond_to :created_at}
  it {should respond_to :updated_at}
  it {should respond_to :comments_count}
  it {should respond_to :tags_count}
  it {should respond_to :categories_count}
  it {should respond_to :status_id}


  context 'when title is empty' do
    before {@post.title = ''}
    it {should_not be_valid}
    specify {@post.save.should == false}
  end

  context 'when title is not empty' do
    before {@post.title = "sample title"}
    it {should be_valid}
    specify {@post.save.should == true}
  end

  context 'when user_id is empty' do
    before {@post.user_id = ''}
    it {should_not be_valid}
    specify {@post.save.should == false}
  end

  context 'when title is not empty' do
    before {@post.user_id = Factory(:user).id}
    it {should be_valid}
    specify {@post.save.should == true}
  end

  context 'when created, categories_count defaults to 0' do
    before {@post.save}
    subject {@post.categories_count}
    it {should equal 0}
    specify {@post.categories_count.should == 0}
  end

  context 'when created, tags_count defaults to 0' do
    before {@post.save}
    subject {@post.tags_count}
    it {should equal 0}
    specify {@post.tags_count.should == 0}
  end

  context 'when created, comments_count defaults to 0' do
    before {@post.save}
    subject {@post.comments_count}
    it {should equal 0}
    specify {@post.comments_count.should == 0}
  end

end