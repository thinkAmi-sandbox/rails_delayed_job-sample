require 'rails_helper'

RSpec.describe 'Api::Rollback::ApplesController', type: :request do
  describe 'POST /api/rollback/apples' do
    context 'トランザクションでロールバックした場合' do
      context 'キューの確認' do
        it 'ロールバックしても、メールのキューには入った形跡がある模様' do
          pending('以下のspecがfailするので、キューには入った形跡がある')

          expect {
            post api_rollback_apples_path, params: { name: '王林' }
          }.not_to have_enqueued_job(DefaultQueueJob).with('王林').on_queue('default')
        end
      end

      context 'テーブルを確認' do
        before do
          queue_adapter_changed_jobs.each(&:disable_test_adapter)
        end

        it 'ジョブが delayed_job テーブルに登録されていないこと' do
          expect {
            post api_rollback_apples_path, params: { name: 'シナノスイート' }
          }.not_to change(Delayed::Job, :count)
        end
      end
    end
  end
end
