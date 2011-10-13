# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111013032415) do

  create_table "admin_departments", :force => true do |t|
    t.string   "name"
    t.text     "remark"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_departments", ["subject_id"], :name => "index_admin_departments_on_subject_id"

  create_table "admin_people", :force => true do |t|
    t.string   "user_name"
    t.string   "password"
    t.string   "person_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.string   "telephone"
    t.string   "email"
  end

  create_table "admin_person_activity_relations", :force => true do |t|
    t.integer  "person_id"
    t.integer  "activity_id"
    t.string   "review_result"
    t.datetime "review_time"
    t.integer  "reviewer_id"
    t.string   "confirm_result"
    t.datetime "confirm_time"
    t.integer  "confirmor_id"
    t.string   "activity_result"
    t.datetime "login_begin_time"
    t.datetime "login_end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_leader",        :default => false
  end

  add_index "admin_person_activity_relations", ["activity_id"], :name => "index_admin_person_activity_relations_on_activity_id"
  add_index "admin_person_activity_relations", ["confirmor_id"], :name => "index_admin_person_activity_relations_on_confirmor_id"
  add_index "admin_person_activity_relations", ["person_id"], :name => "index_admin_person_activity_relations_on_person_id"
  add_index "admin_person_activity_relations", ["reviewer_id"], :name => "index_admin_person_activity_relations_on_reviewer_id"

  create_table "admin_review_activities", :force => true do |t|
    t.string   "name"
    t.string   "activity_type"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.integer  "review_project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_review_activities", ["review_project_id"], :name => "index_admin_review_activities_on_review_project_id"

  create_table "admin_review_activity_relations", :force => true do |t|
    t.integer  "pre_activity_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_review_activity_relations", ["activity_id"], :name => "index_admin_review_activity_relations_on_activity_id"
  add_index "admin_review_activity_relations", ["pre_activity_id"], :name => "index_admin_review_activity_relations_on_pre_activity_id"

  create_table "admin_review_projects", :force => true do |t|
    t.string   "name"
    t.string   "state"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_serial_code_batches", :force => true do |t|
    t.string   "name"
    t.datetime "end_time"
    t.datetime "build_time"
    t.text     "remark"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_serial_code_batches", ["activity_id"], :name => "index_admin_serial_code_batches_on_activity_id"

  create_table "admin_serial_codes", :force => true do |t|
    t.string   "code"
    t.integer  "person_id"
    t.datetime "used_time"
    t.integer  "batch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_serial_codes", ["batch_id"], :name => "index_admin_serial_codes_on_batch_id"
  add_index "admin_serial_codes", ["person_id"], :name => "index_admin_serial_codes_on_person_id"

  create_table "admin_subjects", :force => true do |t|
    t.string   "name"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "info_register_article_activity_relations", :force => true do |t|
    t.integer  "article_id"
    t.integer  "activity_id"
    t.string   "result"
    t.integer  "reviewer_id"
    t.text     "remark"
    t.datetime "review_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "info_register_article_activity_relations", ["activity_id"], :name => "index_info_register_article_activity_relations_on_activity_id"
  add_index "info_register_article_activity_relations", ["article_id"], :name => "index_info_register_article_activity_relations_on_article_id"
  add_index "info_register_article_activity_relations", ["reviewer_id"], :name => "index_info_register_article_activity_relations_on_reviewer_id"

  create_table "info_register_articles", :force => true do |t|
    t.integer  "owner_id"
    t.string   "title"
    t.string   "publication_name"
    t.string   "publish_date"
    t.string   "person_rank"
    t.string   "publication_type"
    t.string   "upload_time"
    t.string   "name"
    t.string   "file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "info_register_articles", ["owner_id"], :name => "index_info_register_articles_on_owner_id"

  create_table "info_register_base_infos", :force => true do |t|
    t.string   "nation"
    t.string   "sex"
    t.string   "birthday"
    t.string   "last_review_time"
    t.string   "invite_time"
    t.string   "degree"
    t.string   "edu_background"
    t.string   "current_level"
    t.string   "advance_level"
    t.string   "review_type"
    t.string   "computer_exam"
    t.string   "computer_exam_file_name"
    t.string   "foreign_exam"
    t.string   "foreign_exam_file_name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
