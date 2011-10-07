class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
    add_index :posts, :title, unique: true
    add_index :posts, :slug, unique: true
  end
end
