class Admin::SerialCode < ActiveRecord::Base
  belongs_to :person, :class_name => 'Admin::Person'
  belongs_to :batch, :class_name => 'Admin::SerialCodeBatch'

  #序列号的生成规则
  #batch 批次 Admin::SerialCodeBath
  #在批次中的顺序
  def self.create_code_by_rule batch, index
    #TODO完成序列号生成规则
    return "S#{batch.name}#{index}";
  end
end
