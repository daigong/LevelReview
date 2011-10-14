class AddRoleTypeToAdminPersonActivityRelation < ActiveRecord::Migration
  def change
    add_column :admin_person_activity_relations, :role_type, :string
  end
end
