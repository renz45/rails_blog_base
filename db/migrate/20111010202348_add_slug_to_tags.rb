class AddSlugToTags < ActiveRecord::Migration
  def change
    add_column :tags, :slug, :string
    add_column :categories, :slug, :string
  end
end
