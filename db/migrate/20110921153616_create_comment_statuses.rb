class CreateCommentStatuses < ActiveRecord::Migration
  def change
    create_table :comment_statuses do |t|
      t.string :status

      t.timestamps
    end

    add_index :comment_statuses, :status, :unique => true

    CommentStatus.create(:status => "approved")
    CommentStatus.create(:status => "unapproved")
    CommentStatus.create(:status => "trash")
    CommentStatus.create(:status => "spam")
  end
end
