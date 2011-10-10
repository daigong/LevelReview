class CreateAdminSerialCodeBatches < ActiveRecord::Migration
  def change
    create_table :admin_serial_code_batches do |t|
      t.string :name
      t.datetime :end_time
      t.datetime :build_time
      t.text :remark
      t.references :activity

      t.timestamps
    end
    add_index :admin_serial_code_batches, :activity_id
  end
end
