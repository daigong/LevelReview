class CreateAdminPersonActivityRelations < ActiveRecord::Migration
  def change
    create_table :admin_person_activity_relations do |t|
      t.references :person
      t.references :activity
      t.string :review_result
      t.datetime :review_time
      t.references :reviewer
      t.string :confirm_result
      t.datetime :confirm_time
      t.references :confirmor
      t.string :activity_result
      t.datetime :login_begin_time
      t.datetime :login_end_time

      t.timestamps
    end
    add_index :admin_person_activity_relations, :person_id
    add_index :admin_person_activity_relations, :activity_id
    add_index :admin_person_activity_relations, :reviewer_id
    add_index :admin_person_activity_relations, :confirmor_id
  end
end
