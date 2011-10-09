class AddIsLeaderToAdminPersonActivityRelations < ActiveRecord::Migration
  def change
    change_table :admin_person_activity_relations do |t|
      t.boolean :is_leader, :default => false
    end
  end
end
