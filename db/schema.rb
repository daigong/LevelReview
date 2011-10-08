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

ActiveRecord::Schema.define(:version => 20111007054759) do

  create_table "admin_people", :force => true do |t|
    t.string   "user_name"
    t.string   "password"
    t.string   "person_name"
    t.datetime "created_at"
    t.datetime "updated_at"
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

end
