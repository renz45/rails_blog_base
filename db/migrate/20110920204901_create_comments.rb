class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author
      t.string :email
      t.string :website
      t.string :content
      t.integer :permission_id
      t.integer :status_id
      t.integer :reply_id
      t.integer :post_id

      t.timestamps
    end
  end
end
