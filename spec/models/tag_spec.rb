require 'spec_helper'
# == Schema Information
#
# Table name: tags
#
#  id          :integer         not null, primary key
#  tag         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  posts_count :integer         default(0)
#  slug        :string(255)
#

describe Tag do
  before {@tag = Factory.build(:tag)}

  subject {@tag}

  it {should respond_to :id}
  it {should respond_to :tag}
  it {should respond_to :created_at}
  it {should respond_to :updated_at}
  it {should respond_to :posts_count}
  it {should respond_to :slug}

  context 'when tag is empty' do
    before {@tag.tag = ''}
    it {should_not be_valid}
    specify {@tag.save.should == false}
  end

  context 'when tag exists' do
    before {@tag.tag = 'sample tag'}
    it {should be_valid}
    specify {@tag.save.should == true}
  end

  context 'when created posts_count defaults to 0' do
    before {@tag.save}
    subject {@tag.posts_count}
    it {should equal 0}
    specify {@tag.posts_count.should == 0}
  end
end
