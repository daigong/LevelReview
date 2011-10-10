class Admin::SerialCode < ActiveRecord::Base
  belongs_to :person, :class_name => 'Admin::Person'
  belongs_to :batch, :class_name => 'Admin::SerialCodeBatch'
end
