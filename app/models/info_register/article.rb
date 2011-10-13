class InfoRegister::Article < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Admin::Person'
  has_many :review_results, :class_name => 'InfoRegister::ArticleActivityRelation', :foreign_key => :article_id, :dependent => :delete_all
end
