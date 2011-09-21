class CreateCommentStatuses < ActiveRecord::Migration
  def change
    create_table :comment_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
