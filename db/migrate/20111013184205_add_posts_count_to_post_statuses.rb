class AddPostsCountToPostStatuses < ActiveRecord::Migration
  def change
    add_column :post_statuses, :posts_count, :integer
  end
end
