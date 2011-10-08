class CreateAdminReviewActivityRelations < ActiveRecord::Migration
  def change
    create_table :admin_review_activity_relations do |t|
      t.references :pre_activity
      t.references :activity

      t.timestamps
    end
    add_index :admin_review_activity_relations, :pre_activity_id
    add_index :admin_review_activity_relations, :activity_id
  end
end
