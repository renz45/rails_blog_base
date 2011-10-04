class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :permission

      t.timestamps
    end

    add_index :permissions, :permission, :unique => true

    Permission.create(:permission => "anon")
    Permission.create(:permission => "subscriber")
    Permission.create(:permission => "author")
    Permission.create(:permission => "editor")
    Permission.create(:permission => "admin")
    
  end
end
