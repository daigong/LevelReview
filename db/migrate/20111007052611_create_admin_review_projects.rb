class CreateAdminReviewProjects < ActiveRecord::Migration
  def change
    create_table :admin_review_projects do |t|
      t.string :name
      t.string :state
      t.text :remark

      t.timestamps
    end
  end
end
