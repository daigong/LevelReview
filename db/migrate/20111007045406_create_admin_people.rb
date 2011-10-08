class CreateAdminPeople < ActiveRecord::Migration
  def change
    create_table :admin_people do |t|
      t.string :user_name
      t.string :password
      t.string :person_name

      t.timestamps
    end
  end
end
