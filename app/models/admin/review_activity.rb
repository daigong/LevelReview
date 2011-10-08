class Admin::ReviewActivity < ActiveRecord::Base
  belongs_to :review_project
end
