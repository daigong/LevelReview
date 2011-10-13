class InfoRegister::ArticleActivityRelation < ActiveRecord::Base
  belongs_to :article, :class_name => 'InfoRegister::Article'
  belongs_to :activity, :class_name => 'Admin::ReviewActivity'
  belongs_to :reviewer, :class_name => 'Admin::Person'
end
