require 'rails_helper'

RSpec.describe 'Api::AlwaysFailJobs::ApplesController', type: :request do
  describe 'POST /api/always_fail_jobs/apples' do
    context '失敗回数の上限に達した場合' do
      before do
        queue_adapter_changed_jobs.each(&:disable_test_adapter)
      end

      it 'キューにデータが残り続けていること' do
        expect {
          post api_always_fail_jobs_apples_path, params: { name: '秋映' }
        }.to change(Delayed::Job, :count).from(0).to(1)

        Delayed::Worker.max_attempts.times do |i|
          # work_off だと2回目以降でエラーになった場合に Delayed::Job への更新が行われないっぽいので、
          # run() でジョブを明示的に指定して実行する
          Delayed::Worker.new.run(Delayed::Job.first)

          expect(Delayed::Job.first).to have_attributes(attempts: i + 1)
        end

        # ちなみに、実際のワーカーと異なり、runではもう一回実行することもできる。この場合は attempts がインクリメントされる
        Delayed::Worker.new.run(Delayed::Job.first)
        expect(Delayed::Job.first).to have_attributes(attempts: 3)
      end
    end
  end
end
