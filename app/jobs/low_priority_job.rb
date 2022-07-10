class LowPriorityJob < ApplicationJob
  queue_as :default
  queue_with_priority 30

  def perform(*args)
    puts "[low priority job] #{Time.zone.now} start ============>"
    puts "[low priority job] #{Time.zone.now} end   <============"
  end
end
