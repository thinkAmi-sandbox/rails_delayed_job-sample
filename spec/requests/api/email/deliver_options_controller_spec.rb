require 'rails_helper'

RSpec.describe 'Api::Email::DeliverOptionsController', type: :request do
  describe 'POST /api/email/deliver_options' do
    context 'キューに入るかを確認' do
      it 'キュー名「override_queue」というキューに1回だけ入る' do
        # rails 7.0.3 + rspec-rails 5.1.2 だと、以下はエラーになる
        #   NameError:
        #     uninitialized constant ActionMailer::DeliveryJob
        #
        #       job[:job] <= ActionMailer::DeliveryJob
        #                                  ^^^^^^^^^^^^^
        #     Did you mean?  ActionMailer::MailDeliveryJob
        #
        # 以下によると、rspec-railsの6系しか対応していない
        # https://github.com/rspec/rspec-rails/issues/2531
        #
        # そのため、rspec-railsを6.0.0.rc1にして試す
        expect {
          post api_email_deliver_options_path, params: { name: '王林' }
        }.to have_enqueued_mail(HelloWorldMailer, :welcome_email)
               .exactly(1) # 回数
               .on_queue(:override_queue) # キュー名
      end
    end

    context '送信されたメールを確認' do
      it 'メールが1通送信され、中身も想定した通りであること' do
        expect {
          perform_enqueued_jobs do
            post api_email_deliver_options_path, params: { name: 'シナノスイート' }
          end
        }.to change(ActionMailer::Base.deliveries, :count).from(0).to(1)

        actual = ActionMailer::Base.deliveries[0]

        # Rails全体の設定値 config.action_mailer.default_options = { from: 'no-reply@example.com' } ではなく
        # ApplicationMailer で設定した from@example.com が指定されていること
        expect(actual.from).to eq ['from@example.com']

        expect(actual.to).to eq ['bar@example.com']
        expect(actual.subject).to eq 'Hello, world!'

        expect(actual.body).to include('シナノスイート')
        expect(actual.body).to include('Hello, world!')

      end
    end
  end
end
