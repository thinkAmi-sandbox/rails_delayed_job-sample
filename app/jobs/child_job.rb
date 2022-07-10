class ChildJob < ApplicationJob
  queue_as :default

  def perform(prefix)
    puts "[child job] (#{prefix}デリシャス) #{Time.zone.now} start ============>"
    puts "[child job] (#{prefix}デリシャス) #{Time.zone.now} end   <============"
  end
end
