class Admin::SerialCodeBatch < ActiveRecord::Base
  belongs_to :activity, :class_name => 'Admin::ReviewActivity'
  has_many :serial_codes, :class_name => 'Admin::SerialCode', :foreign_key => :batch_id, :dependent => :delete_all
  #生成序列号
  #count 数量
  def build_serial_code count
    1.upto(count.to_i) do |index|
      serial_code = Admin::SerialCode.new
      serial_code.batch=self
      serial_code.code=Admin::SerialCode.create_code_by_rule(self, index)
      serial_code.save
    end
  end
end
