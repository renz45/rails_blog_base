class CreateTagToPosts < ActiveRecord::Migration
  def change
    create_table :tag_to_posts do |t|
      t.integer :tag_id
      t.integer :post_id

      t.timestamps
    end

    add_index :tag_to_posts, :tag_id
    add_index :tag_to_posts, :post_id
  end
end
