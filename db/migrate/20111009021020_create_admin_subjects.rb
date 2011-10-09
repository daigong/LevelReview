class CreateAdminSubjects < ActiveRecord::Migration
  def change
    create_table :admin_subjects do |t|
      t.string :name
      t.text :remark

      t.timestamps
    end
  end
end
