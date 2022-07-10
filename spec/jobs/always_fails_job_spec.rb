require 'rails_helper'

RSpec.describe 'HeavyQueueJob', type: :job do
  describe '#perform_now' do
    context '失敗の上限になった場合でも、delayed_jobsテーブルにレコードが残ったままになっているか' do
      it 'キューにデータが残り続けていること' do
        expect {
          # キューに入れる
          AlwaysFailJob.perform_later

          # ジョブを2回実行する
          # work_off だと2回目以降でエラーになった場合に Delayed::Job への更新が行われないっぽいので、
          # run() でジョブを明示的に指定して実行する
          Delayed::Worker.new.run(Delayed::Job.first)
          Delayed::Worker.new.run(Delayed::Job.first)

        }.to change(Delayed::Job, :count).from(0).to(1) # テーブルには1件だけ追加されていること

        # ジョブが残っており、2回実行されたこと
        actual = Delayed::Job.first
        expect(actual).to have_attributes(attempts: 2)

        # なお、実際の Delayed::Job Worker と異なり、3回目も実行できる
        Delayed::Worker.new.run(Delayed::Job.first)
        expect(actual.reload).to have_attributes(attempts: 3)
      end
    end
  end
end
