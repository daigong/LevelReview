class CreateInfoRegisterBaseInfos < ActiveRecord::Migration
  def change
    create_table :info_register_base_infos do |t|
      t.string :nation
      t.string :sex
      t.string :birthday
      t.string :last_review_time
      t.string :invite_time
      t.string :degree
      t.string :edu_background
      t.string :current_level
      t.string :advance_level
      t.string :review_type
      t.string :computer_exam
      t.string :computer_exam_file_name
      t.string :foreign_exam
      t.string :foreign_exam_file_name
      t.references :owner
      t.timestamps
    end
  end
end
