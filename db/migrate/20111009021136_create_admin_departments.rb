class CreateAdminDepartments < ActiveRecord::Migration
  def change
    create_table :admin_departments do |t|
      t.string :name
      t.text :remark
      t.references :subject

      t.timestamps
    end
    add_index :admin_departments, :subject_id
  end
end
