class CreatePostStatuses < ActiveRecord::Migration
  def change
    create_table :post_statuses do |t|
      t.string :status
      t.timestamps
    end

    add_index :post_statuses, :status, unique: true

    PostStatus.create!(status: "published")
    PostStatus.create!(status: "unpublished")
    PostStatus.create!(status: "draft")
    PostStatus.create!(status: "trashed")
  end
end
