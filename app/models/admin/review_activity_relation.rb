class Admin::ReviewActivityRelation < ActiveRecord::Base
  belongs_to :pre_activity, :class_name => 'Admin::ReviewActivity'
  belongs_to :activity, :class_name => 'Admin::ReviewActivity'
end
