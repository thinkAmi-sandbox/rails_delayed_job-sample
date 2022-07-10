class CustomQueueJob < ApplicationJob
  queue_as :custom

  def perform(apple_name)
    puts "[custom queue job] (#{apple_name}) #{Time.zone.now} start ============>"
    sleep 10
    puts "[custom queue job] (#{apple_name}) #{Time.zone.now} end   <============"
  end
end
