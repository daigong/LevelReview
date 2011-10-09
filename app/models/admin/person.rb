class Admin::Person < ActiveRecord::Base
  belongs_to :department, :class_name => 'Admin::Department'
end
