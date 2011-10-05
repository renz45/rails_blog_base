class AddStatusIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :status_id, :integer
  end
end
