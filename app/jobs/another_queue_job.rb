class AnotherQueueJob < ApplicationJob
  queue_as :another

  def perform(apple_name)
    puts "[another queue job] (#{apple_name}) #{Time.zone.now} start ============>"
    puts "[another queue job] (#{apple_name}) #{Time.zone.now} end   <============"
  end
end
