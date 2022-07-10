class HeavyQueueJob < ApplicationJob
  queue_as :heavy
  queue_with_priority 10

  def perform(apple_name)
    puts "[heavy queue job] (#{apple_name}) #{Time.zone.now} start ============>"
    sleep 10
    puts "[heavy queue job] (#{apple_name}) #{Time.zone.now} end   <============"
  end
end
