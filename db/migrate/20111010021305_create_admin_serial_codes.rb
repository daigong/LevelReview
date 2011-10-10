class CreateAdminSerialCodes < ActiveRecord::Migration
  def change
    create_table :admin_serial_codes do |t|
      t.string :code
      t.references :person
      t.datetime :used_time
      t.references :batch

      t.timestamps
    end
    add_index :admin_serial_codes, :person_id
    add_index :admin_serial_codes, :batch_id
  end
end
