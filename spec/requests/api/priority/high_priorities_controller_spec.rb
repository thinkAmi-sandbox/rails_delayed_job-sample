require 'rails_helper'

RSpec.describe 'Api::Priority::HighPrioritiesController', type: :request do
  describe 'POST /api/priority/high_priorities' do
    context 'RSpecの have_been_enqueued マッチャを使う' do
      it 'POSTすると、キュー default に1回入る' do
        post api_priority_high_priorities_path, params: { name: 'test' }

        expect(HighPriorityJob).to have_been_enqueued.exactly(:once).on_queue(:default)
      end
    end

    context '自分でテーブルを調べる' do
      before do
        # Rails6以降、 request spec では queue_adapter が :test 固定になった
        #
        # しかし、以前のように、以下の設定では queue_adapter の差し替えができない
        # ActiveJob::Base.queue_adapter = :delayed_job
        #
        # その代わり、以下の回避策で、 test adapter への差し替えを防ぐ
        queue_adapter_changed_jobs.each(&:disable_test_adapter)
        # 参考
        # https://github.com/rails/rails/issues/37270#issuecomment-810197288
        # https://qiita.com/teitei_tk/items/7e5248efbf8398687215
        # https://scrapbox.io/tsugitta/Rails_6_%E3%81%A7_Request_Spec_%E3%81%A7%E3%81%AE%E3%81%BF_Delayed::Job_%E3%81%AB_enqueue_%E3%81%95%E3%82%8C%E3%81%AA%E3%81%84

      end

      it 'ジョブが delayed_job テーブルに登録され、優先度が10であること' do
        expect {
          post api_priority_high_priorities_path, params: { name: 'シナノスイート' }
        }.to change(Delayed::Job, :count).from(0).to(1)

        actual = Delayed::Job.first
        expect(actual).to have_attributes(priority: 10)
      end
    end
  end
end