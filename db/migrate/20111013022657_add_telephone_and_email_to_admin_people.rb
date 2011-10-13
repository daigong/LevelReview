class AddTelephoneAndEmailToAdminPeople < ActiveRecord::Migration
  def change
    add_column :admin_people, :telephone, :string
    add_column :admin_people, :email, :string
  end
end
