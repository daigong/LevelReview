class Admin::PersonActivityRelation < ActiveRecord::Base
  belongs_to :person, :class_name => 'Admin::Person'
  belongs_to :activity, :class_name => 'Admin::ReviewActivity'
  belongs_to :reviewer, :class_name => 'Admin::Person'
  belongs_to :confirmor, :class_name => 'Admin::Person'
end
