class AsyncBackendJob < ApplicationJob
  # キュー名は、Delayed::Job と同じ
  queue_as :default

  # バックエンドだけ async
  self.queue_adapter = :async

  def perform(*args)
    puts "[async job] #{Time.zone.now} start ============>"
    puts "[async job] #{Time.zone.now} end   <============"
  end
end
