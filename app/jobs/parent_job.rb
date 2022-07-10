class ParentJob < ApplicationJob
  queue_as :default

  def perform(prefix)
    puts "[parent job] (#{prefix}) #{Time.zone.now} start ============>"

    # 子のジョブを生成する
    ChildJob.perform_later(prefix)

    puts "[parent job] (#{prefix}) #{Time.zone.now} end   <============"
  end
end
