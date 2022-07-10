class AppleInstanceJob < ApplicationJob
  queue_as :default

  def perform(apple)
    puts "[instance job] (#{apple.name}) #{Time.zone.now} start ============>"
    puts "[instance job] (#{apple.name}) #{Time.zone.now} end   <============"
  end
end
