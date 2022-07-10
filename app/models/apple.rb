# == Schema Information
#
# Table name: apples
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Apple < ApplicationRecord
  def post_api
    # 外部APIを呼んでいるとする
    puts "[instance] (#{name}) #{Time.zone.now} start ============>"
    puts "[instance] (#{name}) #{Time.zone.now} end   <============"
  end
end
