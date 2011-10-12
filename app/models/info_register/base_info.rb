class InfoRegister::BaseInfo < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Admin::Person'
end
