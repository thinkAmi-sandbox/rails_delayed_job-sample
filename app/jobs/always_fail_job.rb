class AlwaysFailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "[fail job] #{Time.zone.now} start ============>"

    # 常にエラー
    raise StandardError

    puts "[fail job] #{Time.zone.now} end   <============"
  end
end
