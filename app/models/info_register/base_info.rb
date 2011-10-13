#encoding=utf-8
class InfoRegister::BaseInfo < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Admin::Person'
  #验证规则
  validates_presence_of :nation, :sex, :birthday, :last_review_time,
                        :invite_time, :degree, :edu_background, :current_level,
                        :advance_level, :review_type
end
