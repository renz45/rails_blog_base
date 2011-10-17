class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.integer :tag_id
      t.integer :post_id

      t.timestamps
    end

    add_index :post_tags, :tag_id
    add_index :post_tags, :post_id
  end
end
