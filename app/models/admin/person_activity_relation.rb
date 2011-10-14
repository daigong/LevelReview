#人员与活动关系实体，人员参与活动会有俩种身份，比如在部门审核中人员可以是信息提供者（参评人，信息需要被审核人审核）或者审核人
#role_type用来区分这个关系，而有很多活动配置&活动筛选中需要考虑人员在活动中充当的位置
#例如：
#1.在活动中维护配置人员，需要差分如果配置的是活动为info_register那么新建的关系role_type应该为info_register
#而其他模块role_type=review
#2.在人员进入user_zone中，可以看到人员能够进入的模块，而这个模块的筛选规则：
#  (1)如果info_register模块，那么关系为role_type=info_register用户就可以看到
#  (2)如果是*review模块，那么关系为role_type=review用户才可以看到
#3.相关判定模块

class Admin::PersonActivityRelation < ActiveRecord::Base
  belongs_to :person, :class_name => 'Admin::Person'
  belongs_to :activity, :class_name => 'Admin::ReviewActivity'
  belongs_to :reviewer, :class_name => 'Admin::Person'
  belongs_to :confirmor, :class_name => 'Admin::Person'
end
