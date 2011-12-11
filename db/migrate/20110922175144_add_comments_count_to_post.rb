class AddCommentsCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, default: 0
    add_column :posts, :tags_count, :integer, default: 0
    add_column :posts, :categories_count, :integer, default: 0
  end
end
