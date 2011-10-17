class AddCommentsCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer
    add_column :posts, :tags_count, :integer
    add_column :posts, :categories_count, :integer
  end
end
