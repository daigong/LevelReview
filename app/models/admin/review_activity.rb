class Admin::ReviewActivity < ActiveRecord::Base
  belongs_to :review_project
  #参与该活动的所有人员
  def people_in_activity
    Admin::Person.joins(:person_activity_relations).where('admin_person_activity_relations.activity_id=?', self.id);
  end
end
