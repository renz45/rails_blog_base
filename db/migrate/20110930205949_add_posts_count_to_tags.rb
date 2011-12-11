class AddPostsCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :posts_count, :integer, default: 0

    add_column :categories, :posts_count, :integer, default: 0
  end
end
