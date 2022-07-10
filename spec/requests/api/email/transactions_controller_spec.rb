require 'rails_helper'

# not_to と and をつなげたいため、 RSpec::Matchers.define_negated_matcher を定義
# 定義しない場合、エラーになる
# NotImplementedError:
#   `expect(...).not_to matcher.and matcher` is not supported, since it creates a bit of an ambiguity.
#   Instead, define negated versions of whatever matchers you wish to negate with `RSpec::Matchers.define_negated_matcher`
#   and use `expect(...).to matcher.and matcher`.
RSpec::Matchers.define_negated_matcher :not_have_enqueued_mail, :have_enqueued_mail
RSpec::Matchers.define_negated_matcher :not_have_enqueued_job, :have_enqueued_job

RSpec.describe 'Api::Email::TransactionsController', type: :request do
  describe 'POST /api/email/transactions' do
    context 'トランザクションでロールバックした場合' do
      context 'キューの確認' do
        it 'メールとジョブを確認すると、キューに形跡はある模様' do
          pending('以下のspecがfailするので、キューには入った形跡がある')

          expect {
            post api_email_transactions_path, params: { name: '王林' }
          }.to not_have_enqueued_mail(HelloWorldMailer, :welcome_email)
                 .and not_have_enqueued_job
        end
      end

      context 'テーブルを確認' do
        before do
          queue_adapter_changed_jobs.each(&:disable_test_adapter)
        end

        it 'ジョブが delayed_job テーブルに登録されていないこと' do
          expect {
            post api_email_transactions_path, params: { name: 'シナノスイート' }
          }.not_to change(Delayed::Job, :count)
        end
      end
    end
  end
end
