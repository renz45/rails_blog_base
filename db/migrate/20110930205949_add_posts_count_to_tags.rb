class AddPostsCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :posts_count, :integer

    add_column :categories, :posts_count, :integer
  end
end
