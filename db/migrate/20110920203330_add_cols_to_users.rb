class AddColsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :permission_id, :integer
  end
end
