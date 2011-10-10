class Admin::SerialCodeBatch < ActiveRecord::Base
  belongs_to :activity, :class_name => 'Admin::ReviewActivity'
end
