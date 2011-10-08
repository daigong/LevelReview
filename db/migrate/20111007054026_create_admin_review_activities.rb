class CreateAdminReviewActivities < ActiveRecord::Migration
  def change
    create_table :admin_review_activities do |t|
      t.string :name
      t.string :activity_type
      t.datetime :begin_time
      t.datetime :end_time
      t.references :review_project

      t.timestamps
    end
    add_index :admin_review_activities, :review_project_id
  end
end
