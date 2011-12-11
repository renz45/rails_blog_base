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
  before { @category = Category.new }

  subject {@category}

  it {should respond_to :id}
  it {should respond_to :category}
  it {should respond_to :created_at}
  it {should respond_to :updated_at}
  it {should respond_to :posts_count}
  it {should respond_to :slug}

  context 'when category is empty' do
    it {should_not be_valid}
    specify {@category.save.should == false}
  end

  context 'when category is not empty' do
    before {@category.category = "category1"}
    it {should be_valid}
    specify {@category.save.should == true}
  end

end