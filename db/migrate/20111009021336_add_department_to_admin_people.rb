class AddDepartmentToAdminPeople < ActiveRecord::Migration
  def change
    change_table :admin_people do |t|
      t.references :department
    end
  end
end
