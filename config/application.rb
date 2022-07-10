require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsDelayedJobSample
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Active Job のバックエンドとして、 delayed_job を使う
    config.active_job.queue_adapter = :delayed_job

    # タイムゾーン設定
    # https://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html
    config.time_zone = 'Tokyo'

    # Action Mailerの設定
    # キュー名を設定
    # https://guides.rubyonrails.org/configuring.html#config-action-mailer-deliver-later-queue-name
    config.action_mailer.deliver_later_queue_name = 'mail_queue'

    # メールの送信者
    config.action_mailer.default_options = { from: 'no-reply@example.com' }
  end
end
