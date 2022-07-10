class DefaultQueueJob < ApplicationJob
  queue_as :default

  def perform(apple_name)
    puts "[default queue job] (#{apple_name}) #{Time.zone.now} start ============>"
    sleep 1
    puts "[default queue job] (#{apple_name}) #{Time.zone.now} end   <============"
  end
end
