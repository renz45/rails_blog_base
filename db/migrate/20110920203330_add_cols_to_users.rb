class AddColsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :user_name, :string
    add_column :users, :bio, :text
    add_column :users, :website_url, :string
    add_column :users, :permission_id, :integer, default: 1

    add_index :users, :user_name, unique: true
  end

end
