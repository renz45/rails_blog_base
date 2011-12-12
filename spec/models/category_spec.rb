require 'spec_helper'
# == Schema Information
#
# Table name: categories
#
#  id          :integer         not null, primary key
#  category    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  posts_count :integer         default(0)
#  slug        :string(255)
#
describe Category do
  before { @category = Factory.build(:category) }

  subject {@category}

  it {should respond_to :id}
  it {should respond_to :category}
  it {should respond_to :created_at}
  it {should respond_to :updated_at}
  it {should respond_to :posts_count}
  it {should respond_to :slug}

  context 'when category is empty' do
    before {@category.category = ''}
    it {should_not be_valid}
    specify {@category.save.should == false}
  end

  context 'when category is not empty' do
    before {@category.category = "category1"}
    it {should be_valid}
    specify {@category.save.should == true}
  end

  context 'when posts_count is not set' do
    subject {@category.posts_count}
    it {should equal 0}
    specify {@category.posts_count.should == 0}
  end

  context 'when category is unique' do
    before {@category = Factory(:category)}
    it {should be_valid}
    specify {@category.save.should == true}
  end

  context 'when category is not unique' do
    before { 
      @category.save
      @category_copy = Factory.build(:category, category: @category.category) 
    }
    subject {@category_copy}

    it {should_not be_valid}
    specify {@category_copy.save.should == false}
  end

end