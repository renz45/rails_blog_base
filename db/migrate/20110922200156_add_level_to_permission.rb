class AddLevelToPermission < ActiveRecord::Migration
  def change
    add_column :permissions, :level, :int
  end
end
