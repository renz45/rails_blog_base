class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :permission

      t.timestamps
    end

    add_index :permissions, :permission, :unique => true

    Permission.create(:permission => "admin")
    Permission.create(:permission => "editor")
    Permission.create(:permission => "author")
    Permission.create(:permission => "subscriber")
    Permission.create(:permission => "anon")
  end
end
