require 'rails_helper'

RSpec.describe 'HeavyQueueJob', type: :job do
  describe '#perform_later' do
    context 'RSpecの have_enqueued_job マッチャを使う' do
      # have_enqueued_job マッチャを使う場合、
      # ActiveJob::Base.queue_adapter = :test の設定をしていないとエラーになる
      # => StandardError: To use ActiveJob matchers set `ActiveJob::Base.queue_adapter = :test`
      before do
        ActiveJob::Base.queue_adapter = :test
      end

      after do
        ActiveJob::Base.queue_adapter = :delayed_job
      end

      it '名前付きキューに1回入ること' do
        expect {
          HeavyQueueJob.perform_later
        }.to have_enqueued_job(HeavyQueueJob).exactly(:once).on_queue(:heavy)
      end
    end

    context '自分でテーブルを調べる' do
      it 'job specの場合は、ジョブがキューに入ること' do
        # こちらはデフォルトの ActiveJob::Base.queue_adapter = :delayed_job になっていないとエラーになる
        expect {
          HeavyQueueJob.perform_later
        }.to change(Delayed::Job, :count).from(0).to(1)
      end

      it '優先度も設定されていること' do
        HeavyQueueJob.perform_later

        actual = Delayed::Job.first
        expect(actual).to have_attributes(priority: 10)
      end
    end
  end
end