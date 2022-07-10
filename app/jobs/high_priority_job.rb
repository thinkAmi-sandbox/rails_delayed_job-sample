class HighPriorityJob < ApplicationJob
  queue_as :default
  queue_with_priority 10

  def perform(*args)
    puts "[high priority job] #{Time.zone.now} start ============>"
    puts "[high priority job] #{Time.zone.now} end   <============"
  end
end
