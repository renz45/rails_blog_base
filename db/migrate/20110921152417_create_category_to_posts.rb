class CreateCategoryToPosts < ActiveRecord::Migration
  def change
    create_table :category_to_posts do |t|
      t.integer :category_id
      t.integer :post_id

      t.timestamps
    end

    add_index :category_to_posts, :category_id
    add_index :category_to_posts, :post_id
  end
end
