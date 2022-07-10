class OpenStructJob < ApplicationJob
  queue_as :default

  def perform(apple)
    # OpenStruct向け
    # puts "[open_struct job] (#{apple.name}) #{Time.zone.now} start ============>"
    # puts "[open_struct job] (#{apple.name}) #{Time.zone.now} end   <============"

    # hash向け
    puts "[open_struct job] (#{apple[:name]}) #{Time.zone.now} start ============>"
    puts "[open_struct job] (#{apple[:name]}) #{Time.zone.now} end   <============"
  end
end
